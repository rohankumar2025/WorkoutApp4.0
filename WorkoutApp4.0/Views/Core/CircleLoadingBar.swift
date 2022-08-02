//
//  CircleLoadingBar.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/29/22.
//

import SwiftUI

struct CircleLoadingBar: View {
    @EnvironmentObject var workoutManager: CoreWorkoutManager
    @EnvironmentObject var timerManager: TimerManager
    @EnvironmentObject var profile: ProfileManager
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15)
                .opacity(0.2)
                .foregroundColor(.gray)
            
            let progress: Double = 1.0 - Double(timerManager.secondsLeftInSet) / Double(timerManager.currentExerciseState == .working ? timerManager.workoutFormat.0 : timerManager.workoutFormat.1)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .round, lineJoin: .round))
                .foregroundColor(profile.preferredTheme)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 2), value: progress)
            VStack {
                Text(organizeTimer(timerManager.secondsLeftInSet, showMinutes: false))
                    .font(.system(size: 40, weight: .bold))
                Text("seconds left")
                    .font(.system(size: 10))
            }
        }
        .padding()
        .frame(width: 150, height: 150)
    }
}

struct CircleLoadingBar_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleLoadingBar()
            .environmentObject(CoreWorkoutManager())
            .environmentObject(TimerManager())
            .environmentObject(ProfileManager())
    }
}
