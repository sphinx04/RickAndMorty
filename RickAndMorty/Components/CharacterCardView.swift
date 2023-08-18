//
//  CharacterCardView.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import SwiftUI

struct CharacterCardView: View {
    let character: Character

    var body: some View {
        ZStack(alignment: .top) {
            Color.cardColor
                .clipShape(RoundedRectangle(cornerRadius: 25))
            VStack {

                CachedAsyncImage(urlString: character.image)
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(10)
                
                Text(character.name)
                    .gilroyFont(.semiBold, 18)
                    .padding([.bottom, .horizontal])
                    .minimumScaleFactor(0.1)
                    .lineLimit(2)
            } //VSTACK
        } //ZSTACK
        .padding(5)
    }
}
