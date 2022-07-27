//
//  HeaderView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI
import SDWebImageSwiftUI


struct HeaderView: View {
    @State private var greetingMessage: String = getGreeting()
    @State private var showImagePicker: Bool = false
    @State private var profilePic: UIImage?
    
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var animations: AnimationInfo
    
    var animationNamespace: Namespace.ID
    
    var body: some View {
        ZStack {
            
            // Background purple gradient
            LinearGradient(
                colors: [profile.preferredTheme.opacity(0.9), profile.preferredTheme.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack(alignment: .center) {
                // Profile picture
                Button{ self.showImagePicker = true }
                    label: { ProfileCircle() }
                
                // Good morning message
                Text(self.greetingMessage)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                
                // Username text
                Text(profile.username.uppercased())
                    .font(.system(size: 45, weight: .bold))
            }
            
            VStack { // Used to place settings button at top of screen
                HStack { // Used to place settings button at right of screen
                    Spacer()
                    // Displays topright settings button
                    SettingsButton(.white, tabToOpen: Tab.settingsView, animationNamespace: self.animationNamespace, offsetY: 40)
                    
                }
                Spacer()
            }
             
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
        .edgesIgnoringSafeArea(.top)
        .fullScreenCover(isPresented: self.$showImagePicker, onDismiss: {
            storeProfilePic(self.profilePic) {
                profile.getUpdatedUserData()
            }
            self.showImagePicker = false
        }) {
            ImagePicker(image: $profilePic) // Shows ImagePicker if showingImagePicker is true
        }
    }
    
    /// ZStack button displaying profile picture or default image
    struct ProfileCircle: View {
        @EnvironmentObject var profile: ProfileManager
        var body: some View {
            ZStack {
                // Draws white circle border outside picture
                Circle()
                    .strokeBorder(.white.opacity(0.7), lineWidth: 2)
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color.clear)
                
                if profile.profilePicURL == "" {
                    // Draws default picture if no profile pic entered
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 130, weight: .light))
                        .background(.clear)
                        .foregroundColor(.black.opacity(0.7))
                } else {
                // Shows Profile pic if available
                    WebImage(url: URL(string: profile.profilePicURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:130, height:130, alignment: .center)
                        .cornerRadius(120)
                    
                }
            }
        }
    }
    
}

struct HeaderView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        HeaderView(animationNamespace: namespace)
            .environmentObject(ProfileManager())
            .environmentObject(AnimationInfo())
    }
}
