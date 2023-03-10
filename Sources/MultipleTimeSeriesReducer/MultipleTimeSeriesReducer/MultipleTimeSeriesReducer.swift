//
//  File.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import Foundation
import IdentifiedCollections
import ComposableArchitecture

public struct MultipleTimeSeriesReducer: ReducerProtocol {
    public init(){}
    public struct State: Equatable{
        
        
        //var id: UUID
        public var multipleSeries : IdentifiedArray<SingleTimeSeriesReducer.State.ID, SingleTimeSeriesReducer.State>
         = IdentifiedArray(uniqueElements: [] )

        public static func initFromOrigin(points: [CGPoint])->State{
            return State(multipleSeries: IdentifiedArray(uniqueElements: points.map({
                SingleTimeSeriesReducer.State.initFromOrigin(point: $0)
            })))

        }
        public static func initFromOrigin(richPoints: [RichPoint])->State{
            return State(multipleSeries: IdentifiedArray(uniqueElements: richPoints.map({
                SingleTimeSeriesReducer.State.initFromOrigin(richPoint: $0)
            })))
            
        }
        public static func initFromGeometry(size: CGSize)->State{
            let center = CGPoint(x: size.width/2, y: size.height/2)
            let xrange =  Int(size.width/2)
            let yrange = Int(size.height/2)
            let pt1 = CGPoint(x: center.x - Double(Int.random(in: 10...xrange)), y: center.y - Double(Int.random(in: 10...yrange)))
            let pt2 = CGPoint(x: center.x - Double(Int.random(in: 10...xrange)), y: center.y + Double(Int.random(in: 10...yrange)))
            let pt3 = CGPoint(x: center.x + Double(Int.random(in: 10...xrange)), y: center.y + Double(Int.random(in: 10...yrange)))
            let pt4 = CGPoint(x: center.x + Double(Int.random(in: 10...xrange)), y: center.y - Double(Int.random(in: 10...yrange)))
//            print("initFromGeometryProxy")
            return initFromOrigin(points: [pt1,pt2,pt3,pt4])
        }
    }
    public enum Action : Equatable{
        case notificationPosizitionChanged
        case jointReducerAction(SingleTimeSeriesReducer.State.ID, SingleTimeSeriesReducer.Action)
//        case jointLatestPointsReducerAction(PointReducer.State.ID,PointReducer.Action)
    }
    public var body: some ReducerProtocol<State, Action> {
        Reduce{state, action  in
            switch action{
            case .jointReducerAction(_, let subAction):
                switch subAction{
                case .notificationPosizitionChanged:
                    return EffectTask(value: .notificationPosizitionChanged)
                default:
                    return .none
                }
            case .notificationPosizitionChanged:
                return .none
            }
        }
        .forEach(\.multipleSeries, action: /Action.jointReducerAction) {
            SingleTimeSeriesReducer()
        }
//        .forEach(\.latestPoints, action: /Action.jointLatestPointsReducerAction) {
//            PointReducer()
//        }
    }
}
