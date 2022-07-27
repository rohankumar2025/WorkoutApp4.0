//
//  SettingsView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct SettingsView: View {
    var animationNamespace: Namespace.ID
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var animations: AnimationInfo
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                ChangeMaintenanceCaloriesTextField()
                ChangeUsernameTextField()
                Spacer()
                LogOutButton()
            }
            
            // VStack used to properly place settings button
            VStack {
                HStack {
                    SettingsButton(profile.preferredTheme, tabToOpen: Tab.defaultView, animationNamespace: self.animationNamespace)
                    Spacer()
                }
                Spacer()
            }
            
            
        }
        .environmentObject(profile)
        .environmentObject(animations)
    }
}





struct LogOutButton: View {
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var animations: AnimationInfo
    
    var body: some View {
        Button(
            action: {
                profile.isLoggedIn = false // Logs out user
                animations.tabOpened = Tab.defaultView // Resets tab to default view when new user logs in
            }, label: {
            Text("Log Out")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .background(profile.preferredTheme)
                    .cornerRadius(10)
        })
    }
}



struct SettingsView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SettingsView(animationNamespace: namespace)
            .environmentObject(ProfileManager())
            .environmentObject(AnimationInfo())
    }
}
