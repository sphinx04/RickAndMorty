//
//  CharacterInfoViewModel.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 19.08.23.
//

import Foundation

@MainActor final class CharacterInfoViewModel: ObservableObject {
    @Published var origin: Location?
    @Published var episodes: [Episode]
    private var character: Character
    
    init(character: Character) {
        self.origin = nil
        self.episodes = []
        self.character = character
    }
    
    func loadLocation() async {
        do {
            origin = try await ApiCall.getData(from: character.origin.url)
        } catch RMError.invalidUrl {
            print("Unable to get origin: Invalid URL")
        } catch RMError.invalidResponse {
            print("Unable to get origin: Invalid Response")
        } catch RMError.invalidData {
            print("Unable to get origin: Invalid data")
        } catch {
            print("Unable to get origin: Unexpected error")
        }
    }
    
    func loadEpisodes() async {
        do {
            for url in character.episode {
                episodes.append(try await ApiCall.getData(from: url))
            }
        } catch RMError.invalidUrl {
            print("Unable to get episodes: Invalid URL")
        } catch RMError.invalidResponse {
            print("Unable to get episodes: Invalid Response")
        } catch RMError.invalidData {
            print("Unable to get episodes: Invalid data")
        } catch {
            print("Unable to get episodes: Unexpected error")
        }
    }
}
