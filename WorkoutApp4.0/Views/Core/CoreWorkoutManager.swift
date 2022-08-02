//
//  CoreWorkoutManager.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/29/22.
//

import Foundation


class CoreWorkoutManager: ObservableObject {
    enum CoreTab {
        case mainTab
        case sixPackShuffleTab
    }
    
    @Published var workoutDifficulty: Double = 0
    @Published var abWorkout: [String] = []
    @Published var coreTabOpened: CoreTab = .mainTab
    
    
    
    func randomizeWorkout() {
        self.abWorkout = []
        self.abWorkout.append(lowerAbExercises.randomElement()!)
        self.abWorkout.append(lowerAbRotationExercises.randomElement()!)
        self.abWorkout.append(midAbExercises.randomElement()!)
        self.abWorkout.append(midAbRotationExercises.randomElement()!)
        self.abWorkout.append(upperAbExercises.randomElement()!)
        self.abWorkout.append(upperAbRotationExercises.randomElement()!)
        self.abWorkout.append(accessoryExercises.randomElement()!)
    }
    
    func getWorkoutFormat() -> (Int, Int, Int, Int) {
        switch self.workoutDifficulty {
        case 0:
            return (40, 20, 7, 1)
        case 1:
            return (55, 20, 7, 1)
        case 2:
            return (45, 15, 7, 2)
        case 3:
            return (50, 15, 7, 2)
        default:
            return (50, 10, 7, 3)
        }
    }
    
    func getWorkoutText() -> String {
        let workoutFormat = self.getWorkoutFormat()
        let s = workoutFormat.3 > 1 ? "s" : "" // Adds an 's' if more than 1 set, else none
        return "\(workoutFormat.0) seconds on, \(workoutFormat.1) seconds off. \(workoutFormat.3) set\(s)."
    }
}
