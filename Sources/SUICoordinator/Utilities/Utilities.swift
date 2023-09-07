//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func ifLet<T, Content: View>(_ value: T?, modifier: (Self, T) -> Content) -> some View {
        if let value = value {
            modifier(self, value)
        } else {
            self
        }
    }
}
