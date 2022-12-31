//
//  File.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import Foundation




extension CGPoint : Hashable{
    public static func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
      }
}
