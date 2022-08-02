//
//  CoreView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI



struct CoreView: View {
    @EnvironmentObject var animations: AnimationInfo
    @EnvironmentObject var profile: ProfileManager
    @StateObject var workoutManager = CoreWorkoutManager()
    @StateObject var timerManager = TimerManager()
    var animationNamespace: Namespace.ID
    
    var body: some View {
        Group {
            if workoutManager.coreTabOpened == .mainTab {

                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        TabHeaderStruct("Core", iconName: "core-tab", animationNamespace: self.animationNamespace, useSFSymbols: false)
                        
                        // Six Pack Shuffle
                        SixPackShuffleStruct(animationNamespace: self.animationNamespace)
                            .onTapGesture {
                                withAnimation(Animation.linear(duration: 0.2)) {
                                    workoutManager.coreTabOpened = .sixPackShuffleTab
                                }
                            }
                        Spacer()
                        FooterView()
                            .offset(y: UIScreen.main.bounds.height * 0.05)
                    }
                }
                
            } else {
                // Full screen sixPackShuffleView
                SixPackShuffleView(animationNamespace: self.animationNamespace)
            }
        }
        .environmentObject(workoutManager)
        .environmentObject(timerManager)
        .environmentObject(animations)
        .environmentObject(profile)
    }
    
}

struct CoreView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CoreView(animationNamespace: namespace)
            .environmentObject(AnimationInfo())
            .environmentObject(ProfileManager())
            .environmentObject(CoreWorkoutManager())
    }
}
