//
//  RichPoint.swift
//  tca-bezier-animation
//
//  Created by MEI YIN LO on 2022/12/21.
//

import Foundation
import SwiftUI


public struct  RichPoint : Codable{
    public var point : CGPoint
    public var size : Double
    public var color : Color
    public init(point: CGPoint, size: Double, color: Color) {
        self.point = point
        self.size = size
        self.color = color
    }
    public static func encodedFromState(state: [PointReducer.State])->Data{
        let encoder = JSONEncoder()
        do{
            return try encoder.encode(state.map({
                RichPoint(point: $0.point, size: $0.size, color: $0.color)
            }))
        }catch{
            fatalError()
        }
    }
}

