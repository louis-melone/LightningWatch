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
            ForEach(viewModel.nodeViewModels) { nodeViewModel in
                NodeView(viewModel: nodeViewModel)
            }
        }
        .padding()
        .listStyle(.plain)
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
