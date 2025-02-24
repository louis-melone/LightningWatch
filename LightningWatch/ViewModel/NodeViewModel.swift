//
//  NodeViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Combine
import Foundation

class NodeViewModel: ObservableObject, Identifiable {
    let node: LightningNode
    let locationSheetViewModel: LocationSheetViewModel
    var id: String { node.id }
    @Published var rank: Int?
    @Published var showSheet = false
    
    init(node: LightningNode) {
        self.node = node
        self.locationSheetViewModel = LocationSheetViewModel(
            alias: node.alias,
            publicKey: node.publicKey,
            country: node.country,
            city: node.city,
            firstSeen: node.firstSeen
        )
    }
    
    var capacityBtc: String {
        String(format: "%.3f", capactiy.satsToBtc)
    }
    
    var channels: String {
        String(node.channels)
    }

    var lastUpdatedFormatted: String {
        node.updatedAt.unixTimeToTimeAgo
    }
}
