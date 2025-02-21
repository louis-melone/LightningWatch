//
//  CollectionViewModelTests.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/20/25.
//

import Testing

struct CollectionViewModelTests {
    @MainActor
    @Test func testSortByCapacity() {
        let nodes = [
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 1, firstSeen: 0, updatedAt: 0, city: nil, country: nil),
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 3, firstSeen: 0, updatedAt: 0, city: nil, country: nil),
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 2, firstSeen: 0, updatedAt: 0, city: nil, country: nil)
        ]
        
        let nodeViewModels = nodes.map { NodeViewModel(node: $0) }
        let viewModel = CollectionViewModel(loader: MockLightningLoader())
        viewModel.nodeViewModels = nodeViewModels
        
        // Test that the capacity color is unselected
        #expect(viewModel.capacityTextColor == .gray)
        
        // perform operation
        viewModel.sort(by: .capacity)
        
        // Test that the capacity color has been selected
        #expect(viewModel.capacityTextColor == .black)
        
        // Test that the array is sorted by capacity
        #expect(viewModel.nodeViewModels[0].node.capacity == 3)
        #expect(viewModel.nodeViewModels[1].node.capacity == 2)
        #expect(viewModel.nodeViewModels[2].node.capacity == 1)
    }
    
    @MainActor
    @Test func testHandleErrorFull() async {
        let nodes = [
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 0, firstSeen: 0, updatedAt: 0, city: nil, country: nil),
        ]
        
        let nodeViewModels = nodes.map { NodeViewModel(node: $0) }
        let viewModel = CollectionViewModel(loader: MockLightningLoader())
        viewModel.nodeViewModels = nodeViewModels
        
        await viewModel.fetchNodes()
        
        var expect = false
        switch viewModel.loadableViewState {
        case .loaded:
            expect = true
        default:
            expect = false
        }
        
        #expect(expect)
    }
    
    @MainActor
    @Test func testHandleErrorEmpty() async {
        let viewModel = CollectionViewModel(loader: MockLightningLoader())
        
        await viewModel.fetchNodes()
        
        var expect = false
        switch viewModel.loadableViewState {
        case .error:
            expect = true
        default:
            expect = false
        }
        
        #expect(expect)
    }
}
