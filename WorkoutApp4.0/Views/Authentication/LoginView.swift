//
//  LoginView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI
import SceneKit
struct LoginView: View {
    @StateObject var authInfo = AuthenticationInfo()
    @EnvironmentObject var profile: ProfileManager
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Log In")
                .font(.system(size: 40))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5)
            
            Spacer()
            
            Group {
                TextField("Email", text: $authInfo.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $authInfo.password)
                    .onSubmit { logInExistingAccount() } // Submits info when user presses enter
            }
            .padding()
            .background(.white)
            
            Spacer()
            
            Button {
                logInExistingAccount()
            } label: {
                Text("Log In")
                    .foregroundColor(.white)
                    .padding()
                    .font(.system(size: 17, weight: .semibold))
                    .background(.blue.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 5)
            }
            
            Spacer()
                .foregroundColor(.black)
            
            if authInfo.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(3)
            }
            
            // Feedback Text
            Text(authInfo.feedbackText)
                .foregroundColor(.white)
                .font(.system(size:20))
                .multilineTextAlignment(.center)

            
            Spacer()
            
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
    }
    
    
    
    
    
    // Function called when Log In Button is Pressed
    func logInExistingAccount() {
        authInfo.isLoading = true // Indicates that Firebase call is loading

        // Firebase call to authenticate existing user
        FirebaseManager.shared.auth.signIn(withEmail: authInfo.email, password: authInfo.password) {
            result, error in
            if let err = error { // Error Message
                authInfo.feedbackText = convertErrorMessage(err as NSError)
                authInfo.isLoading = false
                return
            }

            // Login was successful if it reached this line of code
            authInfo.feedbackText = ""

            profile.getUpdatedUserData() // Updates User Data
            profile.isLoggedIn = true // Indicates that user is logged in, Switches to ContentView()

            authInfo.isLoading = false // Indicates that Firebase call has finished

        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ProfileManager())
    }
}
