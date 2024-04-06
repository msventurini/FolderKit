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


struct FolderShapePreview: View {
    
    @ScaledMetric(relativeTo: .title) var topSizeModifier = 36
    
    var body: some View {
        Folder(topSizeModifier: topSizeModifier)
            .background {
                Color.blue
            }
            .scaleEffect(0.9)
    }
}

#Preview {
    FolderShapePreview()
}
