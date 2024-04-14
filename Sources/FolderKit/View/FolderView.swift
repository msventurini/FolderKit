//
//  FolderView.swift
//  FolderKit
//
//  Created by Matheus Silveira Venturini on 06/04/24.
//


import SwiftUI

public struct FolderView<Content>: View{
//public struct FolderView: View {
    
    // Debugando, depois estes voltam
    let text: String
    let color: Color
    let shadow: Color
    let propertiesTextOpacity: CGFloat
    @Binding var isClicked: Bool
    @Binding var animationOnProgress: Bool
    @State private var showItems: Bool = false
    
    @ScaledMetric(relativeTo: .body) var topSizeModifier = 50
    @Environment(\.dynamicTypeSize) private var sizeCategory
    
    
    let content: Content

    public init(text: String, color: Color, shadow: Color, propertiesTextOpacity: CGFloat, isClicked: Binding<Bool>, animationOnProgress: Binding<Bool>, topSizeModifier: Int = 50, @ViewBuilder content: () -> Content) {
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
            .padding(.top, isClicked ? 0 : 8)
            .overlay {
                
                VStack {
                    
                    if isClicked {
                        HStack {
                            BackButton()
                                .onTapGesture {
                                    withAnimation(.smooth) {
                                        isClicked = false
                                        animationOnProgress = true
                                        
                                    } completion: {
                                        withAnimation(.smooth) {
                                            animationOnProgress = false
                                        }
                                        
                                        
                                    }
                                }
                            
                            Spacer()
                        }
                        .padding(.top, 60)
                        .padding(.horizontal, 16)
                        .transition(.asymmetric(insertion: .push(from: .bottom).combined(with: .opacity), removal: .push(from: .top).combined(with: .opacity)))

                    }
                    
                    
                    
                    
                    if showItems {
//                        content()
                        Text("oi")
                    }
                }
            }
            
            .overlay(alignment: .bottom) {
                ZStack {
                    Folder(topSizeModifier: getTopFolderSpacer(fontSize: sizeCategory))
                        .fill(color ?? .cyan)
                    Folder(topSizeModifier: getTopFolderSpacer(fontSize: sizeCategory))
                        .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
                }
                
                .padding([.trailing, .bottom], (isClicked ? 0 : 8))
                .padding([.top, .leading], (isClicked ? 8 : 0))
                .overlay {
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text(text ?? "teste")
                                .font(.title3)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 8)
                            
                            
                                .background {
                                    CustomRoundedRectangleFolderLabel(color: .white)
                                        .contentTransition(.interpolate)
                                }
                                .padding(.horizontal,24)
                                .padding(.vertical, 16)
                            
                        }
                        Spacer()
                        
                    }
                    .opacity(propertiesTextOpacity)
                    
                    
                    
                }
                .frame(maxHeight: (isClicked ? 0 : .infinity))
                
                
                .rotation3DEffect(Angle(degrees: (isClicked ? -90 : 0)), axis: (x: 1.0, y: 0.0, z: 0.0), anchor: .bottom, perspective: 1)
                
                
                .onTapGesture {
                    withAnimation(.smooth) {
                        isClicked = true
                        animationOnProgress = true
                        
                    } completion: {
                        withAnimation(.smooth) {
                            animationOnProgress = false
                        }
                        
                        
                    }
                }
                
                
                
                
            }
            
            
            
        }
        
        .ignoresSafeArea()
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
            withAnimation {
                if newValue == true && animationOnProgress == true {
                    showItems = true
                } else {
                    showItems = isClicked && !animationOnProgress
                }
                
            }
            
        }
        
        
        
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
            
            
            
            if (buttonIsTapped) {
                FolderView(text: "a", color: .cyan, shadow: .blue,  propertiesTextOpacity: 1.0, isClicked: $haveFolderIsClicked, animationOnProgress: $haveFolderIsOpening) {
                    Text("oi")

                }
                    .matchedGeometryEffect(id: "have", in: namespace)
                    .transition(.scale(1))

                    .padding(.top, 240)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 334)
                    .offset(y: 200)

            } else {
                FolderView(text: "a", color: .cyan, shadow: .blue,  propertiesTextOpacity: 1.0, isClicked: $haveFolderIsClicked, animationOnProgress: $haveFolderIsOpening) {
                    Text("oi")

                }
                    .matchedGeometryEffect(id: "have", in: namespace)
                    .transition(.scale(1))


                    
                    
                    
            }
            
            
            
            Button {
                withAnimation(.easeInOut) {
                    buttonIsTapped.toggle()
                }
            } label: {
                Text("teste")
            }
            

        }
        
        
        
        
    }
    
}

#Preview {
    testeFolder()
}

