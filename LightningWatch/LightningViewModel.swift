//
//  LightningWatchViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import Combine

class LightningViewModel: ObservableObject {
    @MainActor @Published var nodes: [LightningNode] = []
    
    @MainActor
    func fetchNodes() async {
        // TODO: Error Screens
        let lightningNodes =  try! await ContentFetchManager.fetchLightningNodes()
        nodes = lightningNodes
    }
}
