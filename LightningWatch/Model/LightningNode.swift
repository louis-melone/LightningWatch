//
//  LightningNode.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

struct LightningNode: Codable, Identifiable {
    var id: String { publicKey }
    let publicKey: String
    let alias: String
    let channels: Int
    let capacity: Int
    let firstSeen: Int
    let updatedAt: Int
    let city: LocalizedName?
    let country: LocalizedName?
}
