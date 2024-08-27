//
//  MealDetailView.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if let mealDetail = viewModel.mealDetail {
                Text(mealDetail.name)
                    .font(.largeTitle)
                    .padding()

                Text("Ingredients")
                    .font(.headline)
                    .padding([.top, .leading])

                if mealDetail.ingredients.count > 0 {
                    ForEach(mealDetail.ingredients) { ingredient in
                        Text("\(ingredient.name): \(ingredient.measure)")
                            .padding(.leading)
                    }
                } else {
                    Text("No Data Available")
                        .padding(.leading)
                }

                Text("Instructions")
                    .font(.headline)
                    .padding([.top, .leading])

                Text(mealDetail.instructions)
                    .padding(.leading)
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Meal Details")
    }
}
