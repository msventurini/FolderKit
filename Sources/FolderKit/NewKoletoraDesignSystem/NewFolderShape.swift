//
//  SwiftUIView.swift
//
//
//  Created by Matheus Silveira Venturini on 10/05/24.
//

import SwiftUI

public struct NewFolderShape: InsettableShape {
    
    
    var topPadding: CGFloat = 0
    var bottomPadding: CGFloat = 0
    var rightPadding: CGFloat = 0
    var leftPadding: CGFloat = 0
    
    var insetAmount: CGFloat = 0

    var expansionproportion: CGFloat = 1
    
//    var referenceWidth: CGFloat = 109 //350
    
    public var animatableData: CGFloat {
        get { expansionproportion }
        set { expansionproportion = newValue }
    }

    
    public init(topPadding: CGFloat = 0, bottomPadding: CGFloat = 0, rightPadding: CGFloat = 0, leftPadding: CGFloat = 0, expansionproportion: CGFloat = 1) {
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
        self.rightPadding = rightPadding
        self.leftPadding = leftPadding
        self.expansionproportion = expansionproportion
    }
    
    public func smallerArcRadius(for width: CGFloat) -> CGFloat {
        
        
        
        let radius: CGFloat = (0.0523 * width) + 2.3
        return radius
    }
    
    public func biggerArcRadius(for width: CGFloat) -> CGFloat {
        let radius: CGFloat = (0.105 * width) - 3.4
        return radius
    }
    
    public func path(in rect: CGRect) -> Path {
        
        var referenceWidth: CGFloat = (109 * (1 - expansionproportion) + (350 * expansionproportion)) //350

        
        let currentSize: CGFloat = (rect.width) - insetAmount
        

        let tabContentWidth: CGFloat = ((22 * (currentSize/referenceWidth)) * (1 - expansionproportion) + 82 * expansionproportion)
        
        // atualizado
        
        let minX = (rect.minX + insetAmount) + rightPadding
        let maxX = (rect.maxX - insetAmount) - leftPadding
        
        let minY = (rect.minY + insetAmount) + topPadding
        let maxY = (rect.maxY - insetAmount) - bottomPadding
        
        let width = maxX - minX
        
        let biggerArcRadius: CGFloat = biggerArcRadius(for: width)
        let smallerArcRadius: CGFloat = smallerArcRadius(for: width)
        
        let begin = CGPoint(
            x: minX,
            y: rect.maxY - biggerArcRadius
        )
        
        let topLeftArcCenter = CGPoint(
            x: minX + biggerArcRadius,
            y: minY + biggerArcRadius * 3
        )
        
        let tabBottomArcCenter = CGPoint(
            x: maxX - (biggerArcRadius * 3) - tabContentWidth,
            y: minY + biggerArcRadius
        )
        
        let tabTopArcCenter = CGPoint(
            x: maxX - (biggerArcRadius*0.75) - tabContentWidth,
            y: minY + biggerArcRadius
        )
        
        
        
        var path = Path()
//        path.move(to: begin)
        
        
        path.addArc(
            center: topLeftArcCenter,
            radius: biggerArcRadius,
            startAngle: Angle(degrees: 180),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        
        path.addArc(
            center: tabBottomArcCenter,
            radius: biggerArcRadius,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 25),
            clockwise: true
        )
        
        path.addArc(
            center: tabTopArcCenter,
            radius: biggerArcRadius,
            startAngle: Angle(degrees: -150),
            endAngle: Angle(degrees: -450),
            clockwise: false
        )
        
        path.addArc(
            center: CGPoint(
                x: maxX - biggerArcRadius,
                y: minY + biggerArcRadius),
            radius: biggerArcRadius,
            startAngle: Angle(degrees: 270),
            endAngle: Angle(degrees: 0),
            clockwise: false
        )
        
        path.addArc(
            center: CGPoint(
                x: maxX - biggerArcRadius,
                y: maxY - biggerArcRadius),
            radius: biggerArcRadius,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 90),
            clockwise: false
        )
        
        path.addArc(
            center: CGPoint(
                x: minX + biggerArcRadius,
                y: maxY - biggerArcRadius),
            radius: biggerArcRadius,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 180),
            clockwise: false
        )
        
        path.closeSubpath()
        
        
        
        return path
        
    }
    
    
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var folder = self
        folder.insetAmount += amount
        return folder
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
//                .fill(.blue)
                .stroke()
            
//            NewFolderShape(topPadding: 0, bottomPadding: 0, rightPadding: 0, leftPadding: 0)
//                .fill(.pink)
            
            
//            Image(.newFolderIconRef)
//                .opacity(0.3)
            
            
            
            
            
        }
//        .frame(width: 109, height: 99)
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
//            Folder(topSizeModifier: 0, insetAmount: 0)
//                .fill(.pink)
//                .opacity(0.2)
                        VStack {
                            Image(.newFolderIconRef)
                                .resizable()
                                .scaledToFit()
                                .opacity(0.2)
                            Spacer()
                        }
            
            
            
            
            
        }
        .ignoresSafeArea()
        
    }
}

#Preview("teste1") {
    testeNewShape()
}
