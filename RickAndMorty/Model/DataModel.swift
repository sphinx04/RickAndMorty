//
//  DataModel.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 17.08.23.
//

import Foundation

struct CharactersInfo: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String

    struct Location: Codable, Hashable {
        let name: String
        let url: String
    }
}

struct Location: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}

struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    func getStyledEpisode() -> String {
        let info = episode.dropFirst().split(separator: "E")
        if let episode = info.last, let season = info.first {
            return "Episode: \(Int(episode) ?? 0), Season: \(Int(season) ?? 0)"
        }
        return ("Unknown")
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

final class DataModel {
    var currentPageUrl = "https://rickandmortyapi.com/api/character"
    var currentCharactersInfo: CharactersInfo?

    init(currentPageUrl: String = "https://rickandmortyapi.com/api/character", currentCharactersInfo: CharactersInfo? = nil) {
        self.currentPageUrl = currentPageUrl
        self.currentCharactersInfo = currentCharactersInfo
        Task {
            await loadData()
        }
    }

    func loadData() async {
        do {
            currentCharactersInfo = try await ApiCall.getData(from: currentPageUrl)
        } catch RMError.invalidUrl {
            print("Unable to get currentCharactersInfo: Invalid URL")
        } catch RMError.invalidResponse {
            print("Unable to get currentCharactersInfo: Invalid Response")
        } catch RMError.invalidData {
            print("Unable to get currentCharactersInfo: Invalid data")
        } catch {
            print("Unable to get currentCharactersInfo: Unexpected error")
        }
    }

    func nextPage() async {
        guard let currentCharactersInfo else { return }
        guard let nextUrl = currentCharactersInfo.info.next else { return }
        currentPageUrl = nextUrl
        await loadData()
    }

    func prevPage() async {
        guard let currentCharactersInfo else { return }
        guard let prevUrl = currentCharactersInfo.info.prev else { return }
        currentPageUrl = prevUrl
        await loadData()
    }
}

