//
//  EmailView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/13/24.
//

import SwiftUI

struct EmailView: View {
    let email: String

    @Environment(\.colorScheme) var colorScheme // Access the current color scheme (light/dark mode)

    var body: some View {
        HStack(alignment: .center) {
            Image("image_email")
                .renderingMode(.template) // Enable tinting
                .foregroundColor(colorScheme == .dark ? .white : .black) // Change color based on the mode
            Button(action: {
                if let emailURL = URL(string: "mailto:\(email)") {
                    UIApplication.shared.open(emailURL)
                }
            }) {
                Text(email)
                    .foregroundColor(.blue)
                    .underline() // Styling for better email visibility
            }
        }
    }
}

