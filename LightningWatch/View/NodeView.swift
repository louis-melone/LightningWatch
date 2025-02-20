//
//  Lightning.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct NodeView: View {
    let viewModel: NodeViewModel
    @State var showCapacity = true
    @State var showSheet = false
    
    var body: some View {
        GridRow(alignment: .center) {
            VStack(alignment: .leading) {
                Text(viewModel.node.alias)
                    .font(.subheadline)
                footerView
            }
            Text(viewModel.capacityBtc)
                .font(.subheadline)
            Text(viewModel.channels)
                .font(.subheadline)
        }
        .sheet(isPresented: $showSheet) {
            LocationSheetView(viewModel: viewModel.locationSheetViewModel)
                .presentationDetents([.medium])
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showSheet = true
        }
    }

    var footerView: some View {
        HStack {
            TimelineView(.everyMinute) { _ in
                Text("\(viewModel.lastUpdatedFormatted)")
                    .font(.footnote)
                    .foregroundColor(.gray)

            }
        }
    }
}
