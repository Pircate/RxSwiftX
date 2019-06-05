//
//  ObserveOn.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/7/4.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift

public extension ObservableType {
    
    func observeOnMainScheduler() -> Observable<Element> {
        return observeOn(MainScheduler.instance)
    }
}
