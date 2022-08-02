//
//  CardioView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct CardioView: View {
    @EnvironmentObject var animations: AnimationInfo
    @EnvironmentObject var profile: ProfileManager
    var animationNamespace: Namespace.ID
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    TabHeaderStruct("Cardio", iconName: "cardio-tab", animationNamespace: self.animationNamespace, useSFSymbols: false)
                    
                    CardioTypeButton("Running") {
                        print("Pressed Running Button")
                    }
                    
                    CardioTypeButton("Cycling") {
                        print("Pressed Cycling Button")
                    }
                    
                    CardioTypeButton("Rowing") {
                        print("Pressed Rowing Button")
                    }
                    
                    CardioTypeButton("Walking") {
                        print("Pressed Cycling Button")
                    }
                    
                    
                    Spacer()
                }
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

struct CardioView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CardioView(animationNamespace: namespace)
            .environmentObject(AnimationInfo())
            .environmentObject(ProfileManager())
    }
}
