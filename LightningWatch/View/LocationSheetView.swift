//
//  LocationSheetView.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/20/25.
//

import SwiftUI

struct LocationSheetView: View {
    let viewModel: LocationSheetViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
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
            .navigationTitle(viewModel.alias)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
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
                .foregroundColor(.gray)
        }
    }
    
    var locationSectionView: some View {
        HStack {
            Text("Location")
            Spacer()
            Text(viewModel.locationText)
                .foregroundColor(.gray)
        }
    }
    
    var firstSeenSectionView: some View {
        HStack {
            Text("First Seen")
            Spacer()
            Text(viewModel.firstSeenFormatted)
                .foregroundColor(.gray)
        }
    }
}
