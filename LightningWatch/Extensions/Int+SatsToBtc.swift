//
//  Int+SatsBtcConversion.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

extension Int {
    /// 1 Bitcoin = 100,000,000 sats
    var satsToBtc: Double {
        Double(self) / 100_000_000.0
    }
}
