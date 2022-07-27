//
//  CoreView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

import SwiftUI

struct CoreView: View {
    @EnvironmentObject var animations: AnimationInfo
    @EnvironmentObject var profile: ProfileManager
    var animationNamespace: Namespace.ID
    
    var body: some View {
        ZStack {
            ScrollView {
                
                VStack(spacing: 30) {
                    // Header
                    TabHeaderStruct("Core", iconName: "circle.fill", animationNamespace: self.animationNamespace)
                    
                    SixPackShuffleStruct()
                    
                    Spacer()
                    
                }
            }
            
            VStack {
                Spacer()
                FooterView()
            }
            
            
            
        }
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
    }
}
