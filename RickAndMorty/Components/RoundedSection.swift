//
//  RoundedSection.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import SwiftUI

struct RoundedSection<Content: View>: View {
    var title: String?
    @ViewBuilder let content: Content

    var body: some View {
        VStack {
            if let title {
                HStack {
                    Text(title)
                        .gilroyFont(.semiBold, 17)
                    Spacer()
                }
            }
            VStack(spacing: 20) {
                content
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.cardColor)
            )
        }
        .padding()
    }
}
