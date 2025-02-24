//
//  Lightning.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct NodeView: View {
    let viewModel: NodeViewModel
    let rank: Int
    @State var showSheet = false
    
    
    var body: some View {
        HStack(spacing: 0) {
            Text(String(rank))
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(minWidth: 25, alignment: .leading)
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
        TimelineView(.everyMinute) { _ in
            Text(viewModel.lastUpdatedFormatted)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}
