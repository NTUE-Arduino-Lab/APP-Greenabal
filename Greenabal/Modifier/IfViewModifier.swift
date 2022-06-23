//
//  IfViewModifier.swift
//  Greenabal
//
//  Created by Pei-yun,Lee on 2022/6/23.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
