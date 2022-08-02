//
//  ShuffleButtonsStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/29/22.
//

import Foundation
import SwiftUI

struct ShuffleButtonsStruct: View {
    @EnvironmentObject var timerManager: TimerManager
    @EnvironmentObject var workoutManager: CoreWorkoutManager
    
    var body: some View {
        HStack {
            
            // Shuffle / Stop Button
            SixPackShuffleButtons(timerManager.timerMode == .initial ? "shuffle" : "square.fill") {
                timerManager.timerMode == .initial ? workoutManager.randomizeWorkout() : nil
                timerManager.reset()
            }
            
            // Play / Pause Buttons
            SixPackShuffleButtons(timerManager.timerMode == .running ? "pause.fill" : "play.fill") {
                if timerManager.timerMode == .running {
                    timerManager.pause()
                } else {
                    withAnimation(Animation.linear(duration: 0.2)) {
                        workoutManager.coreTabOpened = .sixPackShuffleTab
                    }
                    timerManager.start()
                }
            }

        }
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

// Button used for forwards and backwards
struct ForwardsBackwardsButtons: View {
    private var completion: ()->()
    private var iconName: String
    private var buttonSize: Double
    
    init(_ iconName: String, buttonSize: Double = 25, completion: @escaping ()->()) {
        self.iconName = iconName
        self.completion = completion
        self.buttonSize = buttonSize
    }
    
    var body: some View {
        Button(action: { self.completion() },
            label: {
            Image(systemName: self.iconName)
                    .padding()
                    .opacity(0.8)
                    .foregroundColor(.black.opacity(0.8))
                    .font(.system(size: self.buttonSize))
            })
    }
}
