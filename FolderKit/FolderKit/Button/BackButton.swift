//
//  BackButton.swift
//  FolderKit
//
//  Created by Matheus Silveira Venturini on 06/04/24.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        Circle()
            .fill(.white)
            .strokeBorder(lineWidth: 2)
            .frame(width: 48, height: 48)
            .overlay {
                Image(systemName: "arrow.backward")
                    .resizable()
                    .scaledToFit()
//                    .fontWidth(.expanded)
                    .fontWeight(.semibold)
                    .padding(12)
                    
            }
    }
}

#Preview {
    BackButton()
        .scaleEffect(4)
}
