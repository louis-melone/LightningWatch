//
//  CollectionViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class CollectionViewModel: ObservableObject {
    enum SortParameter {
        case capacity
        case channels
    }

    @Published var nodeViewModels: [NodeViewModel] = []
    @Published var sortParameter: SortParameter = .channels
    @Published var loadableViewState: LoadableViewState = .loaded
    private var updatedDatetime: Date?
    private let loader: LightningLoader
    
    init(loader: LightningLoader) {
        self.loader = loader
    }
    
    var capacityHeaderText: String {
        if sortParameter == .capacity {
            return "CAPACITY (BTC) ▼"
        }
        return "CAPACITY (BTC)"
    }
    
    var channelsHeaderText: String {
        if sortParameter == .channels {
            return "CHANNELS ▼"
        }
        return "CHANNELS"
    }
    
    var capacityHeaderColor: Color {
        if sortParameter == .capacity {
            return .black
        }
        return .gray
    }
    
    var channelsHeaderColor: Color {
        if sortParameter == .channels {
            return .black
        }
        return .gray
    }
    
    /// Fetches Lightning nodes async with throttling, maps results to view models,
    /// sorts them, and updates the loadable view state accordingly
    func fetchNodes() async {
        let currentDatetime = Date()
        
        if let updatedDatetime, currentDatetime.timeIntervalSince(updatedDatetime) < 10 { return }
        
        if nodeViewModels.isEmpty {
            loadableViewState = .loading
        }
        
        do {
            let lightningNodes = try await loader.fetchLightningNodes()
            updatedDatetime = currentDatetime
            nodeViewModels = lightningNodes.map { NodeViewModel(node: $0) }
            sort(by: sortParameter)
            loadableViewState = .loaded
        } catch {
            handleError(error: error)
        }
    }

    func sort(by sortParameter: SortParameter) {
        self.sortParameter = sortParameter
        switch sortParameter {
        case .capacity:
            nodeViewModels.sort(by: { $0.node.capacity > $1.node.capacity })
        case .channels:
            nodeViewModels.sort(by: { $0.node.channels > $1.node.channels })
        }
        for index in nodeViewModels.indices {
            nodeViewModels[index].rank = index + 1
        }
    }
    
    /// Handles loadable state given some error.
    /// Preserves the loaded state if there's no internet and nodes exist
    private func handleError(error: Error) {
        if let loaderError = error as? LoaderError {
            switch loaderError {
            case .noInternet:
                loadableViewState = nodeViewModels.isEmpty ? .error(loaderError) : .loaded
            default:
                loadableViewState = .error(loaderError)
            }
        } else {
            loadableViewState = .error(.resourceNotFound)
        }
    }
}
