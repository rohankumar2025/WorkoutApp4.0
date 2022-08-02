//
//  InfoView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI


struct HomescreenButtonsView: View {
    @EnvironmentObject var animations: AnimationInfo
    @EnvironmentObject var profile: ProfileManager
    var animationNamespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 30) {
                // Nutrition tab button
                TabButton("Nutrition", iconName: "nutrition-tab", animationNamespace: self.animationNamespace, tabToOpen: .nutritionView, useSFSymbols: false)
                
                // Lifting tab button
                TabButton("Lifting", iconName: "lifting-tab", animationNamespace: self.animationNamespace, tabToOpen: .liftingView, useSFSymbols: false)
            }
            HStack(spacing: 30) {
                // Cardio tab button
                TabButton("Cardio", iconName: "cardio-tab", animationNamespace: self.animationNamespace, tabToOpen: .cardioView, useSFSymbols: false)
            
                // Core tab button
                TabButton("Core", iconName: "core-tab", animationNamespace: self.animationNamespace, tabToOpen: .coreView, useSFSymbols: false)
            }
            
        }
        .environmentObject(animations)
        .environmentObject(profile)
        .frame(height: UIScreen.main.bounds.height * 0.6, alignment: .top)
    }
    
}






struct InfoView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        HomescreenButtonsView(animationNamespace: namespace)
            .environmentObject(AnimationInfo())
            .environmentObject(ProfileManager())
    }
}
