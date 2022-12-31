//
//  File.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import Foundation

import SwiftUI
import ComposableArchitecture

public struct EnvironmentVariables : Equatable {
    public var canvasSize : CGSize = .zero
    public init(canvasSize: CGSize = .zero) {
        self.canvasSize = canvasSize
    }
}
extension EnvironmentVariables: DependencyKey {
  public static let liveValue = EnvironmentVariables()
}



extension DependencyValues {
  public var environmentVariables: EnvironmentVariables {
    get { self[EnvironmentVariables.self] }
    set { self[EnvironmentVariables.self] = newValue }
  }
    
}
