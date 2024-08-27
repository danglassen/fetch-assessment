//
//  RecipeService.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

class RecipeService: RecipeServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchMeals() async throws -> [Meal] {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(MealsResponse.self, from: data)
        return response.meals.sorted { $0.name < $1.name }
    }

    func fetchMealDetails(by id: String) async throws -> MealDetail {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        let response = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
        return response.meals.first!
    }
}

struct MealsResponse: Codable {
    let meals: [Meal]
}

struct MealDetailsResponse: Codable {
    let meals: [MealDetail]
}
