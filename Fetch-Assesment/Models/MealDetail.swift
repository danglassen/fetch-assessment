//
//  MealDetail.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

import Foundation

struct MealDetail: Codable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [Ingredient]

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)

        let keyedContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            let ingredientKey = "strIngredient\(i)"
            let measureKey = "strMeasure\(i)"
            
            if let ingredientName = try keyedContainer.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: ingredientKey)!),
               let measure = try keyedContainer.decodeIfPresent(String.self, forKey: DynamicCodingKeys(stringValue: measureKey)!),
               !ingredientName.isEmpty, !measure.isEmpty {
                ingredients.append(Ingredient(name: ingredientName, measure: measure))
            }
        }
        self.ingredients = ingredients
    }
}

private struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}

struct Ingredient: Decodable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let measure: String
}
