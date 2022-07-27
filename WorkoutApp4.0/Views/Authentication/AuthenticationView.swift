//
//  AuthenticationView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthenticationInfo: ObservableObject {
    // Holds information about login
    @Published var email = ""
    @Published var password = ""
    @Published var reEnteredPassword = ""
    
    // Gives feedback when authentication is happening
    @Published var feedbackText = "" // Is blank unless user runs into authentication error
    @Published var isLoading = false
}


struct AuthenticationView: View {
    @EnvironmentObject var profile : ProfileManager
    @State var isLoggingIn = true
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack() {
                    // Upper Navigational Tab used to select between Login and Create Account fields
                    Picker(selection: self.$isLoggingIn, label: Text("Picker")){
                        Text("Login")
                            .tag(true) // Sets to Login tab by default
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: UIScreen.main.bounds.width * 0.85)
                    .background(Color.white)
                    .padding(70)
                    
                    Spacer()
                
                } // END VSTACK
                
                // Displays current view
                if self.isLoggingIn {
                    LoginView()
                } else {
                    CreateAccountView()
                }
                
                

            } // END ZSTACK
            
            .background(Image("GymPhoto")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 5)
                .offset(x:-50, y:20)
                .frame(height:800))
                
                
                
        } // END NAVIGATIONVIEW
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    
    
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(ProfileManager())
    }
}
