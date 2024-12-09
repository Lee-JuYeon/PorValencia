//
//  Instaview.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import SwiftUI

struct InstaView: View {
    
    let id : String
    
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme (light/dark mode)

    var body: some View {
        HStack(alignment: .center) {
            Image("image_insta")
                .renderingMode(.template) // Enable tinting
                .foregroundColor(colorScheme == .dark ? .white : .black) // Change color based on the mode
            Button(action: {
                var idChecker = id
                if idChecker.first == "@" {
                    idChecker.removeFirst()
                }
                
                if let instaURL = URL(string: "https://www.instagram.com/\(idChecker)/") {
                    UIApplication.shared.open(instaURL)
                }
            }) {
                Text(id)
                    .foregroundColor(.blue)
            }
        }
    }
}
