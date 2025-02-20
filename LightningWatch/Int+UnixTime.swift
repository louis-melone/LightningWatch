//
//  Untitled.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

extension Int {
    // Converts Unix Time to time ago string ex. "5m ago"
    var timeAgo: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    // Converts Unix Time to formatted date ex. "Jan 1, 2025"
    var formattedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}
