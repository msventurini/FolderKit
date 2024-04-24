////
//  ContentView.swift
//  testeUIBezier
//
//  Created by Matheus Silveira Venturini on 23/04/24.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        
        
        
        ScaledBezier(bezierPath: .logo)
//            .aspectRatio(contentMode: .fit)
            .stroke(lineWidth: 2)
            
            .frame(width: 200, height: 500)
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

extension UIBezierPath {
    /// The Unwrap logo as a Bezier path.
    static var logo: UIBezierPath {
        let path = UIBezierPath()
        
//        let begin = CGPoint(x: 0, y: 0.23)
        print(path.bounds.midX)
        let cornerRadius: CGFloat = 0.07

        let textWidth: CGFloat = 0.23

        let tabCornerRadius: CGFloat = 0.05
        let begin = CGPoint(x: 0, y: 1 - cornerRadius)

        
        path.move(to: begin)
        
        path.addArc(withCenter: CGPointMake(cornerRadius, cornerRadius * 3), radius: cornerRadius, startAngle: Angle(degrees: 180).radians, endAngle: Angle(degrees: 270).radians, clockwise: true)

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



struct LabelView: UIViewRepresentable {
     var text: String

    func makeUIView(context: Context) -> UILabel {
        let v = UILabel()
        v.text = text
        return v
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        
    }
}
