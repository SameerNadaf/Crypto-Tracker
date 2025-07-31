//
//  PortfolioView.swift
//  CryptoApplication
//
//  Created by Sameer  on 17/07/25.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantitytext: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView{
                VStack(alignment: .leading) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                    
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    rightNavigationBarButton
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    leftNavigationBarButton
                }
            }
            .onChange(of: vm.searchText) { oldValue, newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
            
        }
    }
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updatePortfolioAmount(coin: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear ,lineWidth: 1)
                        }
                }
            }
            .padding(.leading)
            .frame(height: 120)
        }
        .scrollIndicators(.hidden)
    }
    
    private func updatePortfolioAmount(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantitytext = "\(amount)"
        }
        else {
            quantitytext = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                    
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.5", text: $quantitytext)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    
            }
            Divider()
            HStack {
                Text("Current value")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
                    
            }
            
        }
        .padding()
        .animation(.none, value: selectedCoin?.id)
        .font(.headline)
    }
    
    private var rightNavigationBarButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .fontWeight(.bold)
        }
    }
    
    private var leftNavigationBarButton: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            Button {
                saveButtonPressed()
            } label: {
                Text("save".uppercased())
                    .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantitytext) ? 1 : 0)
            }

        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantitytext) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantitytext)
        else {
            return
        }
        
        // save coin in portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        //show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homevm)
    }
}
