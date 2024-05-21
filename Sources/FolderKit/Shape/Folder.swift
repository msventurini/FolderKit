//
//  Folder.swift
//
//
//  Created by Matheus Silveira Venturini on 06/04/24.
//


import SwiftUI



public struct Folder: InsettableShape {

    var topSizeModifier: CGFloat
    var insetAmount: CGFloat = 0
    
    public init(topSizeModifier: CGFloat) {
        self.topSizeModifier = topSizeModifier
    }
    
    public init(topSizeModifier: CGFloat, insetAmount: CGFloat) {
        self.topSizeModifier = topSizeModifier
        self.insetAmount = insetAmount
    }
    
    public func path(in rect: CGRect) -> Path {
        
        
//        let referenceSize: CGFloat = (rect.height < rect.width ? 262 : 350)
        let referenceSize: CGFloat = 350
//        let currentSize: CGFloat = (rect.height < rect.width ? rect.height : rect.width)
        let currentSize: CGFloat = (rect.width) - insetAmount
//        let referenceSize: CGFloat = (rect.height)
        
//        let cornerRadius: CGFloat = 24
        let cornerRadius: CGFloat = 24 * (currentSize/referenceSize)
        
        let tabCornerRadius: CGFloat = 18 * (currentSize/referenceSize)
        
        let textWidth: CGFloat = 82
        
        var minX = rect.minX + insetAmount
        var minY = rect.minY + insetAmount
        var maxX = rect.maxX - insetAmount
        var maxY = rect.maxY - insetAmount
        
        let begin = CGPoint(x: minX, y: maxY - cornerRadius)
        
        var path = Path()
        path.move(to: begin)
        
        
        path.addArc(
            center: CGPoint(
                x: minX + cornerRadius,
                y: minY + cornerRadius * 3),
            radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        path.addArc(
            center: CGPoint(
                x: maxX - cornerRadius*3 - textWidth,
                y: minY + tabCornerRadius + cornerRadius/2),
            radius: tabCornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 45), clockwise: true)
        
        path.addArc(
            center: CGPoint(
                x: maxX - cornerRadius - textWidth,
                y: minY + tabCornerRadius),
            radius: tabCornerRadius, startAngle: Angle(degrees: 225), endAngle: Angle(degrees: 270), clockwise: false)

        path.addArc(
            center: CGPoint(
                x: maxX - cornerRadius,
                y: minY + cornerRadius),
            radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addArc(
            center: CGPoint(
                x: maxX - cornerRadius,
                y: maxY - cornerRadius),
            radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addArc(
            center: CGPoint(
                x: minX + cornerRadius,
                y: maxY - cornerRadius),
            radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.closeSubpath()
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 80))
        
        return path
        
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var folder = self
        folder.insetAmount += amount
        return folder
    }
    
    
}

public struct Folder3DPath: InsettableShape {

    var topSizeModifier: CGFloat
    var insetAmount: CGFloat = 0
    
    
    public init(topSizeModifier: CGFloat) {
        self.topSizeModifier = topSizeModifier
    }
    
    public init(topSizeModifier: CGFloat, insetAmount: CGFloat) {
        self.topSizeModifier = topSizeModifier
        self.insetAmount = insetAmount
    }
    
    public func path(in rect: CGRect) -> Path {
        
        
//        let referenceSize: CGFloat = (rect.height < rect.width ? 262 : 350)
        let referenceSize: CGFloat = 350
//        let currentSize: CGFloat = (rect.height < rect.width ? rect.height : rect.width)
        let currentSize: CGFloat = (rect.width) - insetAmount
//        let referenceSize: CGFloat = (rect.height)
        
//        let cornerRadius: CGFloat = 24
        let cornerRadius: CGFloat = 0.096
        let tabHeight: CGFloat = 48
        let tabCornerRadius: CGFloat = 18 * (currentSize/referenceSize)
        
        let textWidth: CGFloat = 82
        
        let begin = CGPoint(x: rect.minX, y: rect.minY + 80)

//        let begin = CGPoint(x: cornerWidth, y: rect.minY + 80)
        
        
        var path = Path()
        path.move(to: begin)
        
        
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius * 3), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius*3 - textWidth, y: tabCornerRadius + cornerRadius/2), radius: tabCornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 45), clockwise: true)
        
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius - textWidth, y: tabCornerRadius), radius: tabCornerRadius, startAngle: Angle(degrees: 225), endAngle: Angle(degrees: 270), clockwise: false)

        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 80))
        
        return path
        
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var folder = self
        folder.insetAmount += amount
        return folder
    }
    
//    public func getCGPath(in rect: CGRect) -> Path {
////        var folder = self
//        return folder.getCGPath(in: rect)
////        return folder
//    }
    
    
    
}


struct FolderShapePreview: View {
    
    @ScaledMetric(relativeTo: .title) var topSizeModifier = 36
    
    let colorArray: [Color] = [.red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .pink, .brown]
    
    let circleSize: CGFloat = 112
    
    @State var isTapped: Bool = false
    
    private struct AnimationValues {
        var width: CGFloat = 350
        var heigth: CGFloat = 262
    }
    
    var body: some View {
        
        
            
//                .frame(maxWidth: isTapped ? .infinity : 350, maxHeight: isTapped ? .infinity : 262)
//            .stroke()
        Folder(topSizeModifier: topSizeModifier)
            .strokeBorder(style: .init(lineWidth: 2))
                .frame(maxWidth: isTapped ? .infinity : 150, maxHeight: isTapped ? .infinity : 100)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        isTapped.toggle()
                    }
                }
                .background {
                    Color.blue
                }
                .ignoresSafeArea()
            
        

        
        
    }
}

#Preview {
    FolderShapePreview()
//        .frame(width: 150, height: 100)
        .ignoresSafeArea()

}
