//
//  DetailViewModel.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overViewStats: [StatisticsModel] = []
    @Published var additionalStats: [StatisticsModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    @Published var coin: CoinModel
    
    private let coinDetailService: CoinDetailService
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
        addSubcribers()
    }
    
    private func addSubcribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapData)
            .sink { [weak self] returnedDetails in
                self?.overViewStats = returnedDetails.overView
                self?.additionalStats = returnedDetails.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetail
            .sink { [weak self] coinDetails in
                self?.coinDescription = coinDetails?.readableDescription
                self?.websiteURL = coinDetails?.links?.homepage?.first
                self?.redditURL = coinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
        
    }
    
    private func mapData(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overView: [StatisticsModel], additional: [StatisticsModel]) {
        let overViewStats = overViewStat(coinModel: coinModel)
        let additionalStats = additionalStat(coinDetailModel: coinDetailModel, coinModel: coinModel)
        
        return( overViewStats, additionalStats)
    }
    
    private func overViewStat(coinModel: CoinModel) -> [StatisticsModel] {
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticsModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let priceChangePercent = coinModel.priceChangePercentage24H
        let priceStat = StatisticsModel(title: "Current Price", value: price, percentageChange: priceChangePercent)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticsModel(title: "Market Cap", value: marketCap, percentageChange: marketCapChange)
        
        let overViewStats: [StatisticsModel] = [
            priceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]
        
        return overViewStats
    }
    
    private func additionalStat(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticsModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "N/A"
        let highStat = StatisticsModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "N/A"
        let lowStat = StatisticsModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "N/A"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticsModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange2 = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketChnageStat = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange2, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 00
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
        let blockTimeStat = StatisticsModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
        let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalStats: [StatisticsModel] = [
            highStat,
            lowStat,
            priceChangeStat,
            marketChnageStat,
            blockTimeStat,
            hashingStat
        ]
        
        return additionalStats
    }
    
}
