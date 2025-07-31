//
//  CoinImageService.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    let fileManager = LocalFileManager.instance
    
    private let folderName: String = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getImages()
    }
    
    private func getImages() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrived from saved images")
        }
        else {
            fetchCoinImages()
            print("Downloaded new image")
        }
    }
    
    private func fetchCoinImages() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (imageData) -> UIImage? in
                return UIImage(data: imageData)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: folderName)
            })
    }
    
}
