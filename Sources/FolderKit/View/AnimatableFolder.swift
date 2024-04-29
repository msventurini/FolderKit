//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 28/04/24.
//

import SwiftUI

public struct FrontFolder: InsettableShape {

    
    
    var topSizeModifier: CGFloat
    var insetAmount: CGFloat
    
    //Insets nos cantos da pasta
    var leftInsetSize: CGFloat
    var bottomInsetSize: CGFloat

    //Rotação de abertura da pasta
    var rotationValue: CGFloat
    
    //Bordas inferiores da pasta
    var bottomCornerValuesProportion: CGFloat


    
    public init(topSizeModifier: CGFloat = 0, insetAmount: CGFloat = 0, leftInsetSize: CGFloat = 8, bottomInsetSize: CGFloat = 8, rotationValue: CGFloat = 0, bottomCornerValuesProportion: CGFloat = 0) {
        self.topSizeModifier = topSizeModifier
        self.insetAmount = insetAmount
        
        self.leftInsetSize = leftInsetSize
        self.bottomInsetSize = bottomInsetSize
        
        self.rotationValue = rotationValue
        
        self.bottomCornerValuesProportion = bottomCornerValuesProportion
        

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
        
        
        
        let begin = CGPoint(x: rect.midX, y: rect.maxY - bottomInsetSize)
        let end = CGPoint(x: rect.midX, y: rect.maxY - bottomInsetSize)

        
        
        var downPath = Path()
        downPath.move(to: begin)
        
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.minX + (cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion))),
                    y: rect.maxY - (cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion))) - bottomInsetSize
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
                    y: rect.minY + cornerRadius * 3
                ),
            radius: cornerRadius,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.maxX - cornerRadius * (3) - textWidth,
                    y: rect.minY + (tabCornerRadius*(3/2))),
            radius: tabCornerRadius,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 45),
            clockwise: true
        )
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.maxX - cornerRadius - textWidth,
                    y: rect.minY + tabCornerRadius),
            radius: tabCornerRadius,
            startAngle: Angle(degrees: 225),
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
                    y:
                        rect.maxY - (cornerRadius - (cornerRadius * (1 - bottomCornerValuesProportion))) - bottomInsetSize
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
        
        path3.addPath(downPath, transform: CGAffineTransformConcat(.init(scaleX: 1, y: rotationValue), .init(translationX: 0, y: rect.size.height * (1 - rotationValue))))
        
//
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
    struct AnimationValues {
        var frontFolderLeftInsetSize: CGFloat = 8
        var frontFolderBottomInsetSize: CGFloat = 8
        
        var frontFolderRotationValue: CGFloat = 1
        var bottomCornerValuesProportion: CGFloat = 1
    }
    
    var body: some View {
        
        KeyframeAnimator(initialValue: AnimationValues(), trigger: isTapped) { value in
            
            FrontFolder(leftInsetSize: value.frontFolderLeftInsetSize, bottomInsetSize: value.frontFolderBottomInsetSize, rotationValue: value.frontFolderRotationValue, bottomCornerValuesProportion: value.bottomCornerValuesProportion)
                        .fill(.pink)
                        .stroke(.black, lineWidth: 3)
                        .frame(width: 350, height: 262)
                        .background(.blue)
        } keyframes: { value in
            KeyframeTrack(\.frontFolderLeftInsetSize) {
                CubicKeyframe(8, duration: 0.5)
                CubicKeyframe(4, duration: 0.3)
                CubicKeyframe(0, duration: 0.2)
            }
            
            KeyframeTrack(\.frontFolderBottomInsetSize) {
                CubicKeyframe(8, duration: 0.5)
                CubicKeyframe(4, duration: 0.3)
                CubicKeyframe(0, duration: 0.2)
            }
            KeyframeTrack(\.frontFolderRotationValue) {
                CubicKeyframe(1, duration: 0.5)
                CubicKeyframe(0.0, duration: 0.3)
                CubicKeyframe(-1, duration: 0.2)
            }
            
            KeyframeTrack(\.bottomCornerValuesProportion) {
                CubicKeyframe(1, duration: 0.5)
                CubicKeyframe(0.5, duration: 0.3)
                CubicKeyframe(0, duration: 0.2)
            }
        }

            .onTapGesture {

                        isTapped.toggle()
            }
            
        
    }
}


#Preview {
    TestingShapes()
}
