////
//  ContentView.swift
//  testeUIBezier
//
//  Created by Matheus Silveira Venturini on 23/04/24.
//

import SwiftUI



struct ContentView: View {
    
    var path = Path(Folder(topSizeModifier: 0)
        .path(in: .init(x: 0, y: 0, width: 400, height: 400)).cgPath)
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            Path(Folder(topSizeModifier: 0)
                .path(in: .init(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY, width: 400, height: 400)).cgPath)
            
        }
        
//            .background {
//                Color.blue
//            }
    }
}

#Preview {
    ContentView()
}

public func path(in rect: CGRect) -> Path {
    
    let referenceSize: CGFloat = 350

    let currentSize: CGFloat = (rect.width)

    let cornerRadius: CGFloat = 24 * (currentSize/referenceSize)
    let tabHeight: CGFloat = 48
    let tabCornerRadius: CGFloat = 18 * (currentSize/referenceSize)
    
    let textWidth: CGFloat = 82
    
    let begin = CGPoint(x: rect.minX, y: rect.minY + 80)

    var path = Path()
    path.move(to: begin)
    
    

    path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
    
    path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
    
    path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
    
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 80))
    
    return path
    
}

//extension UIBezierPath {
    /// The Unwrap logo as a Bezier path.
public func folderUIPath(xScale: CGFloat ,yScale: CGFloat) -> UIBezierPath {
//static var logo: UIBezierPath {
        let path = UIBezierPath()
        
        let referenceScale = min(xScale, yScale)
    
//        let begin = CGPoint(x: 0, y: 0.23)
        print(path.bounds.maxX)
        let cornerRadius: CGFloat = 0.07// * (1 / referenceScale)

    let textWidth: CGFloat = 0.23 //* (1/xScale)

        let tabCornerRadius: CGFloat = 0.05// * (1/referenceScale)
    let begin = CGPoint(x: 0, y: (1 - cornerRadius))

        
        path.move(to: begin)
        
        path.addArc(withCenter: CGPointMake(cornerRadius/referenceScale, cornerRadius/referenceScale * xScale), radius: cornerRadius / referenceScale, startAngle: Angle(degrees: 180).radians, endAngle: Angle(degrees: 270).radians, clockwise: true)

        path.addArc(withCenter: CGPointMake(1.0 - cornerRadius * 3 - textWidth, tabCornerRadius + cornerRadius/2), radius: tabCornerRadius, startAngle: Angle(degrees: 90).radians, endAngle: Angle(degrees: 45).radians, clockwise: false)
        
        path.addArc(withCenter: CGPoint(x: 1.0 - cornerRadius - textWidth, y: tabCornerRadius), radius: tabCornerRadius, startAngle: Angle(degrees: 225).radians, endAngle: Angle(degrees: 270).radians, clockwise: true)

        
        path.addArc(withCenter: CGPoint(x: 1.0 - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270).radians, endAngle: Angle(degrees: 0).radians, clockwise: true)
//
        path.addArc(withCenter: CGPoint(x: 1.0 - cornerRadius, y: 1.0 - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0).radians, endAngle: Angle(degrees: 90).radians, clockwise: true)
//
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: 1 - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90).radians, endAngle: Angle(degrees: 180).radians, clockwise: true)
//
        
        
        return path
    }


struct ScaledBezier: Shape {
    let bezierPath: UIBezierPath

    func path(in rect: CGRect) -> Path {
        let path = Path(bezierPath.cgPath)
        
        let multiplierX = rect.width
        let multiplierY = rect.height

        let transform = CGAffineTransform(scaleX: multiplierX, y: multiplierY)

        return path.applying(transform)
    }
}




