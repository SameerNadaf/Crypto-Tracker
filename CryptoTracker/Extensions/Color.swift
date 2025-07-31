//
//  Color.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchColors()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let red = Color("RedColor")
    let green = Color("GreenColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchColors {
    let accent = Color("Accent")
    let background = Color("Background")
}
