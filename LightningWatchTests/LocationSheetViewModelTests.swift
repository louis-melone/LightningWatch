//
//  LocationSheetViewModelTests.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/20/25.
//

import Foundation
import Testing

struct LocationSheetViewModelTests {
    @Test func testCityandCountry() {
        let localizedCountry = LocalizedName(
            en: "Brazil",
            ptBR: "Brasil"
        )
        
        let localizedCity = LocalizedName(
            en: "New York",
            ptBR: nil
        )
        
        let node = LightningNode(
            publicKey: "",
            alias: "",
            channels: 0,
            capacity: 0,
            firstSeen: 0,
            updatedAt: 0,
            city: localizedCity,
            country: localizedCountry
        )
        
        let viewModel = NodeViewModel(node: node).locationSheetViewModel
        
        #expect(viewModel.locationText == "New York, Brasil")
    }
    
    @Test func testCityEn() {
        let localizedCity = LocalizedName(
            en: "New York",
            ptBR: nil
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
        
        let viewModel = NodeViewModel(node: node).locationSheetViewModel
        
        #expect(viewModel.locationText == "New York")
    }
    
    @Test func testCountryPt() {
        let localizedCountry = LocalizedName(
            en: "Brazil",
            ptBR: "Brasil"
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
        
        let viewModel = NodeViewModel(node: node).locationSheetViewModel
        
        #expect(viewModel.locationText == "Brasil")
    }
    
    @Test func testUnknown() {
        let node = LightningNode(
            publicKey: "",
            alias: "",
            channels: 0,
            capacity: 0,
            firstSeen: 0,
            updatedAt: 0,
            city: nil,
            country: nil
        )
        
        let viewModel = NodeViewModel(node: node).locationSheetViewModel
        
        #expect(viewModel.locationText == "Unknown")
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

        let viewModel = NodeViewModel(node: node).locationSheetViewModel

        #expect(viewModel.firstSeenFormatted == "Jan 2, 2019")
    }
}
    
