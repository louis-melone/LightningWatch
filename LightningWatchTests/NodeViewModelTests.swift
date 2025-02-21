//
//  NodeViewModelTests.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation
import Testing

struct NodeViewModelTests {
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

        #expect(viewModel.capacityBtc == "1.235")
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
}
