//
//  LiftingView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI




struct LiftingView: View {
    @EnvironmentObject var animations: AnimationInfo
    @EnvironmentObject var profile: ProfileManager
    var animationNamespace: Namespace.ID
    
    var body: some View {
        if profile.preferredWorkoutSplit == -1 {
            ChooseSplitView()
                .environmentObject(profile)
        } else {
            ZStack {
                VStack {
                    TabHeaderStruct("Lifting", iconName: "lifting-tab", animationNamespace: self.animationNamespace, useSFSymbols: false)
                    
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    FooterView()
                }
                
                
            }
            .environmentObject(profile)
            .environmentObject(animations)
        }
    
    }
}

struct LiftingView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        LiftingView(animationNamespace: namespace)
            .environmentObject(AnimationInfo())
            .environmentObject(ProfileManager())
    }
}
