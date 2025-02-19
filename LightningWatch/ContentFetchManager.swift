//
//  ContentFetchManager.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

struct ContentFetchManager {
    static let endpoint = "https://mempool.space/api/v1/lightning/nodes/rankings/connectivity"
    static let decoder = JSONDecoder()
    static let urlSession = URLSession.shared
    
    static func fetchLightningNodes() async throws -> Data? {
        guard let url = URL(string: ContentFetchManager.endpoint) else {
            throw ContentFetchError.invalidUrl
        }
        do {
            let (data, response) = try await urlSession.data(from: url)
            return data
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet:
                throw ContentFetchError.noInternet
            default:
                throw ContentFetchError.unknown(error)
            }
        }
    }
    
    enum ContentFetchError: Error {
        case invalidUrl
        case noInternet
        case unknown(URLError)
    }
}
