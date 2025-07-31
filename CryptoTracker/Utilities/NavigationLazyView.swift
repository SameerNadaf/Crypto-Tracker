//
//  NavigationLazyView.swift
//  CryptoApplication
//
//  Created by Sameer  on 19/07/25.
//

import Foundation
import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    var body: some View {
        build()
    }
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
}
