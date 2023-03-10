//
//  SwiftUIView.swift
//  
//
//  Created by MEI YIN LO on 2022/12/31.
//

import SwiftUI
import SwiftUINavigation

public struct PointEditingStatePopoverView: View {
    public var environmentVariables : EnvironmentVariables
    @Binding public var editingState : PointReducer.State.PopoverEditingState
    public init(environmentVariables: EnvironmentVariables, editingState: Binding<PointReducer.State.PopoverEditingState>) {
        self.environmentVariables = environmentVariables
        self._editingState = editingState
    }
    public var body: some View {
        
        Form{
            Section("coordinate") {
                HStack{
                    Text("X: \(Int(editingState.point.x))")
                    Slider(value: $editingState.point.x,
                           in: 0...environmentVariables.canvasSize.width).padding(10)
                }
                HStack{
                    Text("Y: \(Int(editingState.point.y))")
                    Slider(value: $editingState.point.y,
                           in: 0...environmentVariables.canvasSize.height).padding(10)
                }
            }
            Section{
                HStack{
                    ColorPicker("Color", selection: $editingState.color)
                }
                HStack{
                    Text("Size")
                    Slider(value: $editingState.size, in: 2...20).padding(10)
                }
            }
        }
        
        
    }
}

struct PointEditingStatePopoverView_Previews: PreviewProvider {
    static var previews: some View {
        let state = PointReducer.State(point: CGPoint(x: 100, y: 100), size: 10, color: .yellow, id: UUID())
        let editingState = PointReducer.State.PopoverEditingState(from: state)
        WithState(initialValue: editingState) { $value in
            PointEditingStatePopoverView(environmentVariables:  .init(canvasSize: .init(width: 100, height: 100)), editingState: $value)
                
        }
        
    }
}
