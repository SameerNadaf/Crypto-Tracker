//
//  Date.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

// Date Format: yyyy-MM-dd'T'HH:mm:ss.SSSZ

import Foundation

extension Date {
    
    init(coinGekkoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGekkoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func dateToString() -> String {
        return shortFormatter.string(from: self)
    }
}
