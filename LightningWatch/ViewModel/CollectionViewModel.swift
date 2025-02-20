//
//  CollectionViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Combine
import Foundation

class CollectionViewModel: ObservableObject {
    @MainActor @Published var nodeViewModels: [NodeViewModel] = []
    var updatedDatetime: Date?
    
    @MainActor
    func fetchNodes() async {
        let currentDatetime = Date()
        if let updatedDatetime, currentDatetime.timeIntervalSince(updatedDatetime) < 1 { return }
        // TODO: Error Screens
        let lightningNodes =  try! await ContentFetchManager.fetchLightningNodes()
        nodeViewModels = lightningNodes.map { NodeViewModel(node: $0) }
        updatedDatetime = currentDatetime
    }
}
