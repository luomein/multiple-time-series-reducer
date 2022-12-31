//
//  SwiftUIView.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import SwiftUI
import ComposableArchitecture
import LuomeinSwiftBasicTools

public struct PointTextView: View {
    public let store: StoreOf<PointReducer>
    public init(store: StoreOf<PointReducer>) {
        self.store = store
    }
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack{
                Circle()
                    .fill(viewStore.state.color)
                    .frame(width: viewStore.size,height: viewStore.state.size )
                Text("(\(Int(viewStore.point.x)),\(Int(viewStore.point.y)))")
                Spacer()
                Button {
                    viewStore.send(.startPopoverEdit)
                } label: {
                    Text(Image(systemName: "square.on.square"))
                }
                
            }
            
            //Publishing changes from within view updates is not allowed, this will cause undefined behavior.
            
            .popover(unwrapping: viewStore.binding(get: \.popoverEditingState, send: PointReducer.Action.popoverEditing) ) { $value in
                PointEditingStatePopoverView(environmentVariables: viewStore.environmentVariables, editingState: $value)
                    .modifier(FitPopoverViewModifier(width: 300, height: 400))
                    .onAppear{
                        viewStore.send(.requestEnvironmentVariables)
                    }
            }
        }
    }
}
struct PointSampleView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{proxy in
                    PointTextView(store: Store(initialState: .init(point: CGPoint(x: 100, y: 100), size: 30, color: .yellow, id: UUID()), reducer: PointReducer()))
                        
        }

    }
}
