//
//  SwiftUIView.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import SwiftUI
import ComposableArchitecture

public struct PointInteractiveView: View {
    @Environment(\.horizontalSizeClass) var hClass
    let store: StoreOf<PointReducer>
    public init(store: StoreOf<PointReducer>) {
        self.store = store
    }
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            let dragGesture = DragGesture().onChanged({gesture in
                viewStore.send(.requestEnvironmentVariables)
                viewStore.send(.point(gesture.location))
                
            })
            let tapGesture = TapGesture().onEnded({ _ in
                viewStore.send(.tap(hClass))
            })
            
            
            let combinedGesture = tapGesture.simultaneously(with: dragGesture)
            
            Circle()
                .fill(viewStore.state.color)
                .frame(width: viewStore.state.size,height: viewStore.state.size )
                .position(viewStore.state.point)
                .gesture(
                    combinedGesture
                )
            
            
        }
    }
}

struct PointInteractiveView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{proxy in
            PointInteractiveView(store: Store(initialState: .init(point: CGPoint(x: 100, y: 100), size: 20, color: .yellow, id: UUID()), reducer: PointReducer()))
        }
    }
}
