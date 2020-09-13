//
//  RestaurantViewModel.swift
//  WebServiceClientInRxSwift
//
//  Created by Marcin Makurat on 13/09/2020.
//  Copyright © 2020 Marcin Makurat. All rights reserved.
//

import Foundation

struct RestaurantViewModel {
    private let restaurant: Restaurant
    
    var displayText: String {
        return restaurant.name + " - " + restaurant.cuisine.rawValue.capitalized
    }
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}
