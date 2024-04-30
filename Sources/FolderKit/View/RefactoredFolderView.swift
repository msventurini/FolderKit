//
//  SwiftUIView.swift
//
//
//  Created by Matheus Silveira Venturini on 29/04/24.
//

import SwiftUI

//
//  FolderView.swift
//  FolderKit
//
//  Created by Matheus Silveira Venturini on 06/04/24.
//


import SwiftUI

public struct RefactoredFolderView<Content: View, Header: View>: View{
    
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
    let header: Header
    
    public init(text: String? = nil, color: Color, shadow: Color, propertiesTextOpacity: CGFloat = 0, isClicked: Binding<Bool>, animationOnProgress: Binding<Bool>, topSizeModifier: Int = 50, @ViewBuilder content: () -> Content, @ViewBuilder header: () -> Header) {
        self.text = text
        self.color = color
        self.shadow = shadow
        self.propertiesTextOpacity = propertiesTextOpacity
        //porque justamente o underline?
        self._isClicked = isClicked
        self._animationOnProgress = animationOnProgress
        self.content = content()
        self.header = header()
    }
    
    public var body: some View {
        
        ZStack {
            Folder(topSizeModifier: 0)
                .fill(shadow ?? .blue)
                .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
                .padding([.top, .leading], isClicked ? 0 : 8)
        }
        .frame(minWidth: 150, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262 , maxHeight: .infinity, alignment: .center)

        .ignoresSafeArea()
        .overlay {
            ZStack {
                
                ZStack {
                    if isClicked {
                        
                        VStack {
                            
                            header
                            content

                        }
                        .transition(.move(edge: .bottom).combined(with: .scale(2)))
                        .padding(.top, 76)
                        .padding()

                    }
                    
                    
                }
                .ignoresSafeArea()
                .mask(alignment: .center) {
                    Rectangle()
                }
   
            }
            
            VStack {
                Spacer()
                //            if !isClicked {
                                Folder(topSizeModifier: 0)
                                    .fill(color ?? .cyan)
                                    .strokeBorder(style: .init(lineWidth: 2), antialiased: false)
                //                    .transition(.asymmetric(insertion: .slide.combined(with: .move(edge: .bottom)), removal: .slide.combined(with: .move(edge: .bottom))))
                //                    .transition(rotation3DTransition())
                                    .padding([.trailing, .bottom], (isClicked ? 0 : 8))
                                    .frame(maxHeight: (isClicked ? 0 : .infinity))
                                    
                                        .visualEffect { content, geometryProxy in
                                            content
                                                .rotation3DEffect(Angle(degrees: (isClicked ? -90 : 0)), axis: (x: 1.0, y: 0.0, z: 0.0), anchor: .bottom, perspective: 1)

                                        }
                //            }
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
        
    }

    
}



struct testeFolder2: View {
    
    @Namespace private var namespace
    
    @State var haveFolderIsClicked: Bool = false
    
    @State var haveFolderIsOpening: Bool = false
    
    @State var buttonIsTapped: Bool = false
    
    let columns = [
        GridItem(spacing: 8),
        GridItem(spacing: 8)
    ]
    
    var body: some View {
        
        ZStack {
            
                
                RefactoredFolderView(text: "a", color: .cyan, shadow: .blue,  propertiesTextOpacity: 1.0, isClicked: $haveFolderIsClicked, animationOnProgress: $haveFolderIsOpening) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 22) {
    //                        Text("body")
                            Rectangle()
                                .frame(width: 156,height: 212)
                            Rectangle()
                                .frame(width: 156,height: 212)
                            Rectangle()
                                .frame(width: 156,height: 212)
                            Rectangle()
                                .frame(width: 156,height: 212)
                            Rectangle()
                                .frame(width: 156,height: 212)
                            Rectangle()
                                .frame(width: 156,height: 212)
                            Rectangle()
                                .frame(width: 156,height: 212)

                        }
                    }
                    
                    
                } header: {
                    Text("header")
                }
            
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 100).speed(0.7)) {
                    haveFolderIsClicked.toggle()

                }

            }
        }
        .frame(maxWidth: haveFolderIsClicked ? .infinity : 350, maxHeight: haveFolderIsClicked ? .infinity : 270)

//        .frame(minWidth: 150, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262, maxHeight: .infinity, alignment: .center)

    }
}

#Preview {
    testeFolder2()
    
}


struct rotation3DTransition: Transition {
    
    
    
    func body(content: Content, phase: TransitionPhase) -> some View {
        
        
        
        content

            .rotation3DEffect(Angle(degrees: phase.value * 90), axis: (x: 1.0, y: 0.0, z: 0.0), anchor: .bottom, perspective: -1)
                

    }
    
}

