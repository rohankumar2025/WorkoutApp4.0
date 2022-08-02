//
//  ProfileManager.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import Foundation
import SwiftUI

let defaultPurple = Color.init(red: 160/255, green: 138/255, blue: 255/255) // TEMPORARY COLOR FOR UI
let defaultRed = Color.init(red: 242/255, green: 150/255, blue: 138/255)
let defaultGreen = Color.init(red: 177/255, green: 222/255, blue: 193/255)

class ProfileManager : ObservableObject{
    // Profile Info
    @Published var isLoggedIn : Bool = false
    @Published var username: String = ""
    @Published var preferredTheme: Color = defaultPurple // Holds main UI color
    @Published var profilePicURL: String = ""
    
    // Nutrition / Weight Info
    @Published var maintenanceCalories: Int = 2000
    @Published var caloriesEatenHistory: [Int] = []
    @Published var caloriesEatenHistoryDates: [String] = []
    @Published var weightHistory: [Double] = []
    @Published var weightHistoryDates: [String] = []
    
    // Lifting Info
    @Published var preferredWorkoutSplit: Int = -1
    
    
    init() {
        // Initializes isLoggedIn
        if FirebaseManager.shared.auth.currentUser?.uid != "" {
            getUpdatedUserData()
        }
        else { isLoggedIn = false }
    }
    
    
    /// Updates Current User Data stored in ProfileObject
    func getUpdatedUserData() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument{ snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                guard let data = snapshot?.data() else { return }
                
                // Profile
                self.profilePicURL = data["ProfilePicURL"] as? String ?? ""
                self.username = data["Username"] as? String ?? ""
                
                
                // Nutrition
                self.maintenanceCalories = data["MaintenanceCalories"] as? Int ?? 2000
                self.weightHistory = data["WeightHistory"] as? [Double] ?? []
                self.weightHistoryDates = data["WeightHistoryDates"] as? [String] ?? []
                
                // Calorie History
                if let currCaloriesHistory = data["CaloriesEatenHistory"] as? [Int] {
                    // Assigns to current data if not empty
                    self.caloriesEatenHistory = currCaloriesHistory
                } else {
                    // Initializes caloriesEatenHistoryDates if empty
                    self.caloriesEatenHistory.append(0)
                    updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: self.caloriesEatenHistoryDates, infoType: [Int].self)
                }
                
                // Calorie History Dates
                if let currCaloriesHistoryDates = data["CaloriesEatenHistoryDates"] as? [String] {
                    // Assigns to current data if not empty
                    self.caloriesEatenHistoryDates = currCaloriesHistoryDates
                } else {
                    // Initializes caloriesEatenHistoryDates if empty
                    self.caloriesEatenHistoryDates.append(getDate())
                    updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: self.caloriesEatenHistoryDates, infoType: [String].self)
                }
                
                // Starts new day for calories if not already done
                if self.caloriesEatenHistoryDates.last! != getDate() {
                    // If new day, appends 0 to caloriesEatenHistory and current date to caloriesEatenHistoryDates
                    self.caloriesEatenHistory.append(0)
                    self.caloriesEatenHistoryDates.append(getDate())
                    // Updates variables in Firebase
                    updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: self.caloriesEatenHistoryDates, infoType: [String].self)
                    updateUserInfo(updatedField: "CaloriesEatenHistory", info: self.caloriesEatenHistory, infoType: [Int].self)
                }
                
                self.preferredWorkoutSplit = data["PreferredWorkoutSplit"] as? Int ?? -1
                
                
                
                // Tells app that user is logged in
                self.isLoggedIn = true
                
                
            }
    }
    
    
    /// Helper function to get chart data array from profile object
    func getWeightChartData() -> [(String, Double)] {
        var chartData:[(String, Double)] = []
        for i in 0..<self.weightHistory.count {
            chartData.append((self.weightHistoryDates[i], self.weightHistory[i]))
        }
        return chartData
    }
    
    
}
