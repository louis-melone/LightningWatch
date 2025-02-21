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
        mainView
        .task {
            await viewModel.fetchNodes()
        }
    }
    
    // For 100 elements Grid seems to be working with no performance hits
    // https://developer.apple.com/documentation/swiftui/lazyvgrid
    var contentView: some View {
        ScrollView {
            Grid(alignment: .leadingLastTextBaseline) {
                gridHeaderView
                Divider()
                forEachView
            }
        }
        .padding()
        .refreshable {
            await viewModel.fetchNodes()
        }
    }
    
    var gridHeaderView: some View {
        GridRow {
            Text("Node Alias / Updated Ago")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Capacity (₿)")
                .font(.subheadline)
                .foregroundColor(viewModel.capacityTextColor)
                .onTapGesture {
                    viewModel.sort(by: .capacity)
                }
            Text("# Channels")
                .font(.subheadline)
                .foregroundColor(viewModel.channelsTextColor)
                .onTapGesture {
                    viewModel.sort(by: .channels)
                }
        }
    }
    
    var forEachView: some View {
        ForEach(viewModel.nodeViewModels) { nodeViewModel in
            NodeView(viewModel: nodeViewModel)
            Divider()
        }
    }
}

extension CollectionView: LoadableView {
    var loadableViewState: LoadableViewState {
        viewModel.loadableViewState
    }
    
    var retryButtonAction: () async -> Void {
        viewModel.fetchNodes
    }
}
