//
//  String.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
