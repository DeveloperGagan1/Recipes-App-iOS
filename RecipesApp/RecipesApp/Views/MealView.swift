//
//  MealView.swift
//  RecipesApp
//
//  Created by Gagan Pareek on 17/05/23.
//

import SwiftUI

struct MealView: View {
    @EnvironmentObject var vm: ViewModel
    let meal: Meal
    let dimensions: Double = 140
    
    var body: some View {
        VStack {
            
            // For Meal Image
            AsyncImage(url: URL(string: "\(meal.strMealThumb)" )) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimensions, height: dimensions)
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
            .background(.thinMaterial)
            .clipShape(Circle())
            
            // For Meal Name
            Text("\(meal.strMeal)")
                .foregroundColor(Color("ThemeColor1"))
                .font(.system(size: 16, weight: .semibold, design: .default))
                .padding(.bottom, 20)
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealView(meal: Meal.sampleMeal)
            .environmentObject(ViewModel())
    }
}
