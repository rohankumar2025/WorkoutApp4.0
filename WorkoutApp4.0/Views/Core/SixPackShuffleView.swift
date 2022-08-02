//
//  SixPackShuffleView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/29/22.
//

import SwiftUI

struct SixPackShuffleView: View {
    var animationNamespace: Namespace.ID
    @EnvironmentObject var profile: ProfileManager
    @EnvironmentObject var workoutManager: CoreWorkoutManager
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    // Button to leave view
                    Button(action: {
                        withAnimation(Animation.linear(duration: 0.2)) {
                            workoutManager.coreTabOpened = .mainTab
                        }
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    })
                    .padding()
                    
                    Spacer()
                }
                HStack {
                    Text("Six Pack Shuffle")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .matchedGeometryEffect(id: "SixPackShuffleTitleText", in: self.animationNamespace)
                        .padding()
                }
            }
        
            HStack {
                let currExerciseIndex = timerManager.currentExercise-1
            
                Text((currExerciseIndex < 0 || currExerciseIndex >= timerManager.workoutFormat.2) ? "Rest" : workoutManager.abWorkout[currExerciseIndex])
                    .font(.system(size: 35, weight: .bold))
                    .offset(x: UIScreen.main.bounds.width * 0.05, y: -UIScreen.main.bounds.height * 0.03)
                
                Spacer()
                
                CircleLoadingBar()
                    .padding()
            }
            
                
            // TODO: ADD ANIMATION FOR EXERCISE
            if timerManager.currentExerciseState != .resting {
                GifImage(workoutManager.abWorkout[timerManager.currentExercise-1])
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.65)
                    .cornerRadius(25)
                    .padding()
                    .id(timerManager.currentExercise)
            }
                
            // Forward and backwards buttons
            HStack {
                Spacer()
                
                // Backwards button
                ForwardsBackwardsButtons("backward.fill") { timerManager.decrementExercise() }
                
                if timerManager.timerMode == .running {
                    ForwardsBackwardsButtons("pause.fill", buttonSize: 40) { timerManager.pause() }
                } else {
                    ForwardsBackwardsButtons("play.fill", buttonSize: 40) { timerManager.start() }
                }
                
                // Forwards button
                ForwardsBackwardsButtons("forward.fill") { timerManager.incrementExercise() }
                
                Spacer()
            }
            
                
            
            Spacer()
            
            // Shuffle / Stop Button
            SixPackShuffleButtons(timerManager.timerMode == .initial ? "shuffle" : "square.fill") {
                timerManager.timerMode == .initial ? workoutManager.randomizeWorkout() : nil
                timerManager.reset()
            }
            
            Spacer()
        }
        .environmentObject(profile)
        .environmentObject(workoutManager)
        .environmentObject(timerManager)
    }
    
}

struct SixPackShuffleView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SixPackShuffleView(animationNamespace: namespace)
            .environmentObject(ProfileManager())
            .environmentObject(CoreWorkoutManager())
            .environmentObject(TimerManager())
    }
}
