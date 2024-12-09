//
//  NotificationCell.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 12/1/24.
//

import SwiftUI

struct NotificationCell: View {
    
    let model: NotificationMoel
    @Environment(\.colorScheme) var colorScheme // Access system color scheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(model.title)
                .font(.headline)
                .foregroundColor(colorScheme == .dark ? .white : .black) // Conditional text color
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(model.text)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .white : .black) // Conditional text color
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(formatDate(model.date))
                .font(.caption)
                .foregroundColor(colorScheme == .dark ? .gray : .secondary) // Conditional color for the date text
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10) // Inner padding
        .background(colorScheme == .dark ? Color.black : Color.white) // Conditional background color
        .cornerRadius(16) // Rounded corners
        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Conditional shadow
        .padding(.horizontal, 10) // Horizontal padding
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss" // Desired format
        return formatter.string(from: date)
    }
}
