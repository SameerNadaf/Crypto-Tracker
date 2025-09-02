//
//  HomeViewModel.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var statistics: [StatisticsModel] = []
    @Published var sortOption: SortOptions = .holdings
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOptions {
        case rank, reverseRank, price, reversePrice, holdings, reverseHoldings
    }
    
    init () {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(allCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoins(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobarMarketData)
            .sink { [weak self] returnedData in
                self?.statistics = returnedData
                HapticManager.notification(type: .success)
            }
            .store(in: &cancellables)
    }
    
    func filterAndSortCoins(text: String, coins: [CoinModel], sortOption: SortOptions) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(coins: &updatedCoins, sortOption: sortOption)
        return updatedCoins
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let text = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(text) ||
                   coin.symbol.lowercased().contains(text) ||
                   coin.id.lowercased().contains(text)
        }
    }
    
    private func sortCoins(coins: inout [CoinModel], sortOption: SortOptions) {
        switch sortOption {
        case .rank, .holdings:
                    coins.sort(by: {$0.rank < $1.rank})
        case .reverseRank, .reverseHoldings:
                coins.sort(by: {$0.rank > $1.rank})
            case .price:
                coins.sort(by: {$0.currentPrice < $1.currentPrice})
            case .reversePrice:
                coins.sort(by: {$0.currentPrice > $1.currentPrice})
        }
    }
    
    private func sortPortfolioCoins(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
            case .holdings:
                return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
            case .reverseHoldings:
                return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
            default:
                return coins
        }
    }
    
    private func allCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntity: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap{ coin -> CoinModel? in
                guard let entity = portfolioEntity.first(where: { $0.coinId == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    func reloadData() {
        coinDataService.fetchAllCoins()
        marketDataService.getData()
    }
    
    private func mapGlobarMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "Volume", value: data.volume)
        let btcDominace = StatisticsModel(title: "BTC Dominace", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins.map({$0.currentHoldingsValue}).reduce(0, +)
        
        let previousValue = portfolioCoins
            .map{ (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = StatisticsModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominace,
            portfolio
        ])
        
        return stats
    }
    
}
