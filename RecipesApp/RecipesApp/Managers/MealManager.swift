//
//  MealManager.swift
//  RecipesApp
//
//  Created by Gagan Pareek on 16/05/23.
//

import Foundation

public class MealManager {
    func getMeal() -> [Meal] {
        let data: MealPage = Bundle.main.decode(file: "meal.json")
        let meal: [Meal] = data.meals
        
        return meal
    }
    
    //To Load Meal's complete details from API
    func getDetailedMeal(idMeal: Int, _ completion: @escaping (DetailMeal) -> ()) {
        Bundle.main.fetchData(url: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)", model: DetailMeal.self) { data in completion(data)
            
        } failure: { error in
            print(error)
        }
    }
}
