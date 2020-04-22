//
//  Utils.swift
//  Coronavirus.INFO
//
//  Created by Edward on 17.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation

class Utils {
    
    func getCurrentDateTime () -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter.string(from: date)
    }

    
}
