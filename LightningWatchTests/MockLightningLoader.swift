//
//  MockLightningLoader.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/21/25.
//

import Foundation

struct MockLightningLoader: LightningLoader {
    var loaderError: LoaderError?
    private let mockNodes = [LightningNode(
        publicKey: "12345678",
        alias: "CoinGate",
        channels: 1066,
        capacity: 1_234_567_891,
        firstSeen: 1546452819,
        updatedAt: Int(Date().timeIntervalSince1970) - 3600,
        city: LocalizedName(de: nil, en: "", es: nil, fr: nil, ja: nil, ptBR: nil, ru: "Frankfurt am Main", zhCN: nil),
        country:  LocalizedName(de: nil, en: "", es: nil, fr: nil, ja: nil, ptBR: "Alemanha", ru: nil, zhCN: nil)
    )]
    
    init(loaderError: LoaderError? = nil) {
        self.loaderError = loaderError
    }

    func fetchLightningNodes() async throws -> [LightningNode] {
        if let loaderError {
            throw loaderError
        } else {
            return mockNodes
        }
    }
}
