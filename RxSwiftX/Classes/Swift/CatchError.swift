//
//  CatchError.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/6/4.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension ObservableConvertibleType {
    
    func catchErrorJustReturn(closure: @escaping @autoclosure () throws -> Element) -> Observable<Element> {
        return asObservable().catchError { _ in
            return Observable.just(try closure())
        }
    }
    
    func catchErrorJustComplete() -> Observable<Element> {
        return asObservable().catchError { _ in
            Observable.empty()
        }
    }
}

public extension ObservableConvertibleType {
    
    func asDriver(onErrorJustReturnClosure: @escaping @autoclosure () -> Element) -> Driver<Element> {
        return asDriver { _ in
            Driver.just(onErrorJustReturnClosure())
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            Driver.empty()
        }
    }
}
