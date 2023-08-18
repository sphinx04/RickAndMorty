//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import Foundation

@MainActor final class AllCharactersViewModel: ObservableObject {
    private var dataModel: DataModel
    @Published var characterCards: [CharacterCardView]
    var isFirstPage: Bool {
        if let info = dataModel.currentCharactersInfo?.info {
            return info.prev == nil
        }
        return false
    }
    var isLastPage: Bool {
        if let info = dataModel.currentCharactersInfo?.info {
            return info.next == nil
        }
        return false
    }

    init() {
        self.characterCards = [CharacterCardView]()
        self.dataModel = DataModel()
        Task {
            await dataModel.loadData()
            reloadCharacterCards()
        }
    }
    
    private func reloadCharacterCards() {
        characterCards = []
        if let characters = dataModel.currentCharactersInfo?.results {
            for character in characters {
                let characterCard = CharacterCardView(character: character)
                characterCards.append(characterCard)
            }
        }
    }
    
    func reloadPage() async {
        await dataModel.loadData()
        reloadCharacterCards()
    }
    
    func nextPage() async {
        await dataModel.nextPage()
        reloadCharacterCards()
    }
    
    func prevPage() async {
        await dataModel.prevPage()
        reloadCharacterCards()
    }
}
