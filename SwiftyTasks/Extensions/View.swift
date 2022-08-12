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

    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }

        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }

        return safeArea
    }
}

struct OptionalView<Value, Content>: View where Content: View {
    private var content: Content

    init?(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        guard let value = value else { return nil }
        self.content = content(value)
    }

    var body: some View {
        content
    }
}
