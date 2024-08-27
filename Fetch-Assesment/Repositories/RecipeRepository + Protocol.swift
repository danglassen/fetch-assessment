//
//  RecipeRepositoryProtocol.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func getMeals() async throws -> [Meal]
    func getMealDetails(by id: String) async throws -> MealDetail
}
