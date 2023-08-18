//
//  CachedAsyncImage.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import SwiftUI

struct CachedAsyncImage: View {
    static private var cache: [String: Image] = [:]
    static private var urls: [String] = []
    static func addToChache(url: String, image: Image) {
        if cache.count > 200 {
            for _ in 0..<20 {
                cache[urls[0]] = nil
                urls.remove(at: 0)
            }
        }
        urls.append(url)
        cache[url] = image
    }

    let urlString: String

    var body: some View {
        if let image = CachedAsyncImage.cache[urlString] {
            image
                .resizable()
        } else {
            AsyncImage(url: URL(string: urlString)) { image in
                image
                    .resizable()
                    .onAppear {
                        CachedAsyncImage.addToChache(url: urlString, image: image)
                    }
            } placeholder: {
                ZStack {
                    Color.cardColor
                    ProgressView()
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}
