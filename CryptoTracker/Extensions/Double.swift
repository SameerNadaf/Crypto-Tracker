//
//  Double.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import Foundation
import SwiftUI

extension Double {
    
    /// Converts a double into currency with 2 decimal places
    /// ```
    /// concerts 1234.56 = $1234.56
    /// ```
    private var currencyformatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        // Automatically detects currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a double into a currency as string with 2  decimal places
    /// ```
    /// concerts 1234.56 = "$1234.56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyformatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double into currency with 2-6 decimal places
    /// ```
    /// concerts 1234.56 = $1234.56
    /// concerts 12.3456 = $12.3456
    /// concerts 0.123456 = $0.1234.56
    /// ```
    private var currencyformatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        // Automatically detects currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a double into a currency as string with 2-6 decimal places
    /// ```
    /// concerts 1234.56 = "$1234.56"
    /// concerts 12.3456 = "$12.3456"
    /// concerts 0.123456 = "$0.1234.56"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyformatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts Double into String representation
    /// ```
    /// converts 12.5467 = "12.54"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts Double into String representation with % sign
    /// ```
    /// converts 12.5467 = "12.54%"
    /// ```
    func asPercentage() -> String {
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
    
}
