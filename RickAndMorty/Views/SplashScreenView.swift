//
//  SplashScreenView.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isSplashPresented = false
    @State private var isPortalPresented = false

    var body: some View {
        ZStack {
            Color.bgColor
            Image("SplashScreen")
                .resizable()
                .scaledToFit()
                .opacity(isSplashPresented ? 1 : 0)
            Image("Portal")
                .resizable()
                .opacity(isPortalPresented ? 1 : 0)
                .scaleEffect(isPortalPresented ? 0.4 : 0)
        } //ZSTACK
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                isSplashPresented.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring(.bouncy(duration: 0.5))) {
                    isPortalPresented.toggle()
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
