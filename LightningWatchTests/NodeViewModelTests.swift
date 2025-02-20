//
//  NodeViewModelTests.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation
import Testing

struct NodeViewModelTests {
    @Test func testCityEn() {
        let localizedCity = LocalizedName(
            de: nil,
            en: "New York",
            es: nil,
            fr: nil,
            ja: nil,
            ptBR: nil,
            ru: nil,
            zhCN: nil
        )
        
        let node = LightningNode(
            publicKey: "",
            alias: "",
            channels: 0,
            capacity: 0,
            firstSeen: 0,
            updatedAt: 0,
            city: localizedCity,
            country: nil
        )

        let viewModel = NodeViewModel(node: node)

        #expect(viewModel.cityName == "New York")
    }
    
    @Test func testCountryPt() {
        let localizedCountry = LocalizedName(
            de: nil,
            en: "Brazil",
            es: nil,
            fr: nil,
            ja: nil,
            ptBR: "Brasil",
            ru: nil,
            zhCN: nil
        )
        
        let node = LightningNode(
            publicKey: "",
            alias: "",
            channels: 0,
            capacity: 0,
            firstSeen: 0,
            updatedAt: 0,
            city: nil,
            country: localizedCountry
        )

        let viewModel = NodeViewModel(node: node)

        #expect(viewModel.countryName == "Brasil")
    }
    
    @Test func testSatsToBtc() {
        let node = LightningNode(
            publicKey: "",
            alias: "",
            channels: 0,
            capacity: 123_456_789,
            firstSeen: 0,
            updatedAt: 0,
            city: nil,
            country: nil
        )

        let viewModel = NodeViewModel(node: node)

        #expect(viewModel.capacityBtc == "1.23456789 BTC")
    }
    
    @Test func testLastUpdatedFormatted() {
        let oneHourAgoUnix = Int(Date().timeIntervalSince1970) - 3600
        
        let node = LightningNode(
            publicKey: "",
            alias: "",
            channels: 0,
            capacity: 0,
            firstSeen: 0,
            updatedAt: oneHourAgoUnix,
            city: nil,
            country: nil
        )

        let viewModel = NodeViewModel(node: node)

        #expect(viewModel.lastUpdatedFormatted == "1h ago")
    }
    
    @Test func testFirstSeenFormatted() {
        let janSecond2019Unix = 1546452819
        
        let node = LightningNode(
            publicKey: "",
            alias: "",
            channels: 0,
            capacity: 0,
            firstSeen: janSecond2019Unix,
            updatedAt: 0,
            city: nil,
            country: nil
        )

        let viewModel = NodeViewModel(node: node)

        #expect(viewModel.firstSeenFormatted == "Jan 2, 2019")
    }
}
