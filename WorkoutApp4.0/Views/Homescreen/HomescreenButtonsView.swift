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
                TabButton("Nutrition", iconName: "takeoutbag.and.cup.and.straw.fill", animationNamespace: self.animationNamespace, tabToOpen: Tab.nutritionView)
                
                // Lifting tab button
                TabButton("Lifting", iconName: "circle.fill", animationNamespace: self.animationNamespace, tabToOpen: Tab.liftingView)
            }
            HStack(spacing: 30) {
                // Core tab button
                TabButton("Core", iconName: "circle.fill", animationNamespace: self.animationNamespace, tabToOpen: Tab.coreView)
                
                // Cardio tab button
                TabButton("Cardio", iconName: "circle.fill", animationNamespace: self.animationNamespace, tabToOpen: Tab.cardioView)            }
            
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
