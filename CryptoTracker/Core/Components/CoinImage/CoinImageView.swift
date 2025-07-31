//
//  CoinImageView.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var imageVM: CoinImageViewModel
    
    init(coin: CoinModel) {
        _imageVM = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = imageVM.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            else if imageVM.isLoading {
                ProgressView()
            }
            else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
