//
//  File.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import Foundation
import ComposableArchitecture
import SwiftUI

public struct PointReducer: ReducerProtocol {
    @Dependency(\.environmentVariables) var environmentVariables
    public init(){
        
    }
    public struct State: Equatable, Identifiable{
        public var point : CGPoint
        public var size : Double
        public var color : Color
        public var id: UUID
        public var popoverEditingState: PopoverEditingState?
        public var environmentVariables: EnvironmentVariables = .init()
        
        public init(point: CGPoint, size: Double, color: Color, id: UUID, popoverEditingState: PopoverEditingState? = nil, environmentVariables: EnvironmentVariables = .init()) {
            self.point = point
            self.size = size
            self.color = color
            self.id = id
            self.popoverEditingState = popoverEditingState
            self.environmentVariables = environmentVariables
        }
        
        public struct PopoverEditingState: Equatable{
            public var point : CGPoint
            public var size : Double
            public var color : Color
            
            public func updateState( state: inout State){
                state.point = self.point
                state.size = self.size
                state.color = self.color
            }
            public init(from state: State){
                self.point = state.point
                self.color = state.color
                self.size = state.size
            }
        }
    }
    public enum Action : Equatable{
        case point(CGPoint)
        case size(Double)
        case color(Color)
        case tap(UserInterfaceSizeClass?)
        case startPopoverEdit
        case popoverEditing(State.PopoverEditingState?)
        case requestEnvironmentVariables
        case notificationPosizitionChanged
    }
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action{
        case .point(let value):
            state.point = CGPoint(x: max(0,min(value.x, environmentVariables.canvasSize.width) ),
                                  y: max(0,min(value.y, environmentVariables.canvasSize.height)) ) //value
            return EffectTask(value: .notificationPosizitionChanged)
        case .size(let value):
            state.size = value
            return .none
        case .color(let value):
            state.color = value
            return .none
        case .startPopoverEdit:
            state.popoverEditingState = State.PopoverEditingState(from: state)
            return .none
        case .popoverEditing(let value):
            state.popoverEditingState = value
            if let value = value{
                let positionChanged = (value.point != state.point)
                value.updateState(state: &state)
                if positionChanged{ return EffectTask(value: .notificationPosizitionChanged) }
            }
            return .none
        case .tap(let hClass):
            if let hClass = hClass, hClass == .regular{
                return EffectTask(value: .startPopoverEdit)
            }
            return .none
        case .requestEnvironmentVariables:
            state.environmentVariables = environmentVariables
            //print("requestEnvironmentVariables", environmentVariables)
            return .none
        case .notificationPosizitionChanged:
            return .none
        }
    }
}
