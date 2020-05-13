//
//  Engine.swift
//  Coronavirus.INFO
//
//  Created by Edward on 09.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation

class PopulationModel: ObservableObject{
    
    init() {}
    
    let globalCountriesLink:String = "https://www.worldometers.info/world-population/"
    let countryPageSeparatorFrom:String = "</strong>is<strong>"
    let countryPageSeparatorTo:String = "</strong>as"
    
    func getPopulationData(countryName:String)->String{
        return getPopulationDataSpicificCountry(
            spicificCountryName:countryName,
            countriesPageMainTextSeparatorFrom:countryPageSeparatorFrom,
            countriesPageMainTextSeparatorTo:countryPageSeparatorTo
        )
    }
    
    private func getPopulationDataSpicificCountry(
        spicificCountryName:String,
        countriesPageMainTextSeparatorFrom:String,
        countriesPageMainTextSeparatorTo:String
    ) -> String {
        let specificCountryLink:String = globalCountriesLink + spicificCountryName + "-population/"
        
        let countryUrl = URL(string: specificCountryLink)!
        let contentOfHtml = try! String(contentsOf: countryUrl, encoding: .utf8)
        let htmlUnspacedText =  contentOfHtml.filter { !$0.isNewline && !$0.isWhitespace }
        
        let countryPageTextFiltered = htmlUnspacedText.slices(from: countriesPageMainTextSeparatorFrom, to: countriesPageMainTextSeparatorTo)
        let countryValue = countryPageTextFiltered[0]
        return String(countryValue)
    }
    
    
}
