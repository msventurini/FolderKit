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

public struct NewFolder: InsettableShape {

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
        
        let cornerRadius: CGFloat = 24
        let tabHeight: CGFloat = 48
        
        let begin = CGPoint(x: rect.minX, y: rect.minY + 80)

//        let begin = CGPoint(x: cornerWidth, y: rect.minY + 80)
        
        
        var path = Path()
        path.move(to: begin)
        
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius * 3), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        
        
        
        path.addArc(center: CGPoint(x: cornerRadius * 8, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 0), clockwise: true)
        
        path.addArc(center: CGPoint(x: rect.maxX - (77 + topSizeModifier), y: 6), radius: 6, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

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
    
    var body: some View {
        
        ZStack {
            
            NewFolder(topSizeModifier: topSizeModifier)
                .background {
                    Color.blue
                }
                .scaleEffect(0.9)
            
            Folder(topSizeModifier: topSizeModifier)
                .fill(.yellow)
                .scaleEffect(0.9)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }
        .frame(width: 350, height: 262)
        
        
    }
}

#Preview {
    FolderShapePreview()
}
