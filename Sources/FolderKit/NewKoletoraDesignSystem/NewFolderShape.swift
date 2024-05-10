//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 10/05/24.
//

import SwiftUI

struct NewFolderShape: Shape {
    
        func path(in rect: CGRect) -> Path {
            
            let referenceWidth: CGFloat = 109
    
            let currentSize: CGFloat = (rect.width)
    
            let cornerRadius: CGFloat = 8 * (currentSize/referenceWidth)
            let tabCornerRadius: CGFloat = 8 * (currentSize/referenceWidth)
            
            let tabContentWidth: CGFloat = 22 * (currentSize/referenceWidth)
            
            let begin = CGPoint(x: rect.minX, y: rect.maxY - cornerRadius)

            var path = Path()
            path.move(to: begin)
            
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius * 3), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius*3 - tabContentWidth, y: rect.minY + tabCornerRadius), radius: tabCornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 35), clockwise: true)
            
            path.addArc(center: CGPoint(x: rect.maxX - (tabCornerRadius * 0.75) - tabContentWidth, y: rect.minY + tabCornerRadius), radius: tabCornerRadius, startAngle: Angle(degrees: 210), endAngle: Angle(degrees: 270), clockwise: false)

            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
            
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
            
    //        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 80))
            
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

struct testeNewShape: View {
    var body: some View {
        
        ZStack {
                
            NewFolderShape()
                .fill(.blue)
            Folder(topSizeModifier: 0, insetAmount: 0)
                .fill(.pink)
                .opacity(0.2)
            VStack {
                Image(.newFolderIconRef)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.2)
                Spacer()
            }
            


                

        }
//        .ignoresSafeArea()
//        .frame(width: 109, height: 99)
        
        
        
    }
}

#Preview {
    testeNewShape()
}
