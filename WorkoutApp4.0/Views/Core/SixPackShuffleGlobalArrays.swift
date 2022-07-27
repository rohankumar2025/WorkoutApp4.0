//
//  SixPackShuffleGlobalArrays.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/25/22.
//

import Foundation


let lowerAbExercises = ["Flutter Kicks", "Hands Back Tucks", "Leg Raises", "Hands Free Tucks", "Reverse Crunch"]
let lowerAbRotationExercises = ["Seated Ab Circles", "Scissors", "Figure 8's", "Windshield Wipers", "Jack Knives"]
let midAbExercises = ["Mountain Climbers", "Sprinter Tuck Planks", "Tuck Planks", "Tuck Planks (opposite side)", "X Man Crunch"]
let midAbRotationExercises = ["Twisting Pistons", "Twisted \"T\" Planks", "Accordian Crunches", "Cross Knee Planks", "Canoe Crunch"]
let upperAbExercises = ["Prayer Crunch", "Weighted Decline Situps", "Physioball Crunches", "Cable Crunch", "Crunch Holds"]
let upperAbRotationExercises = ["Crunch and Twists", "Starfish Crunch", "Recliner Elbow to Knee Tucks", "Upper Circle Crunch", "Side Crunches"]
let accessoryExercises = ["Ab Wheel Rollouts", "Around the World", "Supermans", "Back Extensions", "Stomach Vacuums"]

func getWorkoutText(workoutDifficulty: Int) -> String {
    switch workoutDifficulty {
    case 0:
        return "30 seconds on, 20 seconds off. Repeat 2 times."
    case 1:
        return "30 seconds on, 20 seconds off. Repeat 3 times."
    case 2:
        return "40 seconds on, 20 seconds off. Repeat 3 times."
    case 3:
        return "45 seconds on, 15 seconds off. Repeat 3 times."
    default:
        return "50 seconds on, 10 seconds off. Repeat 3-4 times."
    }
}

func getDifficulty(workoutDifficulty: Int) -> String {
    switch workoutDifficulty {
    case 0:
        return "Novice"
    case 1:
        return "Beginner"
    case 2:
        return "Intermediate"
    case 3:
        return "Expert"
    default:
        return "Elite"
    }
}
