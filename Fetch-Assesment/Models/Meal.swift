//
//  Models.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let id: String
    let name: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}
