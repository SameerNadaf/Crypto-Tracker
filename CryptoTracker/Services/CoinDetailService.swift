//
//  CoinDetailService.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

import Foundation
import Combine

class CoinDetailService {
    
    @Published var coinDetail: CoinDetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        fetchCoinDetail()
    }
    
    func fetchCoinDetail() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetail in
                guard let self = self else { return }
                self.coinDetail = returnedCoinDetail
                self.coinDetailSubscription?.cancel()
            })
    }
    
}
