//
//  ContentView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct CollectionView: View {
    @ObservedObject var viewModel: CollectionViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.nodes) { node in
                NodeView(node: node)
            }
        }
        .padding()
        .task {
            try? await viewModel.fetchNodes()
        }
        .refreshable {
            try? await viewModel.fetchNodes()
        }
    }
}

#Preview {
    CollectionView(viewModel: CollectionViewModel())
}
