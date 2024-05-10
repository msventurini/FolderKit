//
//  SwiftUIView.swift
//
//
//  Created by Matheus Silveira Venturini on 10/05/24.
//

import SwiftUI

struct NewFolderShape: Shape {
    
    
    var topPadding: CGFloat = 0
    var bottomPadding: CGFloat = 0
    var rightPadding: CGFloat = 0
    var leftPadding: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        
        let referenceWidth: CGFloat = 109
        
        let currentSize: CGFloat = (rect.width)
        
        let cornerRadius: CGFloat = 8 * (currentSize/referenceWidth)
        
        let tabContentWidth: CGFloat = 22 * (currentSize/referenceWidth)
        
        
        let minX = rect.minX + rightPadding
        let maxX = rect.maxX - leftPadding
        
        let minY = rect.minY + topPadding
        let maxY = rect.maxY - bottomPadding
        
        
        
        let begin = CGPoint(
            x: minX,
            y: rect.maxY - cornerRadius
        )
        
        let topLeftArcCenter = CGPoint(
            x: minX + cornerRadius,
            y: minY + cornerRadius * 3
        )
        
        let tabBottomArcCenter = CGPoint(
            x: maxX - (cornerRadius * 3) - tabContentWidth,
            y: minY + cornerRadius
        )
        
        let tabTopArcCenter = CGPoint(
            x: maxX - (cornerRadius*0.75) - tabContentWidth,
            y: minY + cornerRadius
        )
        
        
        
        var path = Path()
//        path.move(to: begin)
        
        
        path.addArc(
            center: topLeftArcCenter,
            radius: cornerRadius,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        
        path.addArc(
            center: tabBottomArcCenter,
            radius: cornerRadius,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 25),
            clockwise: true
        )
        
        path.addArc(
            center: tabTopArcCenter,
            radius: cornerRadius,
            startAngle: Angle(degrees: -150),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        
        path.addArc(
            center: CGPoint(
                x: maxX - cornerRadius,
                y: minY + cornerRadius),
            radius: cornerRadius,
            startAngle: Angle(degrees: 270),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        
        path.addArc(
            center: CGPoint(
                x: maxX - cornerRadius,
                y: maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 90),
            clockwise: false
        )
        
        path.addArc(
            center: CGPoint(
                x: minX + cornerRadius,
                y: maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 180),
            clockwise: false
        )
        
        path.closeSubpath()
        
        
        return path
        
    }
    
    
    
    
    
    
    
    //    .frame(minWidth: 150, idealWidth: 350, maxWidth: .infinity, minHeight: 100, idealHeight: 262 , maxHeight: .infinity, alignment: .center)
    
    //    func path(in rect: CGRect) -> Path {
    //
    //        var path = Path()
    //
    //        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    //        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    //        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    //        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    //
    //        return path
    //    }
    
    
    
    
    
    
}


struct testeNewShape2: View {
    var body: some View {
        
        ZStack {
            
            NewFolderShape()
                .fill(.blue)
            
            NewFolderShape(topPadding: 0, bottomPadding: 0, rightPadding: 0, leftPadding: 0)
                .fill(.pink)
            
            
            Image(.newFolderIconRef)
                .opacity(0.3)
            
            
            
            
            
        }
        .frame(width: 109, height: 99)
        //        .ignoresSafeArea()
        
    }
}

#Preview("teste2") {
    testeNewShape2()
}


struct testeNewShape: View {
    var body: some View {
        
        ZStack {
            
            NewFolderShape()
                .fill(.blue)
            Folder(topSizeModifier: 0, insetAmount: 0)
                .fill(.pink)
                .opacity(0.2)
            //            VStack {
            //                Image(.newFolderIconRef)
            //                    .resizable()
            //                    .scaledToFit()
            //                    .opacity(0.2)
            //                Spacer()
            //            }
            
            
            
            
            
        }
        
    }
}

#Preview("teste1") {
    testeNewShape()
}
