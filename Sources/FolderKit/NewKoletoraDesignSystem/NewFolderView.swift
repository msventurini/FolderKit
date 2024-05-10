//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 10/05/24.
//

import SwiftUI


public struct NewFolderView<Content: View>: View{
    //public struct FolderView: View {
    
    // Debugando, depois estes voltam
    let text: String?
    let color: Color
    let shadow: Color
    @State var propertiesTextOpacity: CGFloat
    @Binding var isClicked: Bool
    @Binding var animationOnProgress: Bool
    @State private var showItems: Bool = false
    
    @ScaledMetric(relativeTo: .body) var topSizeModifier = 50
    @Environment(\.dynamicTypeSize) private var sizeCategory
    
    
    let content: Content
    
    public init(text: String? = nil, color: Color, shadow: Color, propertiesTextOpacity: CGFloat = 0, isClicked: Binding<Bool>, animationOnProgress: Binding<Bool>, topSizeModifier: Int = 50, @ViewBuilder content: () -> Content) {
        self.text = text
        self.color = color
        self.shadow = shadow
        self.propertiesTextOpacity = propertiesTextOpacity
        //porque justamente o underline?
        self._isClicked = isClicked
        self._animationOnProgress = animationOnProgress
        self.content = content()
    }
    
    public var body: some View {
        
        ZStack {
            
            ZStack {
                NewFolderShape(topPadding: 8, rightPadding: 8)
                //mudar essa cor pra um parametro
                    .stroke(.black, lineWidth: 2)
                    .fill(shadow)
            
                NewFolderShape(bottomPadding: 8, leftPadding: 8)
                    .stroke(.black, lineWidth: 2)
                    .fill(.green)

            }
            
            
            
            
            
        }
  
    }
    

    
}



struct testNewFolder: View {
    
    @Namespace private var namespace
    
    @State var haveFolderIsClicked: Bool = false
    
    @State var haveFolderIsOpening: Bool = false
    
    @State var buttonIsTapped: Bool = false
    
    var body: some View {
        
        ZStack {
            
            
            
            NewFolderView(text: "a", color: .cyan, shadow: .blue,  propertiesTextOpacity: 1.0, isClicked: $haveFolderIsClicked, animationOnProgress: $haveFolderIsOpening) {
                Text("oi")
                
            }
            .matchedGeometryEffect(id: "have", in: namespace)
            //                    .transition(.scale(1))
            .frame(maxWidth: haveFolderIsClicked ? .infinity : 350, maxHeight: haveFolderIsClicked ? .infinity : 270)
            .onTapGesture {
                
                var transaction = Transaction(animation: .bouncy)
                
                transaction.disablesAnimations = true
                
                withTransaction(transaction) {
                    haveFolderIsClicked.toggle()
                }
            }
        }
    }
}

#Preview {
    testNewFolder()
    
}

