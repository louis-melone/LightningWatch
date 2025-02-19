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
    
    static func fetchLightningNodes() async throws -> [LightningNode] {
        guard let url = URL(string: Self.endpoint) else {
            throw ContentFetchError.invalidUrl
        }
        do {
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ContentFetchError.unknown(URLError(.badServerResponse))
            }

            switch httpResponse.statusCode {
            case 200...299:
                return try decoder.decode([LightningNode].self, from: data)
            case 404:
                throw ContentFetchError.resourceNotFound
            case 500...599:
                throw ContentFetchError.serverError(httpResponse.statusCode)
            default:
                throw ContentFetchError.unknownHttpError(httpResponse.statusCode)
            }
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet:
                throw ContentFetchError.noInternet
            case .timedOut:
                throw ContentFetchError.timeout
            default:
                throw ContentFetchError.unknown(error)
            }
        } catch {
            throw error
        }
    }
    
    /// Choosing to limit error cases to 404 not found, no internet connection, timeout (slow connection) or server error
    /// other errors like unauthorized can be implmented if the app ever gets auth, for example
    enum ContentFetchError: Error {
        case invalidUrl
        case noInternet
        case resourceNotFound
        // TODO: can add optimization to retry on a timeout
        case timeout
        case serverError(Int)
        case unknownHttpError(Int)
        case unknown(URLError)
    }
}
