//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 17/05/24.
//

import SwiftUI


public struct ClosedFolderView: View{
    
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
        
        
        Folder(topSizeModifier: 0)
            .fill(shadow)
            .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
            .padding([.top,.leading], 8)
            .overlay {
                
                Folder(topSizeModifier: 0)
                    .fill(color)
                    .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
                    .padding([.trailing, .bottom], (8))
                    .frame(maxHeight: (.infinity))
                
            }
            .frame(minWidth: 150, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262 , maxHeight: .infinity, alignment: .center)
        
    }
    
    
}



#Preview {
    ClosedFolderView(color: .cyan, shadow: .blue)
        .frame(width: 300, height: 400)
        .background(.yellow)
}
