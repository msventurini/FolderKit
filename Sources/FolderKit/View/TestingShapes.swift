//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 28/04/24.
//

import SwiftUI

public struct Folder3: InsettableShape {

    var topSizeModifier: CGFloat
    var insetAmount: CGFloat
    var rotationValue: CGFloat
    
    public var animatableData: Double {
        get { rotationValue }
        set { rotationValue = newValue }
    }
    
    public init() {
        self.topSizeModifier = 0
        self.insetAmount = 0
        self.rotationValue = 0
    }
    
    public init(topSizeModifier: CGFloat = 0, insetAmount: CGFloat = 0, rotationValue: CGFloat = 0) {
        self.topSizeModifier = topSizeModifier
        self.insetAmount = insetAmount
        self.rotationValue = rotationValue

    }
    
    public func path(in rect: CGRect) -> Path {
        

        let referenceSize: CGFloat = 350
        let currentSize: CGFloat = (rect.width)
        let cornerRadius: CGFloat = 24 * (currentSize/referenceSize)
        let tabHeight: CGFloat = 48
        let tabCornerRadius: CGFloat = 18 * (currentSize/referenceSize)
        let textWidth: CGFloat = 82
        let begin = CGPoint(x: rect.minX, y: rect.maxY - cornerRadius)

        var downPath = Path()
        downPath.move(to: begin)
        
        downPath.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius * 3), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        downPath.addArc(center: CGPoint(x: rect.maxX - cornerRadius*3 - textWidth, y: rect.minY + tabCornerRadius + cornerRadius/2), radius: tabCornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 45), clockwise: true)
        
        downPath.addArc(center: CGPoint(x: rect.maxX - cornerRadius - textWidth, y: rect.minY + tabCornerRadius), radius: tabCornerRadius, startAngle: Angle(degrees: 225), endAngle: Angle(degrees: 270), clockwise: false)

        downPath.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        
        downPath.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        downPath.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        var topPath = Path()

        topPath.addPath(downPath, transform: CGAffineTransformConcat(.init(scaleX: 1, y: rotationValue), .init(translationX: 0, y: rect.size.height * (1 - rotationValue))))
        
        var path3 = Path()
        
        path3.addPath(downPath)
        path3.addPath(topPath)
        
        return path3
        
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var folder = self
        folder.insetAmount += amount
        return folder
    }
    
    
}


struct TestingShapes: View {
    
    @State var rotationValue: CGFloat = 0
    
    var body: some View {
        
        Folder3(rotationValue: rotationValue)
            .fill(.pink)
            .stroke(.black, lineWidth: 3)
            .frame(width: 350, height: 262)
            .background(.blue)
            .onTapGesture {
                
                if rotationValue == 0 {
                    withAnimation {
                        rotationValue = 1
                    }
                } else {
                    withAnimation {
                        rotationValue = 0
                    }
                }
                
                
            }
            
        
    }
}

#Preview {
    TestingShapes()
}
