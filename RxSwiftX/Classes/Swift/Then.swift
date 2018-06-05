//
//  Then.swift
//  RxSwiftX
//
//  Created by GorXion on 2018/6/5.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> Observable<E> {
        return map {
            closure()
            return $0
        }
    }
}

public extension SharedSequenceConvertibleType {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<SharingStrategy, E> {
        return map {
            closure()
            return $0
        }
    }
}
