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
    @Published var totalSecondsLeft: Int = 0 // Seconds left in entire workout
    @Published var secondsLeftInSet: Int = 0 // Seconds left in current exercise or rest
    @Published var currentExercise: Int = 1
    @Published var currentExerciseState: ExerciseState = .working
    @Published var workoutFormat: (Int, Int, Int, Int) = (0, 0, 0, 0) // Format: (Set length, Rest length, Number of exercises in circuit, Number of sets)
    
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
        self.currentExerciseState = .working
    }
    

    func start() {
        // Plays three beeps before starting workout and waits 3 seconds before beginning workout
        if self.timerMode == .initial {
            SoundManager.shared.playSound("startbeeps", extensionName: ".wav")
            sleep(3)
        }
        self.timerMode = .running
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.totalSecondsLeft <= 0 {
                // Finishes workout, resets all timer info
                self.timerMode = .initial
                self.currentExercise = 1
                print("Finished workout")
                self.totalSecondsLeft = (self.workoutFormat.0 + self.workoutFormat.1) * self.workoutFormat.2 * self.workoutFormat.3 - self.workoutFormat.1 // Sets it back to initial value
                timer.invalidate() // Ends timer
            } else if self.secondsLeftInSet <= 0 { // Set has finished
                
                SoundManager.shared.playSound("beep")
                
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
    
    func incrementExercise() {
        if self.currentExerciseState == .resting {
            self.currentExercise *= -1
            self.totalSecondsLeft -= self.secondsLeftInSet
            self.secondsLeftInSet = self.workoutFormat.0
            self.currentExerciseState = .working
        } else {
            self.currentExercise = (self.currentExercise == self.workoutFormat.2) ? -1 : (self.currentExercise + 1) * -1
            self.totalSecondsLeft -= self.secondsLeftInSet
            self.secondsLeftInSet = self.workoutFormat.1
            self.currentExerciseState = .resting
        }
    }
    
    func decrementExercise() {
        if self.currentExerciseState == .resting {
            self.currentExercise = (self.currentExercise == -1) ? self.workoutFormat.2 : (self.currentExercise * -1) - 1
            self.totalSecondsLeft += self.workoutFormat.1 - self.secondsLeftInSet + self.workoutFormat.0
            self.secondsLeftInSet = self.workoutFormat.0
            self.currentExerciseState = .working
        } else {
            self.currentExercise *= -1
            self.totalSecondsLeft += self.workoutFormat.0 - self.secondsLeftInSet + self.workoutFormat.1
            self.secondsLeftInSet = self.workoutFormat.1
            self.currentExerciseState = .resting
        }
    }
    
    
    
}


/// Formats seconds into mm:ss format
func organizeTimer(_ seconds: Int, showMinutes: Bool = true) -> String {
    let secondsLeft:Int = seconds % 60
    let minutes:Int = seconds / 60
    let secondsStr: String = (secondsLeft < 10 ? "0\(secondsLeft)"  : String(secondsLeft) )
    let minutesStr: String = (minutes < 10 ? "0\(minutes)"  : String(minutes) )
    
    return showMinutes ? minutesStr + ":" + secondsStr : secondsStr
}

