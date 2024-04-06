//
//  CustomRoundedRectangleFolderLabel.swift
//  FolderKit
//
//  Created by Matheus Silveira Venturini on 06/04/24.
//

import SwiftUI

struct CustomRoundedRectangleFolderLabel: View {
    
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .circular)
            .fill(color)
            .strokeBorder(style: .init(lineWidth: 2), antialiased: true)
    }
}

#Preview {
    CustomRoundedRectangleFolderLabel(color: .pink)
}
