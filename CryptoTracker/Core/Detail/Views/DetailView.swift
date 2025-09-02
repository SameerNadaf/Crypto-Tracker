//
//  DetailView.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    @State var showFullDescription: Bool = false
    
    private let column: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    overViewTitle
                    Divider()
                    descriptionSection
                    overviewStats
                    
                    additionalTitle
                    Divider()
                    additionalStats
                    
                    websiteSection
                    
                }
                .padding(.leading)
            }
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navBarTrailing
            }
        }
    }
}

extension DetailView {
    
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewStats: some View {
        LazyVGrid(
            columns: column,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.overViewStats) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalStats: some View {
        LazyVGrid(
            columns: column,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(vm.additionalStats) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var navBarTrailing: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                        .lineLimit(showFullDescription ? nil : 3)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Show Less..." : "Show More...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .tint(Color.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let urlString = vm.websiteURL,
               let url = URL(string: urlString) {
                Link("Website", destination: url)
            }
            
            if let urlString = vm.redditURL,
               let url = URL(string: urlString) {
                Link("Reddit", destination: url)
            }
        }
        .tint(Color.blue)
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
