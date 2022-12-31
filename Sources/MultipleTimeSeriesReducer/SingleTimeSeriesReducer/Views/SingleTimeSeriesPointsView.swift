//
//  SwiftUIView.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import SwiftUI
import ComposableArchitecture

public struct SingleTimeSeriesPointsView: View{
    public let store: StoreOf<SingleTimeSeriesReducer>
    public init(store: StoreOf<SingleTimeSeriesReducer>) {
        self.store = store
    }
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack{
                ForEachStore(store.scope(state: \.timeSeries, action: {SingleTimeSeriesReducer.Action.jointReducerAction($0.0,$0.1) })) { singleStore in
                    PointInteractiveView(store: singleStore)
                                    }
                                }
        }
    }
}

//struct SingleTimeSeriesPointsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleTimeSeriesPointsView()
//    }
//}
