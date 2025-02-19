//
//  Lightning.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct NodeView: View {
    let node: LightningNode
    
    var body: some View {
        Text(node.alias)
    }
}
