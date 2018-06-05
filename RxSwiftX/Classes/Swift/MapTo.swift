//
//  MapTo+Rx.swift
//  RxExtension
//
//  Created by Pircate on 2018/5/22.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    
    func map<T>(to element: @escaping @autoclosure () -> T) -> Observable<T> {
        return map { _ in element() }
    }
    
    func flatMap<T>(to element: @escaping @autoclosure () -> Observable<T>) -> Observable<T> {
        return flatMap { _ in element() }
    }
}

public extension SharedSequenceConvertibleType {
    
    func map<T>(to element: @escaping @autoclosure () -> T) -> SharedSequence<SharingStrategy, T> {
        return map { _ in element() }
    }
    
    func flatMap<T>(to element: @escaping @autoclosure () -> SharedSequence<SharingStrategy, T>) -> SharedSequence<SharingStrategy, T> {
        return flatMap { _ in element() }
    }
}
