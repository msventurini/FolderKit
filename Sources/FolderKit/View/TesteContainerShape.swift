//
//  SwiftUIView.swift
//  
//
//  Created by Matheus Silveira Venturini on 28/04/24.
//
// 
import SwiftUI

struct TesteContainerShape<Content: View>: View {
    @ViewBuilder var content: Content
        var body: some View {
            content
                .padding(.top,10)
                .containerShape(shape)
                .background(shape.fill(.blue))
        }
    
//    var shape: RoundedRectangle {
//        RoundedRectangle(cornerRadius: 20)
//    }
    
    var shape: Folder {
        Folder(topSizeModifier: 0)
    }
    
}

#Preview {
    TesteContainerShape {
        
        VStack {
            HStack {
                
                Text("Aaa")
                Spacer()
                Text("Aaa")

            }
            HStack {
                
                Text("Aaa")
                Spacer()
                Text("Aaa")

            }
            HStack {
                
                Text("Aaa")
                Spacer()
                Text("Aaa")

            }
            HStack {
                
                Text("Aaa")
                Spacer()
                Text("Aaa")

            }
        }
        .padding(.horizontal)
        
    }
}
