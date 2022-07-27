//
//  SettingsTextFieldStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/25/22.
//

import Foundation
import SwiftUI

struct ChangeUsernameTextField: View {
    @EnvironmentObject var profile: ProfileManager
    @State private var updatedUsername: String = ""
    
    var body: some View {
        TextField("Update Username", text: $updatedUsername)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.7, height: 50)
            .background(profile.preferredTheme.opacity(0.6))
            .cornerRadius(15)
            .foregroundColor(.white)
            .onSubmit {
                updateUserInfo(updatedField: "Username", info: self.updatedUsername, infoType: String.self)
                self.updatedUsername = ""
                profile.getUpdatedUserData()
            }
    }
}

struct ChangeMaintenanceCaloriesTextField: View {
    @EnvironmentObject var profile: ProfileManager
    @State private var updatedCaloriesStr: String = ""
    
    var body: some View {
        TextField("Update Maintenance Calories", text: $updatedCaloriesStr)
            .padding()
            .keyboardType(.numbersAndPunctuation)
            .frame(width: UIScreen.main.bounds.width * 0.7, height: 50)
            .background(profile.preferredTheme.opacity(0.6))
            .cornerRadius(15)
            .foregroundColor(.white)
            .onSubmit {
                if let updatedCalories = Int(updatedCaloriesStr) {
                    updateUserInfo(updatedField: "MaintenanceCalories", info: updatedCalories, infoType: Int.self)
                    self.updatedCaloriesStr = ""
                    profile.getUpdatedUserData()
                }
            }
    }
}
