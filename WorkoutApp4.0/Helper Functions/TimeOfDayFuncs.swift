//
//  TimeOfDayFuncs.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import Foundation

/// Helper function to determine greeting message based on time of day
func getGreeting() -> String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    switch hour{
    case 6...11:
        return "Good Morning!"
    case 12...17:
        return "Good Afternoon!"
    case 18...20:
        return "Good Evening!"
    default:
        return "Welcome Back!"
    }
}

func getDate() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter.string(from: date)
}
