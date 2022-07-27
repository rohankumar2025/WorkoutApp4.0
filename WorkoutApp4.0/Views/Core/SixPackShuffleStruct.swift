//
//  SixPackShuffleStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI



struct SixPackShuffleStruct: View {
    @EnvironmentObject var profile: ProfileManager
    @StateObject var timerManager = TimerManager((0, 0, 0, 0))
    
    @State var abWorkout: [String] = []
    @State var workoutDifficulty: Double = 0
    
    @State var workoutFormat: (Int, Int, Int, Int) = (0, 0, 0, 0)
    
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
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                // Title
                Text("Six Pack Shuffle")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                
                // Background Rectangle
                ZStack {
                    BackgroundRectangle()
                    
                    // Workout Text
                    VStack {
                        ForEach(0..<abWorkout.count, id: \.self) { i in
                            Text("\(i+1). \(abWorkout[i])")
                                .font(.system(
                                    size: timerManager.currentExercise == i+1 ? 20 : 17,
                                    weight: timerManager.currentExercise == i+1 ? .bold : .medium))
                                .foregroundColor(.black.opacity(0.7))
                                .frame(width: 280, alignment: .leading)
                                .padding(2)
                        }
                    }
                    .frame(height: 300, alignment: .top)
                    
                    // Slider + Difficulty Text
                    CoreSliderStruct(workoutDifficulty: self.$workoutDifficulty)
                }
                
                

                
            }
            
            HStack {
                Spacer()
                
                // Shuffle Button
                SixPackShuffleButtons("shuffle") {
                    self.randomizeWorkout()
                    self.timerManager.setWorkout(getWorkoutFormat(self.workoutDifficulty))
                }
                
                if !self.abWorkout.isEmpty {
                    // Displays play button if workout has been shuffled
                    // Displays pause button if workout timer is running
                    if timerManager.timerMode != .running {
                        SixPackShuffleButtons("play.fill") {
                            timerManager.start()
                        }
                    } else {
                        SixPackShuffleButtons("pause.fill") {
                            timerManager.pause()
                        }
                    }
                }
                
                
                
                Spacer()
            }
            
            Text("Total Time: \(organizeTimer(seconds: timerManager.totalSecondsLeft))")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black.opacity(0.6))
                .padding()
                .background(profile.preferredTheme.opacity(0.2))
                .cornerRadius(20)
            
            Text((timerManager.currentExerciseState == .working ? "Work" : "Rest") + ": \(organizeTimer(seconds: timerManager.secondsLeftInSet))")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black.opacity(0.6))
                .padding()
                .background(profile.preferredTheme.opacity(0.2))
                .cornerRadius(20)
            
            
            
        }
        .environmentObject(profile)
        .onAppear {
            self.randomizeWorkout()
            self.timerManager.setWorkout(getWorkoutFormat(self.workoutDifficulty))
        }
    }
    
    // Template struct for shuffle and play buttons
    struct SixPackShuffleButtons: View {
        @EnvironmentObject var profile: ProfileManager
        private var completion: ()->()
        private var iconName: String
        
        init(_ iconName: String, completion: @escaping ()->()) {
            self.iconName = iconName
            self.completion = completion
        }
        
        var body: some View {
            Button(action: {
                self.completion()
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 50)
                        .foregroundColor(profile.preferredTheme.opacity(0.2))
                    
                    Image(systemName: self.iconName)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(profile.preferredTheme)
                }
            })
            .padding([.leading, .trailing])
        }
    }
    
    
    
}

struct SixPackShuffleStruct_Previews: PreviewProvider {
    static var previews: some View {
        SixPackShuffleStruct()
            .environmentObject(ProfileManager())
    }
}
