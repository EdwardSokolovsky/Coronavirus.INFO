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
    @State var deathsPct:String = "?"
    @State var recoveredPct:String = "?"
    @State var populationValue:String = "?"
    @State var populationPercent: Float = 0.0
    @State var lastUpdate: String = ""
    @State var isShowingLoading: Bool = false

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
            deathsPercent: self.deathsPct,
            recoveredPercent: self.recoveredPct,
            populationValue: self.populationValue,
            populationPercent: self.$populationPercent,
            lastUpdate: self.lastUpdate
        )
        self.isShowingLoading.toggle()
    }
    private func getCountryData () -> [String:(String,String,String)]{
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
                    Text("Cases: \(self.countriesDao.savedData[self.name]?.cases ?? self.cases)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.orange)
                    Divider()
                    Text("Deaths: \(self.countriesDao.savedData[self.name]?.deaths ?? self.deaths) (\(self.countriesDao.savedData[self.name]?.deathsPercent ?? self.deathsPct)%)")
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
                        .foregroundColor(Color.green)
                    Divider()
                }
                .navigationBarTitle(Text(self.name.capitalized), displayMode: .inline)
                ProgressBarView(progressValue: self.countriesDao.savedData[self.name]?.populationPercent ?? self.$populationPercent)
                .padding(.vertical, 20)
                Text("*percent population infected")
                    .foregroundColor(Color.orange)
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
                Text("\(self.countriesDao.savedData[self.name]?.7 ?? self.lastUpdate)")
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
struct CountryDetailDebug : View {
    var name: String
    init(countryName:String) {name = countryName}
    @State var cases:String = "?"
    @State var deaths:String = "?"
    @State var recovered:String = "?"
    @State var deathsPct:String = "?"
    @State var recoveredPct:String = "?"
    @State var populationValue:String = "?"
    @State var populationPercent:Float = 0.0
    @State var lastUpdate: String = ""
    @State var isShowingLoading: Bool = false

    var body: some View {
//        LoadingView (isShowing: $isShowingLoading) {
                VStack {
                     VStack {
//                        Image(self.name.capitalized)
                        Image("Default")
                        .cornerRadius(10.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1.5)
                                )
                VStack {
                    ZStack {
                    Text("\(self.name.capitalized):")
                        .font(.largeTitle)
                        .font(.callout)
                        .padding(6)
                        .foregroundColor(.white)
                    }.background(Color.black)
                    .opacity(0.8)
                    .cornerRadius(10.0)
                    .padding(5)
                    Divider()
                    Text("Cases: \(self.cases)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.orange)
                    Divider()
                    Text("Deaths: \(self.deaths) (\(self.deathsPct)%)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.red)
                    Divider()
                    Text("Recovered: \(self.recovered) (\(self.recoveredPct)%)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.yellow)
                    Divider()
                    Text("Population: \(self.populationValue)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.green)
                    Divider()
                }.navigationBarTitle(Text(self.name), displayMode: .inline)
                    ProgressBarView(progressValue: self.$populationPercent)
                    .padding(10)
                    Text("*percent population infected")
                    .foregroundColor(.black)
                    .padding(.vertical, 20)
                 Button(action: {
                    self.cases = "100"
                    self.deaths = "10"
                    self.recovered = "70"
                    self.deathsPct = "10"
                    self.recoveredPct = "70"
                    self.populationValue = "100000"
                    self.populationPercent = 0.5
                    self.lastUpdate = "Last update 20.20.20 15:00:00"
                 }) {
                 Text("Update data")
                   }
                           .padding()
                           .foregroundColor(.white)
                           .background(Color.red)
                           .cornerRadius(8)
                 Text("\(self.lastUpdate)")
                           .font(.callout)
                           .padding(10)
                           .font(.system(size: 15))
                           .foregroundColor(.gray)
                   }
                   .padding(.vertical, 45)
            }
//       }
            .foregroundColor(.blue)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(red: 0.4, green: 0.4, blue: 0.8))
//                    .background(Color(.systemBackground))
    }

}
    
struct CountryDetailDebug_Previews : PreviewProvider {
    static var previews: some View {
        CountryDetailDebug(countryName:"argentina")
    }
}
#endif

