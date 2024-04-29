//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 28/04/24.
//

import SwiftUI

public struct AnimatableFolder: InsettableShape {

    enum FolderPiecePosition {
        case front
        case back
    }
    //faltam os insets da pasta transeira
    
    var topSizeModifier: CGFloat
    var insetAmount: CGFloat
    
    //Insets nos cantos da pasta
    var leftInsetSize: CGFloat
    var bottomInsetSize: CGFloat

    //Rotação de abertura da pasta
    var rotationValue: CGFloat
    
    //Bordas inferiores da pasta
    var bottomCornerValuesProportion: CGFloat

    //Muda tamanho e posição da pasta para manter dentro do frame (tentar separar)
    var topFolderSizeDecrease: CGFloat

    var frontFolderTabSizeDecrease: CGFloat

    var frontFolderDivisionDecrease: CGFloat
    
    
    var frontFolderTranslationRatio: CGFloat
    
    
    
    
    public init(
        topSizeModifier: CGFloat = 0,
        insetAmount: CGFloat = 0,
        leftInsetSize: CGFloat = 0,
        bottomInsetSize: CGFloat = 0,
        rotationValue: CGFloat = 1,
        bottomCornerValuesProportion: CGFloat = 1,
        topFolderSizeDecrease: CGFloat = 0,
        frontFolderTabSizeDecrease: CGFloat = 0,
        frontFolderDivisionDecrease: CGFloat = 0,
        frontFolderTranslationRatio: CGFloat = 0
    ) {
            
        self.topSizeModifier = topSizeModifier
        self.insetAmount = insetAmount
        
        self.leftInsetSize = leftInsetSize
        self.bottomInsetSize = bottomInsetSize
        
        self.rotationValue = rotationValue
        
        self.bottomCornerValuesProportion = bottomCornerValuesProportion
            
        self.topFolderSizeDecrease = topFolderSizeDecrease

        self.frontFolderTabSizeDecrease = frontFolderTabSizeDecrease
        
        self.frontFolderDivisionDecrease = frontFolderDivisionDecrease
        
        self.frontFolderTranslationRatio = frontFolderTranslationRatio
    }

//    deixa a pasta traseira no topo superior
//    topFolderSizeDecrease, vai de 1 a 0.5
    public func path(in rect: CGRect) -> Path {
        

        let referenceSize: CGFloat = 350
        let currentSize: CGFloat = (rect.width)
        let cornerRadius: CGFloat = 24 * (currentSize/referenceSize)
        let tabHeight: CGFloat = 48
        let tabCornerRadius: CGFloat = 18 * (currentSize/referenceSize)
        let textWidth: CGFloat = 82
        
        
        
        let begin = CGPoint(
            x: rect.midX * (1 - frontFolderDivisionDecrease) , y: rect.maxY - bottomInsetSize - (rect.height * topFolderSizeDecrease))
        let end = CGPoint(x: rect.midX + (rect.midX * frontFolderDivisionDecrease) , y: rect.maxY - bottomInsetSize - (rect.height * topFolderSizeDecrease))

        
        
        var downPath = Path()
        downPath.move(to: begin)
        
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.minX + (cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion))),
                    y: rect.maxY - (cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion))) - bottomInsetSize - (rect.height * topFolderSizeDecrease)
                ),
            radius:
                cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion)),
            startAngle:
                Angle(degrees: 90),
            endAngle:
                Angle(degrees: 180),
            clockwise: false
        )
        
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.minX + cornerRadius,
                    y: rect.minY + cornerRadius * (3 - (2 * frontFolderTabSizeDecrease))
                ),
            radius: cornerRadius,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.maxX - cornerRadius * (3 + frontFolderTabSizeDecrease * 2) - textWidth,
                    y: rect.minY + (tabCornerRadius*(3/2 * (1 - frontFolderTabSizeDecrease)))),
            radius: tabCornerRadius * (1 - frontFolderTabSizeDecrease),
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 45 + (45 * frontFolderTabSizeDecrease)),
            clockwise: true
        )
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.maxX - (cornerRadius * (1 - frontFolderTabSizeDecrease)) - (textWidth * (1 - frontFolderTabSizeDecrease*0.5)),
                    y: rect.minY + tabCornerRadius * (1 - frontFolderTabSizeDecrease)),            
            radius: tabCornerRadius * (1 - frontFolderTabSizeDecrease),
            startAngle: Angle(degrees: 225 + (45 * frontFolderTabSizeDecrease)),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )

        downPath.addArc(
            center:
                CGPoint(
                    x: rect.maxX - cornerRadius - leftInsetSize,
                    y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: Angle(degrees: 270),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        
        downPath.addArc(
            center:
                CGPoint(
                    x:
                        rect.maxX - (cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion))) - leftInsetSize,
                    y: rect.maxY - (cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion))) - bottomInsetSize - (rect.height * topFolderSizeDecrease)
                ),
            radius:
                cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion)),
            startAngle:
                Angle(degrees: 0),
            endAngle:
                Angle(degrees: 90),
            clockwise:
                false
        )
        
        downPath.addLine(to: end)


        var path3 = Path()
        
        path3.addPath(downPath, transform: CGAffineTransformConcat(.init(scaleX: 1, y: rotationValue), .init(translationX: 0, y: rect.size.height * frontFolderTranslationRatio)))
        
        //valor inicial = 0
        //valor final = 1

        
        return path3
        
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var folder = self
        folder.insetAmount += amount
        return folder
    }
    
    
}

struct TestingShapes: View {
    
//    @State var frontFolderTabSizeDecrease: CGFloat = 0
    @State var isTapped: Bool = false
    @State var isExpanded: Bool = false
    
    struct AnimationValues {
        var frontFolderLeftInsetSize: CGFloat = 8
        var frontFolderBottomInsetSize: CGFloat = 8
        
        var frontFolderRotationValue: CGFloat = 1
        
        var bottomCornerValuesProportion: CGFloat = 1
        
        var topFolderSizeDecrease: CGFloat = 0
        
        var frontFolderTabSizeDecrease: CGFloat = 0

        var frontFolderDivisionDecrease: CGFloat = 0
        
        var frontFolderTranslationRatio: CGFloat = 0
        
        var maxFrameSizeX: CGFloat = 350
        var maxFrameSizeY: CGFloat = 262
        
    }
    
    var body: some View {
        
        KeyframeAnimator(initialValue: AnimationValues(), trigger: isTapped) { value in
    
            ZStack {
                AnimatableFolder(bottomCornerValuesProportion: value.bottomCornerValuesProportion, topFolderSizeDecrease: value.topFolderSizeDecrease, frontFolderDivisionDecrease: value.frontFolderDivisionDecrease)
                    .fill(.pink)
                    .stroke(.black, lineWidth: 3)
                
                AnimatableFolder(leftInsetSize: value.frontFolderLeftInsetSize, bottomInsetSize: value.frontFolderBottomInsetSize, rotationValue: value.frontFolderRotationValue, bottomCornerValuesProportion: value.bottomCornerValuesProportion, topFolderSizeDecrease: value.topFolderSizeDecrease, frontFolderTabSizeDecrease: value.frontFolderTabSizeDecrease, frontFolderDivisionDecrease: value.frontFolderDivisionDecrease, frontFolderTranslationRatio: value.frontFolderTranslationRatio)
                    .fill(.pink)
                    .stroke(.black, lineWidth: 3)
            }
            
            

                        
                        .background(.blue)
                        .frame(maxWidth: value.maxFrameSizeX, maxHeight: value.maxFrameSizeY)

        } keyframes: { value in
            
            KeyframeTrack(\.maxFrameSizeY) {
                LinearKeyframe(262, duration: 2.5)
                LinearKeyframe(524, duration: 1.0)
                
            }
            
            KeyframeTrack(\.frontFolderLeftInsetSize) {
                LinearKeyframe(8, duration: 0.5)
                LinearKeyframe(4, duration: 0.5)
                LinearKeyframe(0, duration: 0.5)
            }
//            
            KeyframeTrack(\.frontFolderBottomInsetSize) {
                LinearKeyframe(8, duration: 0.5)
                LinearKeyframe(4, duration: 0.5)
                LinearKeyframe(0, duration: 0.5)
            }
            KeyframeTrack(\.frontFolderRotationValue) {
                LinearKeyframe(1, duration: 0.5)
                LinearKeyframe(0.5, duration: 0.5)
                LinearKeyframe(0.0, duration: 0.5)
                LinearKeyframe(-0.5, duration: 0.5)
                LinearKeyframe(-1, duration: 0.5)
            }
//            
            KeyframeTrack(\.bottomCornerValuesProportion) {
                LinearKeyframe(1, duration: 0.5)
                LinearKeyframe(0.5, duration: 0.5)
                LinearKeyframe(0, duration: 0.5)
            }
//
//            
            KeyframeTrack(\.topFolderSizeDecrease) {
                LinearKeyframe(0, duration: 2.5)
                LinearKeyframe(0.25, duration: 0.5)
                LinearKeyframe(0.5, duration: 0.5)
            }
//            
            KeyframeTrack(\.frontFolderTabSizeDecrease) {
                LinearKeyframe(0, duration: 0.75)
                LinearKeyframe(0.25, duration: 0.75)
                LinearKeyframe(0.5, duration: 0.25)
                LinearKeyframe(0.75, duration: 0.15)
                LinearKeyframe(1, duration: 0.05)
            }
            
            KeyframeTrack(\.frontFolderDivisionDecrease) {
                LinearKeyframe(0, duration: 1.5)
                LinearKeyframe(0.5, duration: 0.3)
                LinearKeyframe(1, duration: 0.2)
            }
            
            KeyframeTrack(\.frontFolderTranslationRatio) {
                LinearKeyframe(0, duration: 0.5)
                LinearKeyframe(0.5, duration: 0.5)
                LinearKeyframe(1, duration: 0.5)
                LinearKeyframe(1.5, duration: 0.5)
                LinearKeyframe(2, duration: 0.5)
                LinearKeyframe(1.5, duration: 0.5)
                LinearKeyframe(1.0, duration: 0.5)
            }
            
            
            
            

            
        }
//        .frame(maxWidth: isExpanded ? .infinity : 350, maxHeight: isExpanded ? .infinity : 262)


            .onTapGesture {

                        isTapped.toggle()
            }
            .onChange(of: isTapped) { oldValue, newValue in
//                withAnimation {
//                    if newValue == true {
//                        isExpanded = true
//                    } else {
//                        isExpanded = false
//                    }
//                }
            }
            
        
    }
}


#Preview {
    TestingShapes()
}
