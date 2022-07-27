//
//  DefaultView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct HomescreenMainView: View {
    @EnvironmentObject var animations: AnimationInfo
    @EnvironmentObject var profile: ProfileManager
    private var displayFooter: Bool
    var animationNamespace: Namespace.ID
    
    init(animationNamespace: Namespace.ID, displayFooter: Bool = true) {
        self.animationNamespace = animationNamespace
        self.displayFooter = displayFooter
    }
    
    var body: some View {
        ZStack {
            VStack {
                // Tophalf of homescreen (passes namespace for all animations)
                HeaderView(animationNamespace: self.animationNamespace)
                
                // Shows all tab buttons (passes namespace for all animations)
                HomescreenButtonsView(animationNamespace: self.animationNamespace)
                    .offset(y:-UIScreen.main.bounds.height * 0.03)
            }
            if self.displayFooter {
                VStack {
                    Spacer()
                    // Shows bottom three buttons
                    FooterView()
                }
            }
            
        }
        .environmentObject(animations)
        .environmentObject(profile)
    }
}

struct ContentView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        HomescreenMainView(animationNamespace: namespace)
            .environmentObject(AnimationInfo())
            .environmentObject(ProfileManager())
    }
}
