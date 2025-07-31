//
//  SettingsView.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let vm = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                
                List {
                    cryptoAppSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGekkoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
                .scrollContentBackground(.hidden)
            }
            .font(.headline)
            .tint(Color.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    rightNavigationBarButton
                }
            }
        }
    }
}

extension SettingsView {
    
    private var rightNavigationBarButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .fontWeight(.bold)
        }
    }
    
    private var cryptoAppSection: some View {
        Section(header: Text("Crypto App")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(vm.applicationText)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("YouTube link 🔗", destination: vm.youtubeURL)
        }
    }
    
    private var coinGekkoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(vm.coingeckoText)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit coingecko 🔥", destination: vm.coinGeckoURL)
        }
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("sam")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(vm.aboutDeveloper)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit github profile 🤠", destination: vm.githubURL)
        }
    }
    
    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms and Conditions", destination: vm.defaultURL)
            Link("Privacy and Policy", destination: vm.defaultURL)
            Link("Company Website", destination: vm.defaultURL)
            Link("Learn more", destination: vm.defaultURL)
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
