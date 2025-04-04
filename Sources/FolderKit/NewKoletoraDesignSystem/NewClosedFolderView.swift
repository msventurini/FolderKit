//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 21/05/24.
//

import SwiftUI



public struct NewClosedFolderView: View{
    
    let text: String?
    let color: Color
    let shadow: Color
    
    
    
    @State var propertiesTextOpacity: CGFloat
    @State private var showItems: Bool = false
    
    
    
    @ScaledMetric(relativeTo: .body) var topSizeModifier = 50
    @Environment(\.dynamicTypeSize) private var sizeCategory
    
    @Binding var isOnPerspective: Bool
    @Binding var expansionproportion: CGFloat

    
    public init(text: String? = nil, color: Color, shadow: Color, propertiesTextOpacity: CGFloat = 0, topSizeModifier: Int = 50, isOnPerspective: Binding<Bool>, expansionproportion: Binding<CGFloat>) {
        self.text = text
        self.color = color
        self.shadow = shadow
        self.propertiesTextOpacity = propertiesTextOpacity
        self._isOnPerspective = isOnPerspective
        self._expansionproportion = expansionproportion
        
    }
    
    
    
    public var body: some View {
        
        
        NewFolderShape(expansionproportion: expansionproportion)
            .fill(shadow)
            .strokeBorder(style: .init(lineWidth: isOnPerspective ? 2 : 0), antialiased: true)
            .padding([.top,.leading], (isOnPerspective ? 8 : 0))
            .overlay {
                
                NewFolderShape(expansionproportion: expansionproportion)
                    .fill(color)
                    .strokeBorder(style: .init(lineWidth: isOnPerspective ? 2 : 0), antialiased: true)
//                    .padding([.top,.leading], (isOnPerspective ? 0 : 8))
                    .padding([.trailing, .bottom], (isOnPerspective ? 8 : 0))
                    .frame(maxHeight: (.infinity))
                
            }
            .frame(minWidth: 109, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262 , maxHeight: .infinity, alignment: .center)

    }
    
    
}



#Preview {
    NewClosedFolderView(color: .cyan, shadow: .blue, isOnPerspective: .constant(true), expansionproportion: .constant(0.75))
        .frame(width: 300, height: 400)
        .background(.yellow)
}
