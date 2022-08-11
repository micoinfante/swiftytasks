//
//  View.swift
//  SwiftyTasks
//
//  Created by Mico Infante on 8/11/22.
//

import SwiftUI

extension View {
    func horizontalLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }

    func horizontalTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }

    func horizontalCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}
