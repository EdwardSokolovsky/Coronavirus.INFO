//
//  Country.swift
//  Coronavirus.INFO
//
//  Created by Edward on 09.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import SwiftUI

struct Country: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var imageName: String { return name }
    var reaction: String
    
    static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }
}
