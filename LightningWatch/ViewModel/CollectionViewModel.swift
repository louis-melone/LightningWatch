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
    var updatedDatetime: Date?
    
    func fetchNodes() async {
        let currentDatetime = Date()
        if let updatedDatetime, currentDatetime.timeIntervalSince(updatedDatetime) < 1 { return }
        // TODO: Error Screens
        let lightningNodes =  try! await ContentFetchManager.fetchLightningNodes()
        nodeViewModels = lightningNodes
                            .map { NodeViewModel(node: $0) }
        sort(by: sortParameter)
        updatedDatetime = currentDatetime
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
}

enum SortParameter {
    case capacity
    case channels
}
