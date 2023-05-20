//
//  ViewModel.swift
//  RecipesApp
//
//  Created by Gagan Pareek on 16/05/23.
//

import Foundation
import SwiftUI

public final class ViewModel: ObservableObject {
    private let mealManager = MealManager()
    
    @Published var mealList = [Meal]()
    @Published var mealDetails: DetailMeal?
    @Published var searchText = ""
    
    var filteredMeal: [Meal] {
        return searchText == "" ? mealList : mealList.filter {
            $0.strMeal.lowercased().contains(searchText.lowercased())
        }
    }
    
    init() {
        self.mealList = mealManager.getMeal()
    }
    
    // Getting Index
    func getMealIndex(meal: Meal) -> Int {
        let index = Int(meal.idMeal) ?? 0
        return index
    }
    
    // Fetching Meal Details
    func getDetails(meal: Meal) {
        let id = getMealIndex(meal: meal)
        
        self.mealDetails = DetailMeal(idMeal: "", strMeal: "", strDrinkAlternate: "", strCategory: "", strArea: "", strInstructions: "", strMealThumb: "", strTags: "", strYoutube: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: "")
                
        mealManager.getDetailedMeal(idMeal: id) {
            data in DispatchQueue.main.async {
                self.mealDetails = data
            }
        }
    }
    
    func formatString(detail: String) -> String {
        let string = String(detail)
        return string
    }
    
}
