//
//  String+Rx.swift
//  RxSwiftX
//
//  Created by Pircate on 2018/5/31.
//  Copyright © 2018年 Pircate. All rights reserved.
//

import RxSwift

public extension Observable where Element == String {
    
    var isEmpty: Observable<Bool> {
        return map { $0.isEmpty }
    }
}
