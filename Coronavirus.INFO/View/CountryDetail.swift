//
//  CountryDetail.swift
//  Coronavirus.INFO
//
//  Created by Edward on 09.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import SwiftUI
import Combine

struct CountryDetail : View {
    @State var cases:String = "?"
    @State var deaths:String = "?"
    @State var recovered:String = "?"
    @State var newCases:String = "?"
    @State var newDeaths:String = "?"
    @State var deathsPct:String = "?"
    @State var recoveredPct:String = "?"
    @State var populationValue:String = "?"
    @State var populationPercent: Float = 0.0
    @State var lastUpdate: String = ""
    @State var isShowingLoading: Bool = false
    @State var casesColor: Color = Color.orange
    @State var populationColor: Color = Color.green
    
    @EnvironmentObject var countriesDao: CountriesDao
    
    var name: String
    let utils = Utils()
    let mainBackgroundColor = Color(red: 200, green: 17, blue: 255)
    init(countryName:String) {
        name = countryName
    }
    
    private func loadData()->Void{
        self.isShowingLoading.toggle()
        
        let data = getCountryData()
        self.cases = data[name]!.0
        self.deaths = data[name]!.1
        self.recovered = data[name]!.2
        self.newCases = data[name]!.3
        self.newDeaths = data[name]!.4
        self.deathsPct = getParameterPercent(cases: cases, value: deaths)
        self.recoveredPct = getParameterPercent(cases: cases, value: recovered)
        self.populationValue = PopulationModel.init().getPopulationData(countryName:name)
        self.populationPercent = calculatePopulationCasesPercent(casesValue:cases, populationValue:populationValue)
        self.lastUpdate = "Last update: " + utils.getCurrentDateTime()
        countriesDao.saveData(
            countryName: name,
            cases: self.cases,
            deaths: self.deaths,
            recovered: self.recovered,
            newCases: self.newCases,
            newDeaths: self.newDeaths,
            deathsPercent: self.deathsPct,
            recoveredPercent: self.recoveredPct,
            populationValue: self.populationValue,
            populationPercent: self.$populationPercent,
            lastUpdate: self.lastUpdate
        )
        self.isShowingLoading.toggle()
    }
    private func getCountryData () -> [String:(String,String,String, String, String)]{
        return Engine.init().getCasesDeathsRecoveredData(countryName:name)
    }
    private func getParameterPercent(cases:String, value:String)->String{
        let c = cases.replacingOccurrences(of: ",", with: "")
        let v = value.replacingOccurrences(of: ",", with: "")
        let result = (Float(v)! / Float(c)! * 100.0)
        return String(format: "%.2f", result)
    }
    private func calculatePopulationCasesPercent(casesValue:String, populationValue:String)-> Float{
        let p = populationValue.replacingOccurrences(of: ",",with: "")
        let c = casesValue.replacingOccurrences(of: ",",with: "")
        return (Float(c)! / Float(p)! * 100.0)
    }
    
    func getCountryImage(name: String) -> Image {
        let uiImage =  (UIImage(named: name) ?? UIImage(named: "Default.png"))!
        return Image(uiImage: uiImage)
    }
    
    var body: some View {
        VStack {
            VStack {
                self.getCountryImage(name: self.name.capitalized)
                    .cornerRadius(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            //                    .stroke(Color.black, lineWidth: 1.5)
                            .stroke(Color.primary, lineWidth: 1.5)
                            .opacity(0.15)
                )
                VStack {
                    ZStack {
                        Text("\(self.name.capitalized):")
                            .font(.largeTitle)
                            .font(.callout)
                            .padding(6)
                    }
                    Divider()
                    Text("Cases: \(self.countriesDao.savedData[self.name]?.cases ?? self.cases)" + " + \(self.countriesDao.savedData[self.name]?.newCases ?? self.newCases) new")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(casesColor)
                    Divider()
                    Text("Deaths: \(self.countriesDao.savedData[self.name]?.deaths ?? self.deaths) (\(self.countriesDao.savedData[self.name]?.deathsPercent ?? self.deathsPct)%)" + " + \(self.countriesDao.savedData[self.name]?.newDeaths ?? self.newDeaths) new")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.red)
                    Divider()
                    Text("Recovered: \(self.countriesDao.savedData[self.name]?.recovered ?? self.recovered) (\(self.countriesDao.savedData[self.name]?.recoveredPercent ?? self.recoveredPct)%)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.yellow)
                    Divider()
                    Text("Population: \(self.countriesDao.savedData[self.name]?.populationValue ?? self.populationValue)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(populationColor)
                    Divider()
                }
                .navigationBarTitle(Text(self.name.capitalized), displayMode: .inline)
                ProgressBarView(
                    progressValue: self.countriesDao.savedData[self.name]?.populationPercent ?? self.$populationPercent,
                    progressColorValue: self.$casesColor,
                    generalColorValue: self.$populationColor
                )
                    .padding(.vertical, 20)
                Text("*percent population infected")
                    .foregroundColor(casesColor)
                    .padding(.bottom, 10)
                Button(action: {
                    self.loadData()
                }) {
                    Text("Update data")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
                Text("\(self.countriesDao.savedData[self.name]?.9 ?? self.lastUpdate)")
                    .font(.callout)
                    .padding(10)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 45)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(.systemBackground))
    }
    
}

#if DEBUG
struct CountryDetail_Previews : PreviewProvider {
    static var testCountryName: String = "norway"
    static var previews: some View {
        Group {
        CountryDetail(countryName: testCountryName)
            .environment(\.colorScheme, .light)
            .environmentObject(CountriesDao())
            
        CountryDetail(countryName: testCountryName)
            .environment(\.colorScheme, .dark)
            .environmentObject(CountriesDao())
        }
    }
}
#endif

