//
//  CoinImageView.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CoinImageView: View {
    let coin: CoinModel
    
    var body: some View {
        WebImage(url: URL(string: coin.image))
            .resizable()
            .indicator(.activity)
            .scaledToFit()
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .frame(width: 50, height: 50)
    }
}

