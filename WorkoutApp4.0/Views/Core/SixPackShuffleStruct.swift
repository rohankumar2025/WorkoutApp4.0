//
//  SixPackShuffleStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct SixPackShuffleStruct: View {
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var timerManager: TimerManager
    @EnvironmentObject var workoutManager: CoreWorkoutManager
    var animationNamespace: Namespace.ID
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                // Title text
                Text("Six Pack Shuffle")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .matchedGeometryEffect(id: "SixPackShuffleTitleText", in: self.animationNamespace)
                    .onAppear {
                        if timerManager.timerMode == .initial {
                            // Randomizes workout initially
                            workoutManager.randomizeWorkout()
                            timerManager.setWorkout(workoutManager.getWorkoutFormat())
                        }
                    }
                
                // Total Time Remaining / Total Workout Time text
                Text((timerManager.timerMode == .initial ? "Total Workout Time" : "Total Time Remaining") + ": \(organizeTimer(timerManager.totalSecondsLeft))")
                
                // Background Rectangle
                ZStack {
                    BackgroundRectangle()
                    
                    // Workout Text
                    VStack {
                        ForEach(0..<workoutManager.abWorkout.count, id: \.self) { i in
                            Text("\(i+1). \(workoutManager.abWorkout[i])")
                                .font(.system(
                                    // Changes weight and size if index = currentExercise
                                    size: timerManager.currentExercise == i+1 ? 22 : 17,
                                    weight: timerManager.currentExercise == i+1 ? .bold : .medium))
                                .foregroundColor(.black.opacity(0.7))
                                .frame(width: 280, alignment: .leading)
                                .padding(2)
                        }
                    }
                    .frame(height: 300, alignment: .top)
                    
                    
                    // Displays slider if workout has not started, else displays seconds
                    Group {
                        if timerManager.timerMode == .initial { CoreSliderStruct() } else { SecondsTimerStruct() }
                    }
                    .offset(y: 130)
        
                }
                
                ShuffleButtonsStruct()
                
            }
            
        }
        .environmentObject(profile)
        .environmentObject(workoutManager)
        .environmentObject(timerManager)
        
    }
    
    
    
    
    
}

struct SixPackShuffleStruct_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SixPackShuffleStruct(animationNamespace: namespace)
            .environmentObject(ProfileManager())
    }
}
