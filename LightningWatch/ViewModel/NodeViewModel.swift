//
//  NodeViewModel.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

struct NodeViewModel: Identifiable {
    let node: LightningNode
    var id: String { node.id }
    
    var cityName: String? {
        guard let city = node.city else { return nil }
        return city.ptBR ?? city.en
    }
    
    var countryName: String? {
        guard let country = node.country else { return nil }
        return country.ptBR ?? country.en
    }
}
