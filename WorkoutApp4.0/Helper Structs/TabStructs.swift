//
//  TabStructs.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

/// Struct used to construct all TabButtons
/// - parameter labelText: text displayed below icon (used to describe tab)
/// - parameter iconName: systemName for icon shown on tab
/// - parameter animationNamespace: namespace used to link animations for switching tabs
/// - parameter tabToOpen: tab enum variable to which program changes global profile variable to
struct TabButton: View {
    // Variables / objects inherited
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var animations: AnimationInfo
    var animationNamespace: Namespace.ID
    
    // Instance variables
    private var labelText: String // Label for button
    private var iconName: String // String used to create SFSymbol
    private var iconAnimationID: String // String used to create unique animation ID for icon (is derived from labelText)
    private var titleTextAnimationID: String // String used to create unique animation ID for titleText (is derived from labelText)
    private var tabToOpen: Tab // Tab opened by button
    
    // Initializes all variables
    init(_ labelText: String, iconName: String, animationNamespace: Namespace.ID, tabToOpen: Tab) {
        self.labelText = labelText
        self.iconName = iconName
        self.animationNamespace = animationNamespace
        self.iconAnimationID = labelText.lowercased() + "Icon"
        self.titleTextAnimationID = labelText.lowercased() + "TitleText"
        self.tabToOpen = tabToOpen
    }

    var body: some View {
        Button(action: {
            withAnimation(Animation.linear(duration: 0.15)) {
                animations.tabOpened = self.tabToOpen // Opens a specific tab
            }
        }, label: {
            // ZStack label for button
            ZStack {
                // Background white rounded rectangle
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 6)
                
                VStack {
                    Spacer()
                    
                    // Creates SFSymbol image out of self.iconText string variable
                    Image(systemName: self.iconName)
                        .resizable()
                        .frame(width: 75, height: 75)
                        .foregroundColor(profile.preferredTheme)
                        .matchedGeometryEffect(id: self.iconAnimationID, in: self.animationNamespace)
                    
                    // Draws label based on self.labelText
                    Text(self.labelText)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.black.opacity(0.65))
                        .padding()
                        .matchedGeometryEffect(id: self.titleTextAnimationID, in: self.animationNamespace)
                }
            }
            .frame(width: 150, height: 175)
            
        })
        
        
        
    }
}



/// Struct used for header for all tab menus
struct TabHeaderStruct: View {
    // Variables / objects inherited
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var animations: AnimationInfo
    var animationNamespace: Namespace.ID
    
    // Instance variables
    private var titleText: String // Title for view
    private var titleAnimationID: String // String used to create unique animation ID for titleText (is derived from labelText)
    private var iconAnimationID: String // String used to create unique animation ID for icon (is derived from labelText)
    private var iconName: String // String used to create SFSymbol
    
    // Initializes all variables
    init(_ titleText: String, iconName: String, animationNamespace: Namespace.ID) {
        self.titleText = titleText
        self.titleAnimationID = titleText.lowercased() + "TitleText"
        self.iconAnimationID = titleText.lowercased() + "Icon"
        self.iconName = iconName
        self.animationNamespace = animationNamespace
    }
    
    var body: some View {
        HStack {
            // Title text
            Text(self.titleText)
                .matchedGeometryEffect(id: self.titleAnimationID, in: self.animationNamespace)
                .font(.system(size: 35, weight: .bold))
                .padding()
            
            // Icon image
            Image(systemName: self.iconName)
                .font(.system(size: 40))
                .foregroundColor(profile.preferredTheme)
                .matchedGeometryEffect(id: self.iconAnimationID, in: self.animationNamespace)
            
            Spacer()
            
        }
    }
}

