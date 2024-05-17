//
//  FolderView.swift
//  FolderKit
//
//  Created by Matheus Silveira Venturini on 06/04/24.
//


import SwiftUI

public struct FolderView<Content: View>: View{
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
            
            
            Folder(topSizeModifier: 0)
                .fill(shadow)
                .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
            
                .padding([.top, .leading], isClicked ? 0 : 8)
                .overlay {
                    if showItems {
                        content
                            .transition(.identity)
                    }
                }
            
            VStack {
                Spacer(minLength: 0)
                    .layoutPriority(isClicked ? 1 : 0)
                Folder(topSizeModifier: getTopFolderSpacer(fontSize: sizeCategory))
                    .fill(color)
                    .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
                    .padding([.trailing, .bottom], (isClicked ? 0 : 8))
                    .padding([.top, .leading], (isClicked ? 8 : 0))
                    .frame(maxHeight: (isClicked ? 262 : .infinity))
                    .rotation3DEffect(Angle(degrees: (isClicked ? -90 : 0)), axis: (x: 1.0, y: 0.0, z: 0.0), anchor: .bottom, anchorZ: 0, perspective: 1)
                    .layoutPriority(isClicked ? 0 : 1)
                
            }
            
            
            
        }
        .frame(minWidth: 150, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262 , maxHeight: .infinity, alignment: .center)
        .onChange(of: animationOnProgress) { oldValue, newValue in
            withAnimation {
                
                if newValue == true && animationOnProgress == true {
                    showItems = true
                } else {
                    showItems = isClicked && !animationOnProgress
                }
            }
        }
        .onChange(of: isClicked) { oldValue, newValue in
            withAnimation(.linear) {
                if newValue == true && animationOnProgress == true {
                    showItems = true
                } else {
                    showItems = isClicked && !animationOnProgress
                }
            }
        }
        .ignoresSafeArea()
    }
    
    
    func getTopFolderSpacer(fontSize: DynamicTypeSize) -> Double {
        
        switch fontSize {
        case .xSmall:
            12
        case .small:
            16
        case .medium:
            20
        case .large:
            22
        case .xLarge:
            30
        case .xxLarge:
            34
        case .xxxLarge:
            42
        case .accessibility1:
            60
        case .accessibility2:
            78
        case .accessibility3:
            98
        case .accessibility4:
            120
        case .accessibility5:
            140
            
        @unknown default:
            fatalError()
        }
        
        
        //        reeturn 0
    }
    
}



struct testeFolder: View {
    
    @Namespace private var namespace
    
    @State var haveFolderIsClicked: Bool = false
    
    @State var haveFolderIsOpening: Bool = false
    
    @State var buttonIsTapped: Bool = false
    
    var body: some View {
        
        ZStack {
            
            
            
            FolderView(text: "a", color: .cyan, shadow: .blue,  propertiesTextOpacity: 1.0, isClicked: $haveFolderIsClicked, animationOnProgress: $haveFolderIsOpening) {
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
    testeFolder()
    
}

