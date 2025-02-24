//
//  NodeViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

struct NodeViewModel: Identifiable {
    let node: LightningNode
    let locationSheetViewModel: LocationSheetViewModel
    var id: String { node.id }
    
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
        String(format: "%.3f", node.capacity.satsToBtc)
    }
    
    var channels: String {
        String(node.channels)
    }

    var lastUpdatedFormatted: String {
        node.updatedAt.unixTimeToTimeAgo
    }
}

extension NodeViewModel: Hashable {
    static func == (lhs: NodeViewModel, rhs: NodeViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
