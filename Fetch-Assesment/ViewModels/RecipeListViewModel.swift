//
//  RecipeListViewModel.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private let repository: RecipeRepositoryProtocol
    weak var coordinator: AppCoordinator!

    init(repository: RecipeRepositoryProtocol = RecipeRepository(), coordinator: AppCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }

    func loadMeals() async {
        do {
            meals = try await repository.getMeals()
        } catch {
            print("Failed to load meals: \(error)")
        }
    }

    func didSelectMeal(_ meal: Meal) {
        coordinator?.showMealDetail(for: meal.id)
    }
}
