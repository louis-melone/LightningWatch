//
//  LightningNode.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

struct LightningNode: Codable {
    let publicKey: String
    let alias: String
    let channels: Int
    let capacity: Int
    let firstSeen: Int
    let updatedAt: Int
    let city: LocalizedName?
    let country: LocalizedName?

    struct LocalizedName: Codable {
        let de: String?
        let en: String
        let es: String?
        let fr: String?
        let ja: String?
        let ptBR: String?
        let ru: String?
        let zhCN: String?

        enum CodingKeys: String, CodingKey {
            case de, en, es, fr, ja, ru
            case ptBR = "pt-BR"
            case zhCN = "zh-CN"
        }
    }
}
