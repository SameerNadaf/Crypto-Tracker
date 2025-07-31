//
//  StatisticView.swift
//  CryptoApplication
//
//  Created by Sameer  on 17/07/25.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticsModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentage() ?? "")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .foregroundStyle(
                (stat.percentageChange ?? 0) >= 0 ?
                Color.theme.green : Color.theme.red
            )
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.stat1)
    }
}
