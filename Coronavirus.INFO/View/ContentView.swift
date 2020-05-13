//
//  ContentView.swift
//  Coronavirus.INFO
//
//  Created by Edward on 09.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var countriesDao: CountriesDao
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @State private var showFavoritesOnly = false
    
    var countries: [Country] = CountriesDao().countriesArray
    
    var body: some View {
        
        NavigationView {
            VStack {
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("search country", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                    .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
                
                Toggle(isOn: $showFavoritesOnly, label: {
                    Text("Show favorites only")
                })
                    .padding()
                    .foregroundColor(Color(.gray))
                
                if(showFavoritesOnly){
                    List(countriesDao.favoritesArray.filter({c in c.name.capitalized.hasPrefix(self.searchText) || self.searchText == ""})) { country in
                        CountryCell(country: country)
                    }
                    .navigationBarTitle(Text("Coronavirus statistic:"))
                    .resignKeyboardOnDragGesture()
                }else{
                    List(self.countries.filter({c in c.name.capitalized.hasPrefix(self.searchText) || self.searchText == ""})) { country in
                        CountryCell(country: country)
                    }
                    .navigationBarTitle(Text("Coronavirus statistic:"))
                    .resignKeyboardOnDragGesture()
                }
                
            }
        }
    }
}

struct CountryCell : View {
    @EnvironmentObject var countriesDao: CountriesDao
    @State var reaction = "heart"
    var country: Country
    
    private func addIntoFavorites(_ country: Country, _ reaction:String){
        countriesDao.addIntoFavorites(country, reaction)
    }
    private func removeFromFavorites(_ country: Country, _ reaction:String){
        countriesDao.removeFromFavorites(country, reaction)
    }
    private func favoritesContains(_ country: Country) -> Bool{
        countriesDao.favoritesArray.contains { $0 == country }
    }
    private func getReactionImage(_ country: Country) -> String{
        countriesDao.countriesArray[countriesDao.countriesArray.firstIndex(of: country)!].reaction
    }
    
    var body: some View {
        return NavigationLink(destination: CountryDetail(countryName: country.name)) {
            HStack(){
                
                VStack(alignment: .leading) {
                    Text(country.name.capitalized)
                    Text("Actual COVID'19 statistic for \(country.name.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .contextMenu {
                            
                            Button(self.favoritesContains(self.country) ? "Remove from Favorites" : "Add to Favorites") {
                                if(!self.favoritesContains(self.country)){
                                    self.reaction = "heart.fill"
                                    self.addIntoFavorites(self.country, self.reaction)
                                }else{
                                    self.reaction = "heart"
                                    self.removeFromFavorites(self.country, self.reaction)
                                }
                            }
                            
                    }
                }
                Image(systemName: self.getReactionImage(self.country))
                    .position(x: 165, y: 25)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
                .environmentObject(CountriesDao())
            
            ContentView()
                .environment(\.colorScheme, .dark)
                .environmentObject(CountriesDao())
        }
    }
}
#endif

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}


