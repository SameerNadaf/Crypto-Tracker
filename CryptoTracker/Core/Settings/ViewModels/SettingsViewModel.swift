//
//  SettingsViewModel.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

import Foundation

class SettingsViewModel {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    let githubURL = URL(string: "https://github.com/SameerNadaf")!
    
    let applicationText: String = "This app was made by following a tutorial on YouTube. It uses MVVM architecture, Combine framework and CoreData."
    let coingeckoText: String = "Coingecko is a free API that provides real-time market data for cryptocurrencies. Prices may sligtly delayed."
    let aboutDeveloper: String = "This application was developed by Sameer Nadaf. It uses swiftUI and written 100% in Swift. This project benefits from multi-threading, publishers and subscribers and data persistence using CoreData."
    
}
