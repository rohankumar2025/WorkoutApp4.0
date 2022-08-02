//
//  BackgroundRectangle.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct BackgroundRectangle: View {
    @EnvironmentObject var profile: ProfileManager
    private var width: Double
    private var height: Double
    private var opacity: Double
    
    init(width: Double = 320, height: Double = 350, opacity: Double = 0.15) {
        self.width = width
        self.height = height
        self.opacity = opacity
    }
    
    var body: some View {
        // Rounded rectangle background
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(profile.preferredTheme.opacity(self.opacity))
            .frame(width: self.width, height: self.height)
    }
}

struct BackgroundRectangle_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundRectangle()
            .environmentObject(ProfileManager())
    }
}
