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
                .path(in: .init(x: geometry.frame(in: .local).minX, y: geometry.frame(in: .local).midY, width: geometry.size.width, height: geometry.size.height)).cgPath)
            
        }
        
//            .background {
//                Color.blue
//            }
    }
}

#Preview {
    ContentView()
}



