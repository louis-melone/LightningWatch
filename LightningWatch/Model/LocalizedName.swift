//
//  LocalizedName.swift
//  LightningWatch
//
//  Created by Louis Melone on 2/19/25.
//

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
