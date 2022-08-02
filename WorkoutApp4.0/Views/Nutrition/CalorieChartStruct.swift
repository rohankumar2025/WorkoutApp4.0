//
//  CalorieChartStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import Foundation
import SwiftUI

struct CalorieChart : View {
    @EnvironmentObject var profile: ProfileManager
    @State private var mealEntryStr: String = ""
    
    var body: some View {
        let caloriesEatenToday: Int = profile.caloriesEatenHistory.last ?? 0
        let degreesEaten = Double(caloriesEatenToday) / Double(profile.maintenanceCalories) * 360 // Double value containing degrees of graph used by caloriesEaten
        
        VStack(alignment: .leading, spacing: 10) {
            Text("Calories")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            
            ZStack {
                BackgroundRectangle()
                    .environmentObject(profile)
                
                // Calorie Chart
                VStack {
                    ZStack {
                        // Calories left
                        PieceOfPie(startAngle: degreesEaten > 360 ? 360 : degreesEaten, endAngle: 360)
                            .foregroundColor(profile.preferredTheme)
                            .frame(width: 270, height: 270)
                        
                        // Calories eaten
                        PieceOfPie(startAngle: 0, endAngle: degreesEaten > 360 ? 360 : degreesEaten)
                            .foregroundColor(profile.preferredTheme.opacity(0.6))
                            .frame(width: 280, height: 280)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                // Text in middle of graph displaying calories left
                VStack {
                    Spacer()
                    Text("\( Int(profile.maintenanceCalories - caloriesEatenToday )) Calories Left")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black.opacity(0.5))
                        .padding()
                }
                
            }
            .shadow(color: .white.opacity(0.3), radius: 15, x: 0, y: 0)
            
            // Meal entry textfield
            TextField("Meal Entry", text: $mealEntryStr)
                .keyboardType(.numbersAndPunctuation)
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .padding()
                .foregroundColor(.black.opacity(0.6))
                .background(profile.preferredTheme.opacity(0.3))
                .cornerRadius(15)
                .onSubmit {
                    self.enterMeal()
                }
            
            
        }
    }
    
    func enterMeal() {
        if let mealEntry = Int(self.mealEntryStr) {
            if getDate() == profile.caloriesEatenHistoryDates.last {
                // Adds meal to last element of caloriesEatenHistory
                profile.caloriesEatenHistory[profile.caloriesEatenHistory.count-1] += mealEntry
            } else {
                // Appends current entry and date to both weightHistory and weightHistoryDates
                profile.caloriesEatenHistory.append(mealEntry)
                profile.caloriesEatenHistoryDates.append(getDate())
                updateUserInfo(updatedField: "CaloriesEatenHistoryDates", info: profile.caloriesEatenHistoryDates, infoType: [String].self)
            }
            // Updates weightHistory on Firebase
            updateUserInfo(updatedField: "CaloriesEatenHistory", info: profile.caloriesEatenHistory, infoType: [Int].self)
        }
        mealEntryStr = ""
    }
}
    
    





/// Used to construct Calorie Chart
struct PieceOfPie : Shape {
    let startAngle:Double
    let endAngle:Double
    
    // Function used in stroke()
    func path(in rect: CGRect) -> Path {
        Path { p in
            // Moves Brush to Center
            let center = CGPoint(x: rect.midX, y: rect.midY)
            p.move(to: center)
            // Adds arc based on number of degrees inputted
            p.addArc(
                center: center,
                radius: rect.width/2,
                startAngle: Angle(degrees: startAngle),
                endAngle: Angle(degrees: endAngle),
                clockwise: false)
            p.closeSubpath()
            
        }
    }
}
    
struct CalorieChart_Previews: PreviewProvider {
    static var previews: some View {
        CalorieChart()
            .environmentObject(AnimationInfo())
            .environmentObject(ProfileManager())
    }
}
