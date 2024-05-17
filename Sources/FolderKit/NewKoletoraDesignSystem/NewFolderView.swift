//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 10/05/24.
//

import SwiftUI


public struct NewFolderView<Content: View>: View, Animatable{
    //public struct FolderView: View {
    

    
    
    // Debugando, depois estes voltam
    let text: String?
    let color: Color
    let shadow: Color
    @State var propertiesTextOpacity: CGFloat

    @State private var showItems: Bool = false
    
    
    var folderOffset: CGFloat
    var strokeWidth: CGFloat
    
    
    
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
           AnimatablePair(CGFloat(folderOffset), CGFloat(strokeWidth))
        }

        set {
            folderOffset = CGFloat(newValue.first)
            strokeWidth = CGFloat(newValue.second)
        }
    }
    
    
    let content: Content
    
    
    
    
    public init(text: String? = nil, color: Color, shadow: Color, propertiesTextOpacity: CGFloat = 0, folderOffset: CGFloat = 0, strokeWidth: CGFloat = 0, @ViewBuilder content: () -> Content) {
        self.text = text
        self.color = color
        self.shadow = shadow
        self.propertiesTextOpacity = propertiesTextOpacity
        self.content = content()
        self.folderOffset = folderOffset
        self.strokeWidth = strokeWidth
    }
    
    public var body: some View {
        
        ZStack {
            
            ZStack {
                NewFolderShape(topPadding: folderOffset, rightPadding: folderOffset)
                //mudar essa cor pra um parametro
                    .stroke(.black, lineWidth: strokeWidth)
                    .fill(shadow)
            
                NewFolderShape(bottomPadding: folderOffset, leftPadding: folderOffset)
                    .stroke(.black, lineWidth: strokeWidth)
                    .fill(.green)

            }
            
            
            
            
            
        }
  
    }
    

    
}



//struct testNewFolder: View {
//    
//    @Namespace private var namespace
//    
//    @State var haveFolderIsClicked: Bool = false
//    
//    @State var haveFolderIsOpening: Bool = false
//    
//    @State var buttonIsTapped: Bool = false
//    
//    var body: some View {
//        
//        ZStack {
//            
//            
//            
//            NewFolderView(text: "a", color: .cyan, shadow: .blue,  propertiesTextOpacity: 1.0, folderOffset: buttonIsTapped ? 8 : 0, strokeWidth: buttonIsTapped ? 2 : 0) {
//                Text("oi")
//                
//            }
//            
//            .frame(width : 358, height: 270)
//            .onTapGesture {
//                withAnimation(.smooth) {
//                    buttonIsTapped.toggle()
//                }
//            }
//        }
//    }
//}

//#Preview {
//    testNewFolder()
//    
//}

