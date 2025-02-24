//
//  Lightning.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct NodeView: View {
    @ObservedObject var viewModel: NodeViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            rankView
            VStack(alignment: .leading) {
                Text(viewModel.node.alias)
                    .font(.subheadline)
                footerView
            }
            .padding(.trailing, 8)
            Spacer()
            Text(viewModel.capacityBtc)
                .font(.subheadline)
            Text(viewModel.channels)
                .font(.subheadline)
                .frame(width: UIScreen.main.bounds.width / 4, alignment: .trailing)
        }
        .sheet(isPresented: $viewModel.showSheet) {
            LocationSheetView(viewModel: viewModel.locationSheetViewModel)
                .presentationDetents([.medium])
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.showSheet = true
        }
    }
    
    @ViewBuilder
    var rankView: some View {
        if let rank = viewModel.rank {
            Text(String(rank))
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(minWidth: 25, alignment: .leading)
        }
    }
    
    var footerView: some View {
        TimelineView(.everyMinute) { _ in
            Text(viewModel.lastUpdatedFormatted)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}
