//
//  LocationSheetViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/20/25.
//

import Foundation

struct LocationSheetViewModel {
    let city: LocalizedName?
    let country: LocalizedName?
    let publicKey: String
    let firstSeen: Int
    
    var firstSeenFormatted: String {
        formattedDate(from: firstSeen)
    }
    
    var cityName: String? {
        guard let city else { return nil }
        return city.ptBR ?? city.en
    }
    
    var countryName: String? {
        guard let country else { return nil }
        return country.ptBR ?? country.en
    }
    
    // Converts Unix Time to formatted date ex. "Jan 1, 2025"
    private func formattedDate(from unixTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}
