//
//  ContentView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct CollectionView: View {
    @ObservedObject var viewModel: CollectionViewModel
    let listRowInsets = EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 10)
    
    var body: some View {
        mainView
        .task {
            await viewModel.fetchNodes()
        }
    }

    var contentView: some View {
        List {
            gridHeaderView
            forEachView
        }
        .padding()
        .refreshable {
            await viewModel.fetchNodes()
        }
        .listStyle(.plain)
    }
    
    var gridHeaderView: some View {
        HStack(spacing: 0) {
            Text("#")
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(minWidth: 25, alignment: .leading)
            Text("ALIAS")
                .font(.footnote)
                .foregroundColor(.gray)
            Spacer()
            Text(viewModel.capacityHeaderText)
                .font(.footnote)
                .foregroundColor(viewModel.capacityHeaderColor)
                .onTapGesture {
                    viewModel.sort(by: .capacity)
                }
            Text(viewModel.channelsHeaderText)
                .font(.footnote)
                .foregroundColor(viewModel.channelsHeaderColor)
                .frame(width: UIScreen.main.bounds.width / 4, alignment: .trailing)
                .onTapGesture {
                    viewModel.sort(by: .channels)
                }
        }
        .listRowInsets(listRowInsets)
    }
    
    var forEachView: some View {
        ForEach(Array(viewModel.nodeViewModels.enumerated()), id: \.element) { index, nodeViewModel in
            NodeView(viewModel: nodeViewModel, rank: index + 1)
                .listRowInsets(listRowInsets)
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

struct CollectionViewPreview: PreviewProvider {
    static var previews: some View {
        CollectionView(viewModel: CollectionViewModel(loader: MockLightningLoader(loaderError: nil)))
    }
}


