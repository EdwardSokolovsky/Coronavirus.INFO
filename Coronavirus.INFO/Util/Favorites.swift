//
//  Favorites.swift
//  Coronavirus.INFO
//
//  Created by Edward on 13.05.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var countries = [Country]()

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data

        // still here? Use an empty array
        self.countries = []
    }

    // returns true if our set contains this resort
    func contains(_ country: Country) -> Bool {
        countries.contains(Country)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ country: Country) {
        objectWillChange.send()
        countries.insert(Country)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ country: Country) {
        objectWillChange.send()
        countries.remove(resort.id)
        save()
    }

    func save() {
        // write out our data
    }
}
