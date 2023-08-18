//
//  CharacterInfoView.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import SwiftUI

struct CharacterInfoView: View {
    private(set) var character: Character
    @ObservedObject private var viewModel: CharacterInfoViewModel
    @Environment(\.dismiss) private var dismiss

    init(character: Character) {
        self.character = character
        self.viewModel = CharacterInfoViewModel(character: character)
    }

    var body: some View {
        ZStack {
            Color.bgColor
                .ignoresSafeArea()
            VStack {
                backButton()

                ScrollView {
                    VStack {
                        CachedAsyncImage(urlString: character.image)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom, 10)
                        
                        Text(character.name)
                            .gilroyFont(.bold, 22)
                            .padding(5)
                            .minimumScaleFactor(0.1)
                            .lineLimit(2)
                        Text(character.status)
                            .gilroyFont(.regular, 16, color: .green)

                        infoSection()

                        originSection()

                        episodeSection()
                        Spacer()
                    } //VSTACK
                } //SCROLLVIEW
            } //VSTACK
        } //ZSTACK
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadLocation()
            await viewModel.loadEpisodes()
        }
    }

    private func backButton() -> some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
                    .font(.title2)
            }
            .padding(30)
            Spacer()
        }
    }

    private func infoSection() -> some View {
        RoundedSection(title: "Info") {
            VStack {
                HStack {
                    Text("Species:")
                        .gilroyFont(.medium, 16)
                    Spacer()

                    Text(character.species.isEmpty
                         ? "None"
                         : character.species)
                    .gilroyFont(.medium, 16)
                }
                .padding(10)

                HStack {
                    Text("Type:")
                        .gilroyFont(.medium, 16)
                    Spacer()

                    Text(character.type.isEmpty
                         ? "None"
                         : character.type)
                    .gilroyFont(.medium, 16)
                }
                .padding(10)

                HStack {
                    Text("Gender:")
                        .gilroyFont(.medium, 16)
                    Spacer()

                    Text(character.gender.isEmpty
                         ? "None"
                         : character.gender)
                    .gilroyFont(.medium, 16)
                }
                .padding(10)
            }
        }
    }

    private func originSection() -> some View {
        RoundedSection(title: "Origin") {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.iconColor)
                        .frame(width: 64, height: 64)
                    Image("PlanetIcon")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.origin?.name ?? "unknown")
                        .gilroyFont(.semiBold, 17)

                    Text(viewModel.origin?.type ?? "unknown")
                        .gilroyFont(.medium, 13, color: .green)
                }
                Spacer()

            }
        }
    }

    private func episodeSection() -> some View {
        ForEach(viewModel.episodes, id: \.id) { episode in
            RoundedSection {
                VStack(alignment: .leading) {
                    Text(episode.name)
                        .gilroyFont(.semiBold, 17)
                        .padding(10)
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                    HStack {
                        Text(episode.getStyledEpisode())
                            .gilroyFont(.medium, 13, color: .green)
                            .foregroundStyle(.green)

                        Spacer()

                        Text(episode.airDate)
                            .gilroyFont(.semiBold, 12, color: .gray)
                    }
                    .padding(10)
                }
            }
        }
    }
}
