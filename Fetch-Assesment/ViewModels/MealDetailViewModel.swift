//
//  MealDetailViewModel.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject, Hashable {
    @Published var mealDetail: MealDetail?
    private let repository: RecipeRepositoryProtocol
    let mealID: String
    weak var coordinator: AppCoordinator?

    init(mealID: String, repository: RecipeRepositoryProtocol = RecipeRepository(), coordinator: AppCoordinator) {
        self.mealID = mealID
        self.repository = repository
        self.coordinator = coordinator
    }

    func loadMealDetail() async {
        do {
            mealDetail = try await repository.getMealDetails(by: mealID)
        } catch {
            print("Failed to load meal details: \(error)")
        }
    }

    nonisolated static func == (lhs: MealDetailViewModel, rhs: MealDetailViewModel) -> Bool {
        return lhs.mealID == rhs.mealID
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(mealID)
    }
}
