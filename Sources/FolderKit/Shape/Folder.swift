//
//  Folder.swift
//
//
//  Created by Matheus Silveira Venturini on 06/04/24.
//


import SwiftUI

public struct OldFolder: InsettableShape {

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
        
        let begin = CGPoint(x: rect.minX, y: rect.minY + 80)
        
        
        var path = Path()
        path.move(to: begin)
        
        path.addArc(center: CGPoint(x: 40, y: 70), radius: 40, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.maxX - (103 + topSizeModifier), y: 10), radius: 20, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true)
        
        path.addArc(center: CGPoint(x: rect.maxX - (77 + topSizeModifier), y: 6), radius: 6, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        path.addArc(center: CGPoint(x: rect.maxX - 40, y: 40), radius: 40, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.maxX - 40, y: rect.maxY - 40), radius: 40, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.minX + 40, y: rect.maxY - 40), radius: 40, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 80))
        
        return path
        
    }
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var folder = self
        folder.insetAmount += amount
        return folder
    }
    
}

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
        
        
        let referenceSize: CGFloat = (rect.height < rect.width ? 262 : 350)
        let currentSize: CGFloat = (rect.height < rect.width ? rect.height : rect.width)
//        let referenceSize: CGFloat = (rect.height)
        
//        let cornerRadius: CGFloat = 24
        let cornerRadius: CGFloat = 24 * (currentSize/referenceSize)
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
        
        GeometryReader { geometry in
            
            Folder(topSizeModifier: topSizeModifier)
                .frame(maxWidth: isTapped ? .infinity : 350, maxHeight: isTapped ? .infinity : 262)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        isTapped.toggle()
                    }
                }
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                .background {
                    Color.blue
                }
                .ignoresSafeArea()
            
        }

        
        
    }
}

#Preview {
    FolderShapePreview()
        .ignoresSafeArea()

}
