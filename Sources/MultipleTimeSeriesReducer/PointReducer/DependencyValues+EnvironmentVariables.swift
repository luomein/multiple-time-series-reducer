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
    var canvasSize : CGSize = .zero
    
}
extension EnvironmentVariables: DependencyKey {
  public static let liveValue = EnvironmentVariables()
}



extension DependencyValues {
  var environmentVariables: EnvironmentVariables {
    get { self[EnvironmentVariables.self] }
    set { self[EnvironmentVariables.self] = newValue }
  }
    
}
