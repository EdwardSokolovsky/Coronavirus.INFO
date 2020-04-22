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
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    let countries: [Country] = CountriesDao().countriesArray

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
                List(self.countries.filter({c in c.name.capitalized.hasPrefix(self.searchText) || self.searchText == ""})) { country in
                        CountryCell(country: country)
                }.navigationBarTitle(Text("Countries statistic:"))
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
        }
    }
}

struct CountryCell : View {
    var country: Country
    var body: some View {
        return NavigationLink(destination: CountryDetail(countryName: country.name)) {
            VStack(alignment: .leading) {
                Text(country.name.capitalized)
                Text("Actual COVID'19 statistic for \(country.name.capitalized)")
                .font(.subheadline)
                .foregroundColor(.gray)
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

           ContentView()
              .environment(\.colorScheme, .dark)
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


