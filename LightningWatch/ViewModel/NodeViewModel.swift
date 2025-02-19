//
//  NodeViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

struct NodeViewModel: Identifiable {
    let node: LightningNode
    var id: String { node.id }
}
