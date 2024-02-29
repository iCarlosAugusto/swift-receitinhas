//
//  CookingLocalStorage.swift
//  receitinhas
//
//  Created by Carlos on 22/02/24.
//

import Foundation

class CookingLocalStorage {
    private static let userDefaults = UserDefaults.standard

    static func save(food: FoodRecipe) {
        
        if let savedData = userDefaults.data(forKey: "cookings") {
            var allCookings = try? JSONDecoder().decode([FoodRecipe].self, from: savedData)
            allCookings?.append(food)
            var allCookingsJSON = try? JSONEncoder().encode(allCookings)
            userDefaults.setValue(allCookingsJSON, forKey: "cookings")
        } else {
            if var cooking = try? JSONEncoder().encode([food]) {
                userDefaults.set(cooking, forKey: "cookings")
            };
        };
    }
    
    static func get() -> [FoodRecipe]? {        
        if let savedData = userDefaults.data(forKey: "cookings"),
           let decodedPeople = try? JSONDecoder().decode([FoodRecipe].self, from: savedData) {
            return decodedPeople;
        } else {
            print("Tem nada")
            return nil;
        }
    }
}
