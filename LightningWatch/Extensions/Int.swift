//
//  Int+SatsBtcConversion.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

extension Int {
    /// 1 Bitcoin = 100,000,000 sats
    var satsToBtc: Double {
        Double(self) / 100_000_000.0
    }
    
    /// Converts Unix Time to formatted date ex. "Jan 1, 2025"
    var unixTimeToFormattedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date.formatted(date: .abbreviated, time: .omitted)
    }
    
    /// Converts Unix Time to "time ago" string ex. "5m ago"
    var unixTimeToTimeAgo: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
