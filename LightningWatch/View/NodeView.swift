//
//  Lightning.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

import SwiftUI

struct NodeView: View {
    let viewModel: NodeViewModel
    
    var body: some View {
        Text(viewModel.node.alias)
            .font(.headline)
    }
}
