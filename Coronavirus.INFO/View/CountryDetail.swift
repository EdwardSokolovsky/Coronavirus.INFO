//
//  TutorDetail.swift
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
     
    var name: String
    let utils = Utils()
    let mainBackgroundColor = Color(red: 200, green: 17, blue: 255)
    init(countryName:String) {name = countryName}

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

    var body: some View {
        LoadingView (isShowing: $isShowingLoading) {
                VStack {
                    Image(self.name.capitalized)
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
                    .padding(6)
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
                        .padding(20)
                 Button(action: {
                 self.loadData()
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
            }
        .background(Color(red: 0.81, green: 1.0, blue: 0.98))
//        .background(Color.red)
//        .opacity(0.75)
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
        LoadingView (isShowing: $isShowingLoading) {
                VStack {
                    Image(self.name.capitalized)
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
                    .padding(10)
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
                    .foregroundColor(.black)
                }
            }
            .foregroundColor(.blue)
        .background(Color(red: 1.0, green: 1.0, blue: 1.0))
        .opacity(0.75)
    }

}
    
struct CountryDetailDebug_Previews : PreviewProvider {
    static var previews: some View {
        CountryDetailDebug(countryName:"central-african-republic")
    }
}
#endif

