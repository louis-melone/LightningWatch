//
//  ErrorView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/21/25.
//

import SwiftUI

struct ErrorView: View {
    let headline: String
    let description: String
    let retryButtonAction: () async -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 5) {
                Text(headline)
                    .font(.headline)
                    .foregroundColor(.red)
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Button("Retry") {
                Task {
                    await retryButtonAction()
                }
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
