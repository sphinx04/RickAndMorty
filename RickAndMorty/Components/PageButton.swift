//
//  PageButton.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import SwiftUI

struct PageButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .gilroyFont(.bold, 22)
                .padding()
        }
        .background(RoundedRectangle(cornerRadius: 25)
            .foregroundStyle(Color.cardColor))
    }
}

#Preview {
    PageButton(text: "asd") {}
}
