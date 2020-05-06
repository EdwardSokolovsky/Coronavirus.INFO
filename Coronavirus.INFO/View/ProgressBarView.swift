//
//  LoadingBarView.swift
//  Coronavirus.INFO
//
//  Created by Edward on 14.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    @Binding var progressValue: Float
    @Binding var progressColorValue: Color
    @Binding var generalColorValue: Color
    
    var body: some View {
//        ZStack {
//            Color.white
//                .opacity(0.0)
//                .edgesIgnoringSafeArea(.all)
            VStack {
                ProgressBar(
                    progress: .constant(progressValue),
                    progressColor: .constant(progressColorValue),
                    generalColor: .constant(generalColorValue)
                    )
                    .frame(width: 150.0, height: 150.0)
//                    .padding(20.0)
                
//                Button(action: {
//                    self.incrementProgress()
//                }) {
//                    HStack {
//                        Image(systemName: "plus.rectangle.fill")
//                        Text("Increment")
//                    }
//                    .padding(10.0)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15.0)
//                            .stroke(lineWidth: 2.0)
//                    )
//                }
                
//                Spacer()
            }
//        }
    }
//    //for test:
//    func incrementProgress() {
//        let randomValue = Double([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
//        self.progressValue += randomValue
//    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    @Binding var progressColor: Color
    @Binding var generalColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.85)
                .foregroundColor(self.generalColor)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress/100, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
//                .opacity(0.75)
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
//            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                Text(String(format: "%.2f %%", min(self.progress, 1.0)))
                .font(.largeTitle)
                .bold()
                    .foregroundColor(self.progressColor)
                .opacity(0.88)
        }
    }
}

struct LoadingBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProgressBarView(
            progressValue: .constant(Float(0.5)),
            progressColorValue: .constant(Color.orange),
            generalColorValue: .constant(Color.green)
            )
    }
}
