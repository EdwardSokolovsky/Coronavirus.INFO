//
//  LoadingView.swift
//  Coronavirus.INFO
//
//  Created by Edward on 16.04.2020.
//  Copyright © 2020 Edward'S. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    if self.isShowing{
                    Text("Loading...")
                        .font(.callout)
                        .italic()
//                        .padding(6)
//                        .foregroundColor(.black)
//                        .opacity(0.8)
                    }
                    ActivityIndicator(isAnimating: self.$isShowing, style: .large)
                }
                .frame(width: geometry.size.width / 1.5,
                       height: geometry.size.height / 2)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.black)
                .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}


struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
