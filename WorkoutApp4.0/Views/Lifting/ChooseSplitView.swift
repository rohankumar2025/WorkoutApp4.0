//
//  ChooseSplitView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 8/1/22.
//

import SwiftUI

let LiftingSplits = [
    ["Push", "Pull", "Legs"], // 0
    ["Upper", "Lower"], // 1
    ["Push", "Pull", "Legs", "Upper", "Lower"], // 2
    ["Chest & Back", "Legs", "Shoulders & Arms"], // 3
    ["Full Body"] // 4
]

func getMuscleGroups(liftingSplit: [String]) -> String {
    var muscleGroups = ""
    for i in 0..<liftingSplit.count {
        muscleGroups += liftingSplit[i]
        muscleGroups += i+1 == liftingSplit.count ? "" : ", "
    }
    
    return muscleGroups
}


struct ChooseSplitView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(LiftingSplits, id: \.self) { liftingSplit in
                    ZStack {
                        BackgroundRectangle(width: 320, height: Double(liftingSplit.count * 30 + 200))
                        VStack(alignment:.leading) {
                            Spacer()
                            ForEach(liftingSplit, id: \.self) { muscle in
                                Text(muscle)
                                    .font(.system(size: 25, weight: .medium))
                                    .padding(1)
                            }
                            
                            Spacer()
                            Text("\(liftingSplit.count)x / week")
                                .font(.system(size: 30, weight: .bold))
                                .padding()
                            
                        }
                    }
                    .padding()
                    
                    
                    
                }
            }
        }
        
        
    }
}

struct ChooseSplitView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseSplitView()
            .environmentObject(ProfileManager())
    }
}
