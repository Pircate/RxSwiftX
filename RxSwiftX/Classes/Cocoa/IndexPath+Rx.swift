//
//  IndexPath+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/7/9.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension ObservableType where Element == IndexPath {
    
    func section(_ section: Int) -> Observable<Element> {
        return filter { $0.section == section }
    }
    
    func row(_ row: Int) -> Observable<Element> {
        return filter { $0.row == row }
    }
    
    func item(_ item: Int) -> Observable<Element> {
        return filter { $0.item == item }
    }
}

public extension Driver where Element == IndexPath {
    
    func section(_ section: Int) -> SharedSequence<SharingStrategy, Element> {
        return filter { $0.section == section }
    }
    
    func row(_ row: Int) -> SharedSequence<SharingStrategy, Element> {
        return filter { $0.row == row }
    }
    
    func item(_ item: Int) -> SharedSequence<SharingStrategy, Element> {
        return filter { $0.item == item }
    }
}
