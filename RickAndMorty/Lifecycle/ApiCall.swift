//
//  ApiCall.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import Foundation

final class ApiCall<T: Decodable> {
    static func getData(from urlStr: String) async throws -> T {
        guard let url = URL(string: urlStr) else {
            print(urlStr)
            throw RMError.invalidUrl
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw RMError.invalidResponse
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw RMError.invalidData
        }
    }
}
