//
//  CoinImageViewModel.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var imageService: CoinImageService
    var coin: CoinModel
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageService = CoinImageService(coin: coin)
        getImages()
        self.isLoading = true
    }
    
    func getImages() {
        imageService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] (imageData) in
                self?.image = imageData
            }
            .store(in: &cancellables)
    }
    
}
