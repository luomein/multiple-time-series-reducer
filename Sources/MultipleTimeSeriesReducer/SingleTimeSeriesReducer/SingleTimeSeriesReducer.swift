//
//  File.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import Foundation
import IdentifiedCollections
import ComposableArchitecture

public struct SingleTimeSeriesReducer: ReducerProtocol {
    public init(){
        
    }
    public struct State: Equatable, Identifiable{
        public var id: UUID
        public var timeSeries : IdentifiedArray<PointReducer.State.ID, PointReducer.State>
        public init(id: UUID, timeSeries: IdentifiedArray<PointReducer.State.ID, PointReducer.State>) {
            self.id = id
            self.timeSeries = timeSeries
        }
        public static func initFromOrigin(point: CGPoint, stateId: UUID = UUID(),
                                   pointID: UUID = UUID() )->State{
            return State(id: stateId, timeSeries: IdentifiedArray(uniqueElements: [
                PointReducer.State(point: point, size: 10, color: .black, id: pointID)
            ]))
        }
        public static func initFromOrigin(richPoint: RichPoint, stateId: UUID = UUID(),
                                           pointID: UUID = UUID() )->State{
                    return State(id: stateId, timeSeries: IdentifiedArray(uniqueElements: [
                        PointReducer.State(point: richPoint.point, size: richPoint.size, color: richPoint.color, id: pointID)
                    ]))
                }
    }
    public enum Action : Equatable{
        case notificationPosizitionChanged
        case jointReducerAction(PointReducer.State.ID, PointReducer.Action)
    }
    public var body: some ReducerProtocol<State, Action> {
        Reduce{state, action  in
            switch action{
            case .jointReducerAction(_, let pointAction):
                switch pointAction{
                case .notificationPosizitionChanged:
                    return EffectTask(value: .notificationPosizitionChanged)
                default:
                    return .none
                }
            case .notificationPosizitionChanged:
                return .none
            }
        }
        .forEach(\.timeSeries, action: /Action.jointReducerAction) {
            PointReducer()
        }
    }
}
