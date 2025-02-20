//
//  ContentView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct CollectionView: View {
    @ObservedObject var viewModel: CollectionViewModel
    
    // For 100 elements Grid seems to be working with no performance hits
    // https://developer.apple.com/documentation/swiftui/lazyvgrid
    var body: some View {
        ScrollView {
            Grid(alignment: .leadingLastTextBaseline) {
                gridHeaderView
                Divider()
                forEachView
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
    
    var gridHeaderView: some View {
        GridRow {
            Text("Node Alias / Updated Ago")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Capacity (₿)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("# Channels")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    var forEachView: some View {
        ForEach(viewModel.nodeViewModels) { nodeViewModel in
            NodeView(viewModel: nodeViewModel)
            Divider()
        }
    }
}

#Preview {
    CollectionView(viewModel: CollectionViewModel())
}
