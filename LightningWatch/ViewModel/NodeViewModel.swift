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
            city: node.city,
            country: node.country,
            publicKey: node.publicKey,
            firstSeen: node.firstSeen
        )
    }
    
    var capacityBtc: String {
        String(format: "₿ %.3f", node.capacity.satsToBtc)
    }
    
    var channels: String {
        "\(node.channels) ch"
    }

    var lastUpdatedFormatted: String {
        timeAgo(from: node.updatedAt)
    }
    
    // Converts Unix Time to time ago string ex. "5m ago"
    private func timeAgo(from unixTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    

}

