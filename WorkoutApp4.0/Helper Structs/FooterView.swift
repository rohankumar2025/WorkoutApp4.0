//
//  FooterView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct FooterView: View {
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var animations: AnimationInfo
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width * 0.17) {
            
            FooterButton(iconName: "house", buttonColor: .gray.opacity(0.5)) {
                withAnimation(Animation.linear(duration: 0.15)) {
                    animations.tabOpened = Tab.defaultView
                }
            }
            
            FooterButton(iconName: "plus.circle.fill", buttonSize: 50, buttonColor: profile.preferredTheme, fontWeight: .thin) {
                print("Pressed + button")
            }
            
            FooterButton(iconName: "calendar", buttonColor: .gray.opacity(0.5)) {
                print("Pressed Calendar Button")
            }
            
        }
        .padding(30)
        .frame(width: UIScreen.main.bounds.width, height: 110)
        .background(.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
        .offset(y: animations.tabOpened == Tab.defaultView ? 0 : 45)
    }

    
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .environmentObject(ProfileManager())
            .environmentObject(AnimationInfo())
    }
}
