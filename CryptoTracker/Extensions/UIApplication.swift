//
//  UIApplication.swift
//  CryptoApplication
//
//  Created by Sameer  on 15/07/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
