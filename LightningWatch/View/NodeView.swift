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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.node.alias)
                    .font(.headline)
                footerView
            }
            Spacer()
            statisticsView
        }
    }

    var firstSeenView: some View {
        Text("\(viewModel.firstSeenFormatted)")
            .font(.footnote)
            .foregroundColor(.gray)
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
    
    var statisticsView: some View {
        Text(showCapacity ? viewModel.capacityBtc : viewModel.channels)
            .font(.headline)
            .onTapGesture {
                withAnimation {
                    showCapacity.toggle()
                }
            }
    }
}
