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
            
            ZStack {
                Folder(topSizeModifier: 0)
                    .fill(shadow ?? .blue)
                Folder(topSizeModifier: 0)
                    .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
            }
            .padding([.top, .leading], isClicked ? 0 : 8)
            .overlay {
                
                VStack {
                    if showItems {
                        content
                            .transition(.identity)
                    }
                }
                .clipped()
            }
            
            .overlay(alignment: .bottom) {
                ZStack {
                    Folder(topSizeModifier: getTopFolderSpacer(fontSize: sizeCategory))
                        .fill(color ?? .cyan)
                    Folder(topSizeModifier: getTopFolderSpacer(fontSize: sizeCategory))
//                        .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
                        .strokeBorder(style: .init(lineWidth: 2), antialiased: false)

                }
                
                .padding([.trailing, .bottom], (isClicked ? 0 : 8))
                .padding([.top, .leading], (isClicked ? 8 : 0))
                .overlay {
                    
                    if let labelText = text {
                        VStack {
                            HStack {
                                Spacer()
                                
                                Text(labelText)
                                    .font(.title3)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 8)
                                
                                
                                    .background {
                                        CustomRoundedRectangleFolderLabel(color: .white)
                                    }
                                    .padding(.horizontal,24)
                                    .padding(.vertical, 16)
                                
                            }
                            Spacer()
                            
                        }

                        .transition(.opacity)
                    }
                    
                    
//                    .opacity(propertiesTextOpacity)
                    
                    
                    
                }
                .frame(maxHeight: (isClicked ? 0 : .infinity))
                
                
                .rotation3DEffect(Angle(degrees: (isClicked ? -90 : 0)), axis: (x: 1.0, y: 0.0, z: 0.0), anchor: .bottom, perspective: 1)
                
                
//                .onTapGesture {
//                    withAnimation(.interpolatingSpring) {
//                        isClicked = true
//                        animationOnProgress = true
//                        
//                    } completion: {
//                        withAnimation(.smooth) {
//                            animationOnProgress = false
//                        }
//                        
//                        
//                    }
//                }
                
                
                
                
            }
            
            
            
        }
        .frame(minWidth: 150, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262 , maxHeight: .infinity, alignment: .center)
//        .frame(minWidth: 0, idealWidth: 350, maxWidth: isClicked ? .infinity : 350, minHeight: 0, idealHeight: 262, maxHeight: isClicked ? .infinity : 262)
//        .ignoresSafeArea()

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
                    ScrollView {
                        VStack {
                            HStack {
                                
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                
                            }
                            .padding()
                            HStack {
                                
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                
                            }
                            .padding()
                            HStack {
                                
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                
                            }
                            .padding()
                            HStack {
                                
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                Rectangle()
                                    .aspectRatio(150/208, contentMode: .fit)
                                
                            }
                            .padding()
                        }

                    }

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
                        
//                        withAnimation(.bouncy) {
//                            haveFolderIsClicked.toggle()
//                        }
                    }
            

        }
        
        
        
        
    }
    
}

#Preview {
    testeFolder()

}

