//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 28/04/24.
//

import SwiftUI

public struct AnimatableFolder: InsettableShape {

    var topSizeModifier: CGFloat
    var insetAmount: CGFloat
    var identityInsetProportion: CGFloat
    
    let identityInsetSize: CGFloat = 8
    
    public var animatableData: Double {
        get { identityInsetProportion }
        set { identityInsetProportion = newValue }
    }
    
    public init() {
        self.topSizeModifier = 0
        self.insetAmount = 0
        self.identityInsetProportion = 0
    }
    
    public init(topSizeModifier: CGFloat = 0, insetAmount: CGFloat = 0, identityInsetProportion: CGFloat = 0) {
        self.topSizeModifier = topSizeModifier
        self.insetAmount = insetAmount
        self.identityInsetProportion = identityInsetProportion

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
        
        var currentInset: CGFloat = identityInsetSize * identityInsetProportion
        
        let begin = CGPoint(x: rect.midX, y: rect.maxY - currentInset)
        let end = CGPoint(x: rect.midX, y: rect.maxY - currentInset)

        
        
        var downPath = Path()
        downPath.move(to: begin)
        
        
        downPath.addArc(
            center:
                CGPoint(
                    x: rect.minX + cornerRadius,
                    y: rect.maxY - cornerRadius - currentInset
                ),
            radius:
                cornerRadius,
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

        downPath.addArc(center: CGPoint(x: rect.maxX - cornerRadius - (currentInset), y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        
        downPath.addArc(
            center:
                CGPoint(
                    x:
                        rect.maxX - cornerRadius - currentInset,
                    y:
                        rect.maxY - cornerRadius - currentInset
                ),
            radius:
                cornerRadius,
            startAngle:
                Angle(degrees: 0),
            endAngle:
                Angle(degrees: 90),
            clockwise:
                false
        )
        
        downPath.addLine(to: end)


        var path3 = Path()
        
        path3.addPath(downPath)
        
//        path3.intersection(topPath)
//        path3.addPath(topPath)
        
        return path3
        
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var folder = self
        folder.insetAmount += amount
        return folder
    }
    
    
}

struct TestingShapes: View {
    
    @State var frontFolderTabSizeDecrease: CGFloat = 0
    
    var body: some View {
        
        AnimatableFolder(identityInsetProportion: frontFolderTabSizeDecrease)
            .fill(.pink)
            .stroke(.black, lineWidth: 3)
            .frame(width: 350, height: 262)
            .background(.blue)
            .onTapGesture {
                
                if frontFolderTabSizeDecrease == 0 {
                    withAnimation(.bouncy(extraBounce: -0.1)) {
                        frontFolderTabSizeDecrease = 1
                    }
                } else {
                    withAnimation(.bouncy(extraBounce: -0.1)) {
                        frontFolderTabSizeDecrease = 0
                    }
                }
                
                
            }
            
        
    }
}


#Preview {
    TestingShapes()
}
