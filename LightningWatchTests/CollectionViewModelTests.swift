//
//  CollectionViewModelTests.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/20/25.
//

import Testing

@MainActor
struct CollectionViewModelTests {
    @Test func testSortByCapacity() {
        // Setup
        let nodes = [
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 1, firstSeen: 0, updatedAt: 0, city: nil, country: nil),
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 3, firstSeen: 0, updatedAt: 0, city: nil, country: nil),
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 2, firstSeen: 0, updatedAt: 0, city: nil, country: nil)
        ]
        
        let nodeViewModels = nodes.map { NodeViewModel(node: $0) }
        let viewModel = CollectionViewModel(loader: MockLightningLoader())
        viewModel.nodeViewModels = nodeViewModels
        
        // Expect unselected color before sorting
        #expect(viewModel.capacityHeaderColor == .gray)
        #expect(viewModel.capacityHeaderText == "CAPACITY (BTC)")
        
        // Perform
        viewModel.sort(by: .capacity)
        
        // Expect selected color after sorting
        #expect(viewModel.capacityHeaderColor == .black)
        #expect(viewModel.capacityHeaderText == "CAPACITY (BTC) ▼")
        
        // Expect nodes to be sorted by capactiy
        #expect(viewModel.nodeViewModels[0].node.capacity == 3)
        #expect(viewModel.nodeViewModels[1].node.capacity == 2)
        #expect(viewModel.nodeViewModels[2].node.capacity == 1)
    }
    
    @Test func testHandleErrorFull() async {
        // Setup
        let nodes = [
            LightningNode(publicKey: "", alias: "", channels: 0, capacity: 0, firstSeen: 0, updatedAt: 0, city: nil, country: nil),
        ]
        
        let nodeViewModels = nodes.map { NodeViewModel(node: $0) }
        let viewModel = CollectionViewModel(loader: MockLightningLoader(loaderError: .noInternet))
        viewModel.nodeViewModels = nodeViewModels
        
        // Perform
        await viewModel.fetchNodes()
        
        // Expect loaded state since data was previously loaded despite connection error
        var expect = false
        switch viewModel.loadableViewState {
        case .loaded:
            expect = true
        default:
            expect = false
        }
        
        #expect(expect)
    }
    
    @Test func testHandleErrorEmpty() async {
        // Setup
        let viewModel = CollectionViewModel(loader: MockLightningLoader(loaderError: .noInternet))
        
        // Perform
        await viewModel.fetchNodes()
        
        // Expect error state since no data is present with connection error
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
