//
//  CoreSliderStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/26/22.
//

import SwiftUI

struct CoreSliderStruct: View {
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var timerManager: TimerManager
    @EnvironmentObject var workoutManager: CoreWorkoutManager
    
    var body: some View {
        ZStack {
            // Background Color to add slight darkening
            Color.black.opacity(0.05)
                .blur(radius: 50)
            
            VStack {
                // Shows workout format based on slider
                Text(workoutManager.getWorkoutText())
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.black.opacity(0.5))
                    .offset(y: 15)
                
                // Difficulty Slider
                Slider(
                    value: Binding(
                        // Binds slider to workoutState.workoutDifficulty
                        get: { workoutManager.workoutDifficulty },
                        set: { newValue in
                            // Updates workoutDifficulty and workoutFormat on change
                            workoutManager.workoutDifficulty = newValue
                            timerManager.setWorkout(workoutManager.getWorkoutFormat())
                        }
                    ),
                    in: 0...4,
                    step: 1)
                        .tint(profile.preferredTheme)
                        .frame(width: 300)
                        .lineLimit(5)
                        .offset(y: 10)
                
                // Shows difficulty level based on slider
                let getDifficulty: Dictionary<Double, String> = [0: "Novice", 1: "Beginner", 2: "Intermediate", 3: "Expert", 4: "Elite"]

                Text("Difficulty: \(getDifficulty[workoutManager.workoutDifficulty] ?? "")")
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundColor(.black.opacity(0.5))
                
            }
        }
        .frame(width: 320, height: 90)
        .cornerRadius(20)
    }
}

struct CoreSliderStruct_Previews: PreviewProvider {
    static var previews: some View {
        CoreSliderStruct()
            .environmentObject(ProfileManager())
            .environmentObject(CoreWorkoutManager())
            .environmentObject(TimerManager())
    }
}
