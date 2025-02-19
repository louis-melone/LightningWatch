//
//  ContentView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct LightningView: View {
    @ObservedObject var viewModel: LightningViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.nodes) { node in
                Text(node.alias)
            }
        }
        .padding()
        .task {
            try? await viewModel.fetchNodes()
        }
    }
}

#Preview {
    LightningView(viewModel: LightningViewModel())
}
