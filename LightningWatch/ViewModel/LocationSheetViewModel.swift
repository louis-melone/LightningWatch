//
//  LocationSheetViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/20/25.
//

import Foundation

struct LocationSheetViewModel {
    let alias: String
    let publicKey: String
    private let country: LocalizedName?
    private let city: LocalizedName?
    private let firstSeen: Int
    
    init(alias: String, publicKey: String, country: LocalizedName?, city: LocalizedName?, firstSeen: Int) {
        self.alias = alias
        self.publicKey = publicKey
        self.country = country
        self.city = city
        self.firstSeen = firstSeen
    }
    
    var firstSeenFormatted: String {
        firstSeen.unixTimeToFormattedDate
    }
    
    var locationText: String {
        if let cityName, let countryName {
            return "\(cityName), \(countryName)"
        } else if let countryName {
            return countryName
        } else if let cityName {
            return cityName
        } else {
            return "Unknown"
        }
    }
    
    private var cityName: String? {
        guard let city else { return nil }
        return city.ptBR ?? city.en
    }
    
    private var countryName: String? {
        guard let country else { return nil }
        return country.ptBR ?? country.en
    }
}
