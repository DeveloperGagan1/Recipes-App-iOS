//
//  MealDetailView.swift
//  RecipesApp
//
//  Created by Gagan Pareek on 17/05/23.
//

import SwiftUI

struct MealDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let meal: Meal
    
    var body: some View {
        VStack(spacing: 10) {
            MealView(meal: meal)
                .scaleEffect(CGSize(width: 1.3, height: 1.3))
                .padding(20)
            ScrollView {
                Spacer()
                HStack(spacing: 10) {
                    VStack {
                        Text("Ingredients  ").foregroundColor(Color("ThemeColor1")).bold()
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(1...20, id: \.self) { index in
                            if let ingredient = ingredient(forIndex: index),
                               let measure = measure(forIndex: index),
                               !ingredient.isEmpty {
                                Text("\(ingredient) - \(measure)")
                                    .foregroundColor(Color("ThemeColor1"))
                                        .padding(.bottom, 0.05)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    }
                        }
                        Spacer()
                    }
                    Spacer()
                }.padding(10)
                
                HStack(spacing: 10) {
                    VStack {
                        Text("Instructions ").foregroundColor(Color("ThemeColor1")).bold()
                        Spacer()
                    }
                    VStack {
                        Text("\(vm.formatString(detail: vm.mealDetails?.strInstructions ?? "nothing to show"))")
                            .foregroundColor(Color("ThemeColor1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                }.padding(10)
            }.background(Color("ThemeColor2"))
        }
        .background(Color.white)
        .onAppear {
            vm.getDetails(meal: meal)
        }.accentColor(Color("ThemeColor1"))
    }
    
    private func ingredient(forIndex index: Int) -> String? {
         guard let mealDetails = vm.mealDetails else {
             return nil
         }
                
         let mirror = Mirror(reflecting: mealDetails)
         for child in mirror.children {
             if let propertyName = child.label, propertyName == "strIngredient\(index)" {
                 if let ingredient = child.value as? String, !ingredient.isEmpty {
                     return ingredient
                 }
             }
         }
         
         return nil
     }
     
     private func measure(forIndex index: Int) -> String? {
         guard let mealDetails = vm.mealDetails else {
             return nil
         }
         
         let mirror = Mirror(reflecting: mealDetails)
          for child in mirror.children {
              if let propertyName = child.label, propertyName == "strMeasure\(index)" {
                  if let measure = child.value as? String, !measure.isEmpty {
                      return measure
                  }
              }
          }
          return nil
     }
}


struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealDetailView(meal: Meal.sampleMeal)
            .environmentObject(ViewModel())
    }
}
