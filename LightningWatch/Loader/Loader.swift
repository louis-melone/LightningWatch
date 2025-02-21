//
//  LightningLoader.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Foundation

class Loader: LightningLoader {
    let endpoint = "https://mempool.space/api/v1/lightning/nodes/rankings/connectivity"
    let decoder = JSONDecoder()
    let urlSession = URLSession.shared
    
    func fetchLightningNodes() async throws -> [LightningNode] {
        guard let url = URL(string: self.endpoint) else {
            throw LoaderError.invalidUrl
        }
        do {
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw LoaderError.unknown("Bad Server Response")
            }

            switch httpResponse.statusCode {
            case 200...299:
                return try decoder.decode([LightningNode].self, from: data)
            case 404:
                throw LoaderError.resourceNotFound
            case 500...599:
                throw LoaderError.serverError(httpResponse.statusCode)
            default:
                throw LoaderError.unknown("Undetected HTTP error \(httpResponse.statusCode)")
            }
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet:
                throw LoaderError.noInternet
            case .timedOut:
                throw LoaderError.timeout
            default:
                throw LoaderError.unknown(error.localizedDescription)
            }
        } catch {
            throw LoaderError.unknown(error.localizedDescription)
        }
    }
}

protocol LightningLoader {
    func fetchLightningNodes() async throws -> [LightningNode]
}
