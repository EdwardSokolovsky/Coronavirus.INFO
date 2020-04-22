//
//  Totor.swift
//  Coronavirus.INFO
//
//  Created by Edward on 09.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import SwiftUI

struct Country: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String { return name }
}
