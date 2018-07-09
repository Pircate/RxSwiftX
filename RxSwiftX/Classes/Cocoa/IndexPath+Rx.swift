//
//  IndexPath+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/7/9.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift
import RxCocoa

public extension ObservableType where E == IndexPath {
    
    func section(_ section: Int) -> Observable<E> {
        return filter { $0.section == section }
    }
    
    func row(_ row: Int, at section: Int = 0) -> Observable<E> {
        return filter { $0.section == section && $0.row == row }
    }
    
    func item(_ item: Int, at section: Int = 0) -> Observable<E> {
        return filter { $0.section == section && $0.item == item }
    }
}

public extension Driver where E == IndexPath {
    
    func section(_ section: Int) -> SharedSequence<S, E> {
        return filter { $0.section == section }
    }
    
    func row(_ row: Int, at section: Int = 0) -> SharedSequence<S, E> {
        return filter { $0.section == section && $0.row == row }
    }
    
    func item(_ item: Int, at section: Int = 0) -> SharedSequence<S, E> {
        return filter { $0.section == section && $0.item == item }
    }
}
