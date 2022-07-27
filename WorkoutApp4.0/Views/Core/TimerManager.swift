//
//  TimerManager.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/26/22.
//

import Foundation
import SwiftUI


enum TimerMode {
    case initial
    case running
    case paused
}

enum ExerciseState {
    case resting
    case working
}

class TimerManager: ObservableObject {
    @Published var timerMode: TimerMode = .initial
    @Published var totalSecondsLeft: Int // Seconds left in entire workout
    @Published var secondsLeftInSet: Int // Seconds left in current exercise or rest
    @Published var currentExercise: Int = 1
    @Published var currentSet: Int = 1
    @Published var currentExerciseState: ExerciseState = .working
    
    var workoutFormat: (Int, Int, Int, Int) // Format: (Set length, Rest length, Number of exercises in circuit, Number of sets)
    
    init(_ workoutFormat: (Int, Int, Int, Int)) {
        self.workoutFormat = workoutFormat
        self.totalSecondsLeft = (workoutFormat.0 + workoutFormat.1) * workoutFormat.2 * workoutFormat.3 - workoutFormat.1 // (Set length + Rest length) * Num Exercises * Num Sets - Last Rest Length
        self.secondsLeftInSet = workoutFormat.0
    }
    
    func setWorkout(_ workoutFormat: (Int, Int, Int, Int)) {
        self.workoutFormat = workoutFormat
        self.totalSecondsLeft = (workoutFormat.0 + workoutFormat.1) * workoutFormat.2 * workoutFormat.3 - workoutFormat.1 // (Set length + Rest length) * Num Exercises * Num Sets - Last Rest Length
        self.secondsLeftInSet = workoutFormat.0
    }
    
    
    var timer = Timer()
    
    func pause() {
        self.timer.invalidate()
        self.timerMode = .paused
    }
    
    func reset() {
        self.timer.invalidate() // Ends timer
        
        // Resets all state variables
        self.timerMode = .initial
        self.totalSecondsLeft = (workoutFormat.0 + workoutFormat.1) * workoutFormat.2 * workoutFormat.3 - workoutFormat.1 // (Set length + Rest length) * Num Exercises * Num Sets - Last Rest Length
        self.secondsLeftInSet = workoutFormat.0
        self.currentExercise = 1
        self.currentSet = 1
        self.currentExerciseState = .working
    }
    

    func start() {
        self.timerMode = .running
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.totalSecondsLeft <= 0 {
                // Finishes workout, resets all timer info
                self.timerMode = .initial
                self.currentExercise = 1
                self.currentSet = 1
                print("Finished workout")
                self.totalSecondsLeft = (self.workoutFormat.0 + self.workoutFormat.1) * self.workoutFormat.2 * self.workoutFormat.3 - self.workoutFormat.1 // Sets it back to initial value
                timer.invalidate() // Ends timer
            } else if self.secondsLeftInSet <= 0 { // Set has finished
                
                if self.currentExerciseState == .working {
                    // Initialize rest break
                    self.secondsLeftInSet = self.workoutFormat.1 // Sets current set time to rest time
                    self.currentExercise += 1 // Moves to next exercise
                    if self.currentExercise > self.workoutFormat.2 { // If circuit has finished, moves currExercise to first one
                        self.currentExercise = 1
                    }
                    self.currentExercise *= -1 // Sets it equal to -1 * itself, so no exercise is bolded, but info is saved
                    self.currentExerciseState = .resting
                } else {
                    // Initialize working set
                    self.currentExercise *= -1 // Multiplies itself by -1 so exercise is now bolded
                    self.secondsLeftInSet = self.workoutFormat.0 // Sets current set time to set time
                    self.currentExerciseState = .working
                }
            } else {
                // Advances timer if no edge cases are reached
                self.secondsLeftInSet -= 1
                self.totalSecondsLeft -= 1
            }
        })
    }
}


/// Formats seconds into mm:ss format
func organizeTimer(seconds: Int) -> String {
    let secondsLeft:Int = seconds % 60
    let minutes:Int = seconds / 60
    let secondsStr: String = (secondsLeft < 10 ? "0\(secondsLeft)"  : String(secondsLeft) )
    let minutesStr: String = (minutes < 10 ? "0\(minutes)"  : String(minutes) )
    
    return minutesStr + ":" + secondsStr
}

