//
//  Coordinators.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation
import SwiftUI

@MainActor
class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    let repository: RecipeRepositoryProtocol = RecipeRepository()
    
    lazy var recipeListViewModel = RecipeListViewModel(coordinator: self)

    func start() -> some View {
        MealListView(viewModel: recipeListViewModel)
    }

    func showMealDetail(for mealID: String) {
        let viewModel = MealDetailViewModel(mealID: mealID, coordinator: self)
        navigationPath.append(viewModel)
    }
}
