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
    
    public init(text: String? = nil, color: Color, shadow: Color, propertiesTextOpacity: CGFloat = 0, topSizeModifier: Int = 50) {
        self.text = text
        self.color = color
        self.shadow = shadow
        self.propertiesTextOpacity = propertiesTextOpacity
        
    }
    
    public var body: some View {
        
        
        NewFolderShape()
            .fill(shadow)
            .strokeBorder(style: .init(lineWidth: 2), antialiased: true)
            .padding([.top,.leading], 8)
            .overlay {
                
                NewFolderShape()
                    .fill(color)
                    .strokeBorder(style: .init(lineWidth: 2), antialiased: true)
                    .padding([.trailing, .bottom], (8))
                    .frame(maxHeight: (.infinity))
                
            }
            .frame(minWidth: 150, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262 , maxHeight: .infinity, alignment: .center)
        
    }
    
    
}



#Preview {
    NewClosedFolderView(color: .cyan, shadow: .blue)
        .frame(width: 300, height: 400)
        .background(.yellow)
}
