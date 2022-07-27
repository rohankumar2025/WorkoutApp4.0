//
//  BackgroundRectangle.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct BackgroundRectangle: View {
    @EnvironmentObject var profile: ProfileManager
    
    var body: some View {
        // Rounded rectangle background
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(profile.preferredTheme.opacity(0.15))
            .frame(width: 320, height: 350)
    }
}

struct BackgroundRectangle_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundRectangle()
            .environmentObject(ProfileManager())
    }
}
