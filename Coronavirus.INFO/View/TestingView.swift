//
//  TestingView.swift
//  Coronavirus.INFO
//
//  Created by Edward on 22.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation
import SwiftUI

struct TestingView : View {
    @State var tuggle: Bool = false
    
    let testArr:[String] = ["1","2","3","4"]
    
    var body: some View {
        VStack {
            VStack {
                Toggle(isOn: $tuggle) {
                    Text("Polzunok")
                    .offset(x: 100.0, y: 0.0)
                }
                .padding(50)
                Image(systemName: "play.rectangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100.0,height:100)
                    .offset(x: 0.0, y:-30.0)
                ForEach(testArr, id: \.self) { e in
                    Text("This is: \(e)")
                        .padding()
                }
            }
            Button(action: {
                if self.tuggle == false{
                    self.tuggle = true
                }else{
                    self.tuggle = false
                }
            }) {
                Text("Change tuggle status")
                .padding()
            }
        }
    }
    
    
    
    
}

struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestingView()
              .environment(\.colorScheme, .light)

            TestingView()
              .environment(\.colorScheme, .dark)
        }
    }

}
