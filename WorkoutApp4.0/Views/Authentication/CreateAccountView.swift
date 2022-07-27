//
//  CreateAccountView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject var authInfo = AuthenticationInfo()
    @EnvironmentObject var profile: ProfileManager
    
    var body: some View {
        VStack(spacing: 40) {
            // Title text
            Text("Create Account")
                .font(.system(size: 40))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5)
            
            Spacer()
            
            Group {
                // Email textfield
                TextField("Email", text: $authInfo.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    
                // Password textfield
                SecureField("Password", text: $authInfo.password)
                
                // Re-enter password textfield
                SecureField("Re-enter Password", text: $authInfo.reEnteredPassword)
                    .onSubmit { createNewAccount() } // Submits info when user presses enter
            }
            .padding()
            .background(.white)
            
            Spacer()
            
            // Submit button
            Button { createNewAccount() }
                label: {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .padding()
                        .font(.system(size: 17, weight: .semibold))
                        .background(.blue.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 5)
                }
            
            Spacer()
            
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
    
    // Function called when Create Account Button is Pressed
    func createNewAccount() {
        // Does not authenticate user unless both passwords match
        if authInfo.password != authInfo.reEnteredPassword {
            authInfo.feedbackText = "Passwords do not match"
            return
            
        }
        
        authInfo.isLoading = true // Indicates that Firebase call is loading
        
        // Firebase call to authenticate new user
        FirebaseManager.shared.auth.createUser(withEmail: authInfo.email, password: authInfo.password) {
            result, error in
            if let err = error { // Error Message
                authInfo.feedbackText = convertErrorMessage(err as NSError)
                authInfo.isLoading = false
                return
            }

            // Create Account was successful if it reached this line of code
            authInfo.feedbackText = ""
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return } // Gets current User ID

            // TODO: Update Initial userData by adding more fields as more components are added
            let userInfo:Dictionary<String, Any> = [
                "Username": authInfo.email,
                "UID": uid,
                "ProfilePicURL": "",
                "WeightHistory": [],
                "WeightHistoryDates": [],
                "CaloriesEatenHistory": [0],
                "CaloriesEatenHistoryDates": [getDate()],
                "MaintenanceCalories": 2000
                ]
            // Stores userInfo into user's firestore file
            FirebaseManager.shared.firestore.collection("users").document(uid).setData(userInfo) { err in
                if let err = err {
                    print(err)
                    return
                }
            }

            profile.getUpdatedUserData() // Updates user Data
            profile.isLoggedIn = true // Indicates that user is logged in, Switches to ContentView()
            authInfo.isLoading = false // Indicates that Firebase call has finished
        }
    }
    
    
    
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
