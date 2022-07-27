//
//  CoreSliderStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/26/22.
//

import SwiftUI

func getWorkoutFormat(_ workoutDifficulty: Double)-> (Int, Int, Int, Int) {
    switch workoutDifficulty {
    case 0:
        return (30, 20, 7, 2)
    case 1:
        return (30, 20, 7, 3)
    case 2:
        return (40, 20, 7, 3)
    case 3:
        return (45, 15, 7, 3)
    default:
        return (50, 10, 7, 4)
    }
}



struct CoreSliderStruct: View {
    @EnvironmentObject var profile: ProfileManager
    @Binding var workoutDifficulty: Double
    
    var body: some View {
        ZStack {
            // Background Color to add slight darkening
            Color.black.opacity(0.05)
                .blur(radius: 50)
            
            VStack {
                // Shows workout format based on slider
                Text(getWorkoutText(workoutDifficulty: Int(self.workoutDifficulty)))
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.black.opacity(0.5))
                    .offset(y: 15)
                
                // Difficulty Slider
                Slider(value: $workoutDifficulty, in: 0...4, step: 1)
                    .tint(profile.preferredTheme)
                    .frame(width: 300)
                    .lineLimit(5)
                    .offset(y: 10)
                    
                
                // Shows difficulty level based on slider
                Text("Difficulty: \(getDifficulty(workoutDifficulty: Int(self.workoutDifficulty)))")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.black.opacity(0.5))
                
            }
        }
        .frame(width: 320, height: 90)
        .cornerRadius(20)
        .offset(y: 130)
    }
}

struct CoreSliderStruct_Previews: PreviewProvider {
    static var previews: some View {
        CoreSliderStruct(workoutDifficulty: .constant(2))
            .environmentObject(ProfileManager())
    }
}
