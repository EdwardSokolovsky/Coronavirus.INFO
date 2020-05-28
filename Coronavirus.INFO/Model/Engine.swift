//
//  Engine.swift
//  Coronavirus.INFO
//
//  Created by Edward on 09.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation
import UIKit

class Engine: ObservableObject {
    
    init() {
    }
    
    let globalCountriesLink:String = "https:www.worldometers.info/coronavirus/#countries"
    let mainPageTextSeparatorFrom:String = "mt_a\" href=\""
    let mainPageTextSeparatorTo:String = "\">"
    let countriesPageMainTextSeparatorFrom:String = "label-counter"
    let countriesPageMainTextSeparatorTo:String = "<divclass=\"col"
    
    func getCasesDeathsRecoveredData(countryName:String)->[String:(String,String,String, String, String)]{
        let countriesAndLinks = getCountriesAndLinks(
            globalCountriesLink: globalCountriesLink,
            mainPageTextSeparatorFrom: mainPageTextSeparatorFrom,
            mainPageTextSeparatorTo:mainPageTextSeparatorTo
        )
        return getDataForSpecificCountry(
            spicificCountryName:countryName,
            countryesAndLinks:countriesAndLinks,
            globalCountriesLink:globalCountriesLink,
            countriesPageMainTextSeparatorFrom:countriesPageMainTextSeparatorFrom,
            countriesPageMainTextSeparatorTo:countriesPageMainTextSeparatorTo
        )
    }
    
    
    private func getCountriesAndLinks(
        globalCountriesLink:String,
        mainPageTextSeparatorFrom:String,
        mainPageTextSeparatorTo:String
    )->[String:String]{
        let countriesUrl = URL(string: globalCountriesLink)!
        let countriesHtmlStringContent = try! String(contentsOf: countriesUrl, encoding: .utf8)
        var countryesAndLinks = [String:String]()
        //array of links to specific country:
        let countriesLinks = countriesHtmlStringContent.slices(from: mainPageTextSeparatorFrom, to: mainPageTextSeparatorTo)
        
        countriesLinks.forEach({countryLink in
            let key = countryLink.replacingOccurrences(of: "country/", with: "").replacingOccurrences(of: "/", with: "")
            countryesAndLinks[key] = String(countryLink)
        })
        return countryesAndLinks
    }
    
    private func getDataForSpecificCountry(
        spicificCountryName:String,
        countryesAndLinks:[String:String],
        globalCountriesLink:String,
        countriesPageMainTextSeparatorFrom:String,
        countriesPageMainTextSeparatorTo:String
    ) -> [String:(String,String,String, String, String)]{
        let specificCountryLink:String = globalCountriesLink.replacingOccurrences(of: "#countries", with: "\(countryesAndLinks[spicificCountryName]!)")
        
        let scecificCountryUrl = URL(string: specificCountryLink)!
        let contentOfHtml = try! String(contentsOf: scecificCountryUrl, encoding: .utf8)
        let htmlUnspacedText =  contentOfHtml.filter { !$0.isNewline && !$0.isWhitespace }
        
        let countryPageMainText = htmlUnspacedText.slices(from: countriesPageMainTextSeparatorFrom, to: countriesPageMainTextSeparatorTo)
        
        let cases = String(countryPageMainText[0]).slices(from: "<h1>CoronavirusCases:</h1>", to: "</span>")
        let deaths = String(countryPageMainText[0]).slices(from: "<h1>Deaths:</h1>", to: "</span>")
        let recovered = String(countryPageMainText[0]).slices(from: "<h1>Recovered:</h1>", to: "</span>")
        
        var casesFiltered:String = "0"
        var deathsFiltered:String = "0"
        var recoveredFiltered:String = "0"
        
        if (!cases.isEmpty){casesFiltered = String(cases[0].split(separator: ">").last!)}
        if (!deaths.isEmpty){deathsFiltered = String(deaths[0].split(separator: ">").last!)}
        if (!recovered.isEmpty){recoveredFiltered = String(recovered[0].split(separator: ">").last!)}
        
        let lastNewsText = htmlUnspacedText.slices(from: "LatestNews", to: "in<strong>")
        
        let newCases = String(lastNewsText[0]).slices(from: "<strong>", to: "newcases")
        let newDeaths = String(lastNewsText[0]).slices(from: "and<strong>", to: "newdeaths")
        
        var newCasesFiltered = "0"
        var newDeathsFiltered = "0"
        
        if (!newCases.isEmpty){newCasesFiltered = String(newCases[0])}
        if (!newDeaths.isEmpty){newDeathsFiltered = String(newDeaths[0])}
        
        return [spicificCountryName:(casesFiltered, deathsFiltered, recoveredFiltered, newCasesFiltered, newDeathsFiltered)]
        
    }
    
    
}
