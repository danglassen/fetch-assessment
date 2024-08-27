//
//  RecipeServiceProtocol.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchMeals() async throws -> [Meal]
    func fetchMealDetails(by id: String) async throws -> MealDetail
}
