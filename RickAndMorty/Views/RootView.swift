//
//  RootView.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 17.08.23.
//

import SwiftUI

struct RootView: View {
    @State var isSplashScreenActive = true
    
    var body: some View {
        ZStack {
            if isSplashScreenActive {
                SplashScreenView()
            } else {
                AllCharactersView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isSplashScreenActive = false
            }
        }
    }
}

#Preview {
    RootView()
}
