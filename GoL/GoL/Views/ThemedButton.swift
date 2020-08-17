//
//  ThemedButton.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 7/12/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//


import SwiftUI

struct ThemedButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Text(text)
                    .font(.system(size: 12.0, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    //.fixedSize(horizontal: false, vertical: true)
                    .frame(width: 80.0, height: 55.0)
            }
            .background(Color("accent"))
            // Your Problem 2 code goes here.
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2.0))
            .shadow(radius: 2.0)
                .background(Circle())
            Spacer()
        }
    }
}

// MARK: Previews
struct ThemedButton_Previews: PreviewProvider {
    static var previews: some View {
        ThemedButton(text: "Step") { }
    }
}
