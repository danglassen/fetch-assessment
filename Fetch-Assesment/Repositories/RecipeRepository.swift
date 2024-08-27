//
//  RecipeRepository.swift
//  Fetch-Assessment
//
//  Created by Daniel on 8/22/24.
//

import Foundation

class RecipeRepository: RecipeRepositoryProtocol {
    private let service: RecipeServiceProtocol
    private let cache = UserDefaults.standard
    
    private enum CacheKeys {
        static let mealsKey = "meals_cache"
        static let mealDetailKey = "meal_detail_cache_"
        static let cacheTimestampKey = "cache_timestamp"
        static let cacheDuration: TimeInterval = 60 * 60 // 1 hour
    }

    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }

    func getMeals() async throws -> [Meal] {
        if let cachedMeals = loadMealsFromCache() {
            return cachedMeals
        }
        
        let meals = try await service.fetchMeals()
        saveMealsToCache(meals)
        return meals
    }

    func getMealDetails(by id: String) async throws -> MealDetail {
        if let cachedDetail = loadMealDetailFromCache(id: id) {
            return cachedDetail
        }
        
        let mealDetail = try await service.fetchMealDetails(by: id)
        saveMealDetailToCache(mealDetail, id: id)
        return mealDetail
    }

    // MARK: - Caching Logic
    
    private func saveMealsToCache(_ meals: [Meal]) {
        if let data = try? JSONEncoder().encode(meals) {
            cache.set(data, forKey: CacheKeys.mealsKey)
            cache.set(Date(), forKey: CacheKeys.cacheTimestampKey)
        }
    }
    
    private func loadMealsFromCache() -> [Meal]? {
        guard isCacheValid(),
              let data = cache.data(forKey: CacheKeys.mealsKey),
              let meals = try? JSONDecoder().decode([Meal].self, from: data) else {
            return nil
        }
        return meals
    }
    
    private func saveMealDetailToCache(_ mealDetail: MealDetail, id: String) {
        if let data = try? JSONEncoder().encode(mealDetail) {
            cache.set(data, forKey: CacheKeys.mealDetailKey + id)
        }
    }
    
    private func loadMealDetailFromCache(id: String) -> MealDetail? {
        guard let data = cache.data(forKey: CacheKeys.mealDetailKey + id),
              let mealDetail = try? JSONDecoder().decode(MealDetail.self, from: data) else {
            return nil
        }
        return mealDetail
    }

    // MARK: - Cache Validation
    
    private func isCacheValid() -> Bool {
        guard let cacheTimestamp = cache.object(forKey: CacheKeys.cacheTimestampKey) as? Date else {
            return false
        }
        return Date().timeIntervalSince(cacheTimestamp) < CacheKeys.cacheDuration
    }
}
