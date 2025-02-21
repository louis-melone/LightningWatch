//
//  MockLightningLoader.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/21/25.
//

struct MockLightningLoader: LightningLoader {
    var loaderError: LoaderError = .noInternet

    func fetchLightningNodes() async throws -> [LightningNode] {
        throw loaderError
    }
}
