//
//  Filter.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/7/9.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift

public extension ObservableType {
    
    func filter(_ predicate: @escaping @autoclosure () throws -> Bool) -> Observable<Element> {
        return filter { _ in try predicate() }
    }
}

public extension PrimitiveSequenceType where Trait == MaybeTrait {
    
    func filter(_ predicate: @escaping @autoclosure () throws -> Bool) -> Maybe<Element> {
        return filter { _ in try predicate() }
    }
}

public extension PrimitiveSequenceType where Trait == SingleTrait {
    
    func filter(_ predicate: @escaping @autoclosure () throws -> Bool) -> Maybe<Element> {
        return filter { _ in try predicate() }
    }
}
