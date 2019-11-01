//
//  NSObject+ClassName.swift
//  KanaAlamofire
//
//  Created by 横山新 on 2019/03/10.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    
    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
