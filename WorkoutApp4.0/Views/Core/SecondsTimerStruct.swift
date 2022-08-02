//
//  SecondsTimerStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/27/22.
//

import SwiftUI

struct SecondsTimerStruct: View {
    @EnvironmentObject var workoutManager: CoreWorkoutManager
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        HStack {
            // Button to go back an exercise
            ForwardsBackwardsButtons("backward.fill", buttonSize: 15) {
                timerManager.decrementExercise()
            }
            
            Spacer()
            
            VStack {
                Text(organizeTimer(timerManager.secondsLeftInSet, showMinutes: false))
                    .font(.system(size: 40, weight: .bold))
                
                Text(timerManager.currentExerciseState == .resting ? "rest" : "seconds left")
            }
            
            Spacer()
            
            // Button to skip an exercise
            ForwardsBackwardsButtons("forward.fill", buttonSize: 15) {
                timerManager.incrementExercise()
            }
        }
        .foregroundColor(.black.opacity(0.6))
        .padding()
        .frame(width: 320, height: 90)
        .background(.black.opacity(0.03))
        .cornerRadius(20)
    }
}

struct SecondsTimerStruct_Previews: PreviewProvider {
    static var previews: some View {
        SecondsTimerStruct()
            .environmentObject(CoreWorkoutManager())
            .environmentObject(TimerManager())
    }
}
