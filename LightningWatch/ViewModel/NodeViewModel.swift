//
//  NodeViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

struct NodeViewModel: Identifiable {
    let node: LightningNode
    var id: String { node.id }
    
    var cityName: String? {
        guard let city = node.city else { return nil }
        return city.ptBR ?? city.en
    }
    
    var countryName: String? {
        guard let country = node.country else { return nil }
        return country.ptBR ?? country.en
    }
    
    var capacityBtc: String {
        String(format: "%.8f BTC", node.capacity.satsToBtc)
    }
    
    var firstSeenFormatted: String {
        formattedDate(from: node.firstSeen)
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
    
    // Converts Unix Time to formatted date ex. "Jan 1, 2025"
    private func formattedDate(from unixTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}

