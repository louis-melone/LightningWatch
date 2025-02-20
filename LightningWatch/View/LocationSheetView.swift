//
//  LocationSheetView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/20/25.
//

import SwiftUI

struct LocationSheetView: View {
    let viewModel: LocationSheetViewModel
    
    var body: some View {
        List {
            Section {
                locationSectionView
            }
            Section {
                firstSeenSectionView
            }
            Section {
                publicKeySectionView
            }
        }
        .listStyle(.insetGrouped)
    }
    
    var publicKeySectionView: some View {
        HStack {
            Text("Public Key")
                .padding(.trailing, 50)
            Spacer()
            Text(viewModel.publicKey)
                .lineLimit(1)
                .truncationMode(.middle)
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = viewModel.publicKey
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .foregroundStyle(.gray)
                    }
                }
        }
    }
    
    var locationSectionView: some View {
        HStack {
            Text("Location")
            Spacer()
            Text(viewModel.locationText)
        }
    }
    
    var firstSeenSectionView: some View {
        HStack {
            Text("First Seen")
            Spacer()
            Text(viewModel.firstSeenFormatted)
        }
    }
}
