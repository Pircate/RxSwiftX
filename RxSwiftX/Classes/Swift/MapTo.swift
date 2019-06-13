//
//  MapTo+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/22.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    
    func map<T>(to transform: @escaping @autoclosure () throws -> T) -> Observable<T> {
        return map { _ in try transform() }
    }
    
    func flatMap<T>(to transform: @escaping @autoclosure () throws -> Observable<T>) -> Observable<T> {
        return flatMap { _ in try transform() }
    }
}

public extension Driver {
    
    func map<T>(to transform: @escaping @autoclosure () -> T) -> SharedSequence<SharingStrategy, T> {
        return map { _ in transform() }
    }
    
    func flatMap<T>(to transform: @escaping @autoclosure () -> SharedSequence<SharingStrategy, T>) -> SharedSequence<SharingStrategy, T> {
        return flatMap { _ in transform() }
    }
}
