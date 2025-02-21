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
    @Published var nodeViewModels: [NodeViewModel] = []
    @Published var sortParameter: SortParameter = .channels
    @Published var loadableViewState: LoadableViewState = .loaded
    var updatedDatetime: Date?
    
    var capacityTextColor: Color {
        if sortParameter == .capacity {
            return Color.black
        }
        return Color.gray
    }
    
    var channelsTextColor: Color {
        if sortParameter == .channels {
            return Color.black
        }
        return Color.gray
    }
    
    func fetchNodes() async {
        let currentDatetime = Date()
        if let updatedDatetime, currentDatetime.timeIntervalSince(updatedDatetime) < 10 { return }
        if nodeViewModels.isEmpty {
            loadableViewState = .loading
        }
        do {
            let lightningNodes =  try await Loader.fetchLightningNodes()
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
    }
    
    private func handleError(error: Error) {
        if let loaderError = error as? LoaderError {
            switch loaderError {
            case .noInternet:
                loadableViewState = .error(.resourceNotFound)
            default:
                loadableViewState = .error(loaderError)
            }
        } else {
            loadableViewState = .error(.resourceNotFound)
        }
    }
}

enum SortParameter {
    case capacity
    case channels
}
