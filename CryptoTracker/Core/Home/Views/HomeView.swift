//
//  HomeView.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioSheet: Bool = false
    @State private var showSettins: Bool = false
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
                .sheet(isPresented: $showPortfolioSheet, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            VStack {
                header
                    .padding(.horizontal)
                
                HomeStatView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsView
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            portfolioEmptyText
                        }
                        else {
                            portfolioCoinsView
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettins) {
                SettingsView()
            }
        }

    }
}

extension HomeView {
    
    private var header: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioSheet.toggle()
                    }
                    else {
                        showSettins.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                        .frame(width: 80, height: 80)
                )
                                    
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.bottom)
    }
    
    private var allCoinsView: some View {
        List {
            ForEach(vm.allCoins) { coin in
                NavigationLink {
                    NavigationLazyView(DetailView(coin: coin))
                } label: {
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
                .listRowBackground(Color.theme.background)
            }
        }
        .refreshable {
            vm.reloadData()
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsView: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                NavigationLink {
                    NavigationLazyView(DetailView(coin: coin))
                } label: {
                    CoinRowView(coin: coin, showHoldingsColumn: true)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
                .listRowBackground(Color.theme.background)
            }
        }
        .refreshable {
            vm.reloadData()
        }
        .listStyle(.plain)
    }
    
    private var portfolioEmptyText: some View {
        Text("You haven't added any coins to your portfolio yet. Click the + button above to start adding coins! 🚀")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(Color.theme.accent)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .reverseRank) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .reverseRank : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .reverseHoldings) ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .reverseHoldings : .holdings
                    }
                }
            }
            
            HStack {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .reversePrice) ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .reversePrice : .price
                }
            }

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
                .toolbar(.hidden)
        }
        .environmentObject(dev.homevm)
    }

}
