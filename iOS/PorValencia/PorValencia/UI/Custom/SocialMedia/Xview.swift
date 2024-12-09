//
//  Xview.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import SwiftUI

struct Xview: View {
    
    let id : String
    
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme (light/dark mode)

    var body: some View {
        HStack(alignment: .center) {
            Image("image_x")
                .renderingMode(.template) // Enable tinting
                .foregroundColor(colorScheme == .dark ? .white : .black) // Change color based on the mode
            Button(id) {
                var idChecker = id
                if idChecker.first == "@" {
                    idChecker.removeFirst()
                }
                
                if let emailURL = URL(string: "https://twitter.com/\(idChecker)") {
                    UIApplication.shared.open(emailURL)
                }
            }
            .foregroundColor(.blue)
        }
    }
}

