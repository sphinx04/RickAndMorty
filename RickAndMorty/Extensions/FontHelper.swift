//
//  FontHelper.swift
//  RickAndMorty
//
//  Created by Sphinx04 on 18.08.23.
//

import SwiftUI

enum CustomFont: String {
    case semiBold = "Gilroy-SemiBold"
    case bold = "Gilroy-Bold"
    case medium = "Gilroy-Medium"
    case regular = "Gilroy-Regular"
    case light = "Gilroy-Light"

    fileprivate func font(size: CGFloat) -> Font {
        return .custom(rawValue, size: size)
    }
}

extension Text {
    func gilroyFont(_ font: CustomFont, _ size: CGFloat, color: Color = .white) -> Text {
        return self
            .font(font.font(size: size))
            .foregroundStyle(color)
    }
}
