//
//  Home.swift
//  RoboChef
//
//  Created by Alex Pallozzi on 5/19/23.
//

import SwiftUI


struct Home: View {
    var body: some View {
        TabView {
            GroceryView()
                .tabItem {
                    Label("My Groceries", systemImage: "book")
                }
            
            RecipeGenerator()
                .tabItem {
                    Label("Recipes", systemImage: "star")
                }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
