//
//  ContentView.swift
//  RecipesApp
//
//  Created by Gagan Pareek on 16/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                    ForEach(vm.filteredMeal) { meal in
                        NavigationLink(destination: MealDetailView(meal: meal)) {
                            MealView(meal: meal)
                        }
                    }
                }
                .navigationTitle("Recipes")
            }
            .background(Color("ThemeColor2"))
            .searchable(text: $vm.searchText)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.light/*@END_MENU_TOKEN@*/)
        }
        .accentColor(Color("ThemeColor1"))
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

