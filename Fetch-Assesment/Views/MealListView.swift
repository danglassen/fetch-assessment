//
//  MealListView.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct MealListView: View {
    @ObservedObject var viewModel: RecipeListViewModel

    var body: some View {
        NavigationStack(path: $viewModel.coordinator.navigationPath) {
            List(viewModel.meals) { meal in
                NavigationLink(value: meal.id) {
                    HStack {
                        KFImage(URL(string: meal.thumbnail))
                            .resizable()
                            .placeholder {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)

                        Text(meal.name)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    viewModel.didSelectMeal(meal)
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.loadMeals()
            }
            .navigationDestination(for: MealDetailViewModel.self) { viewModel in
                MealDetailView(viewModel: viewModel)
                    .onAppear {
                        Task {
                            await viewModel.loadMealDetail()
                        }
                    }
            }
        }
    }
}


