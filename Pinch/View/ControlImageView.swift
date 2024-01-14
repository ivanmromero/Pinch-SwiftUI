//
//  ControlImageView.swift
//  Pinch
//
//  Created by Ivan Romero on 14/01/2024.
//

import SwiftUI

struct ControlImageView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 36))    }
}

#Preview {
    ControlImageView(iconName: "minus.magnifyingglass")
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
}
