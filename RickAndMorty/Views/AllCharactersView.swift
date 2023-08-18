//
//  AllCharactersView.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 17.08.23.
//

import SwiftUI

struct AllCharactersView: View {
    @StateObject private var viewModel = AllCharactersViewModel()
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?

    private let portraitGrid = [GridItem](repeating: GridItem(), count: 2)
    private let landscapeGrid = [GridItem](repeating: GridItem(), count: 4)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgColor
                    .ignoresSafeArea()
                
                VStack {
                    ScrollViewReader { value in
                        ScrollView {
                            title()
                                .id(0)
                            LazyVGrid(columns: verticalSizeClass == .compact ? landscapeGrid : portraitGrid) {
                                ForEach(viewModel.characterCards, id: \.character.id) { character in
                                    NavigationLink {
                                        CharacterInfoView(character: character.character)
                                    } label: {
                                        character
                                    }
                                }
                            } //LAZYVGRID
                            .padding()

                            Spacer()

                            if !viewModel.characterCards.isEmpty {
                                footer {
                                    withAnimation {
                                        value.scrollTo(0)
                                    }
                                }
                            }
                        } //SCROLLVIEW
                    } //SCROLLREADER
                } //VSTACK
            } //ZSTACK
        } //NAVIGATIONSTACK
    }

    private func title() -> some View {
        HStack {
            Text("Characters")
                .gilroyFont(.bold, 32)
                .padding(20)
            Spacer()
        }
    }

    private func footer(action: @escaping () -> Void) -> some View {
        HStack {
            if !viewModel.isFirstPage {
                PageButton(text: "Prev page") {
                    Task {
                        await viewModel.prevPage()
                        action()
                    }
                }
            }

            if !viewModel.isLastPage {
                PageButton(text: "Next page") {
                    Task {
                        await viewModel.nextPage()
                        action()
                        
                    }
                }
            }
        }
    }
}

#Preview {
    AllCharactersView()
}
