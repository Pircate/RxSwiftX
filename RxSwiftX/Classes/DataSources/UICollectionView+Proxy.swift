//
//  UICollectionView+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/6/4.
//

import RxSwift
import RxCocoa

public typealias UICollectionViewProxy = UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

public extension Reactive where Base: UICollectionView {
    
    func items<Proxy: RxCollectionViewDataSourceType & UICollectionViewProxy, O: ObservableType>(
        proxy: Proxy
    ) -> (_ source: O) -> Disposable where Proxy.Element == O.Element {
        return { source in
            return source.subscribeCollectionViewProxy(
                self.base,
                proxy: proxy,
                retainProxy: true
            ) {  [weak collectionView = self.base] (_, _, event) in
                guard let collectionView = collectionView else { return }
                
                proxy.collectionView(collectionView, observedEvent: event)
            }
        }
    }
}

extension ObservableType {
    
    func subscribeCollectionViewProxy(
        _ collectionView: UICollectionView,
        proxy: UICollectionViewProxy,
        retainProxy: Bool,
        binding: @escaping (RxCollectionViewDataSourceProxy, RxCollectionViewDelegateProxy, Event<Element>) -> Void
    ) -> Disposable {
        let dataSourceProxy = RxCollectionViewDataSourceProxy.proxy(for: collectionView)
        let delegateProxy = RxCollectionViewDelegateProxy.proxy(for: collectionView)
        
        let unregisterDataSource = RxCollectionViewDataSourceProxy.installForwardDelegate(proxy, retainDelegate: retainProxy, onProxyForObject: collectionView)
        let unregisterDelegate = RxCollectionViewDelegateProxy.installForwardDelegate(proxy, retainDelegate: retainProxy, onProxyForObject: collectionView)
        
        // this is needed to flush any delayed old state (https://github.com/RxSwiftCommunity/RxDataSources/pull/75)
        collectionView.layoutIfNeeded()
        
        let subscription = self.asObservable()
            .observeOn(MainScheduler())
            .catchError { error in
                bindingError(error)
                return Observable.empty()
            }
            // source can never end, otherwise it would release the subscriber, and deallocate the data source
            .concat(Observable.never())
            .takeUntil(collectionView.rx.deallocated)
            .subscribe { [weak collectionView] (event: Event<Element>) in
                
                if let collectionView = collectionView {
                    assert(dataSourceProxy === RxCollectionViewDataSourceProxy.currentDelegate(for: collectionView), "Proxy changed from the time it was first set.\nOriginal: \(dataSourceProxy)\nExisting: \(String(describing: RxCollectionViewDataSourceProxy.currentDelegate(for: collectionView)))")
                    assert(delegateProxy === RxCollectionViewDelegateProxy.currentDelegate(for: collectionView), "Proxy changed from the time it was first set.\nOriginal: \(delegateProxy)\nExisting: \(String(describing: RxCollectionViewDelegateProxy.currentDelegate(for: collectionView)))")
                }
                
                binding(dataSourceProxy, delegateProxy, event)
                
                switch event {
                case .error(let error):
                    bindingError(error)
                    unregisterDataSource.dispose()
                    unregisterDelegate.dispose()
                case .completed:
                    unregisterDataSource.dispose()
                    unregisterDelegate.dispose()
                default:
                    break
                }
        }
        
        return Disposables.create { [weak collectionView] in
            subscription.dispose()
            collectionView?.layoutIfNeeded()
            unregisterDataSource.dispose()
            unregisterDelegate.dispose()
        }
    }
}

fileprivate func bindingError(_ error: Swift.Error) {
    let error = "Binding error: \(error)"
    #if DEBUG
    fatalError(error)
    #else
    print(error)
    #endif
}
