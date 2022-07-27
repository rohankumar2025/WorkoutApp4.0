//
//  NutritionView.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

struct NutritionView: View {
    @EnvironmentObject var animations: AnimationInfo
    @EnvironmentObject var profile: ProfileManager
    var animationNamespace: Namespace.ID
    
    var body: some View {
        ZStack {
            ScrollView {
                
                VStack(spacing: 30) {
                    // Header
                    TabHeaderStruct("Nutrition", iconName: "takeoutbag.and.cup.and.straw.fill", animationNamespace: self.animationNamespace)
                    
                    // Calorie Chart
                    CalorieChart()
                    
                    // Weight History
                    WeightHistoryStruct()
                    
                    Spacer()
                    
                }
            }
            
            VStack {
                Spacer()
                FooterView()
            }
            
            
            
        }
        .environmentObject(animations)
        .environmentObject(profile)
    }
}

struct NutritionView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NutritionView(animationNamespace: namespace)
            .environmentObject(AnimationInfo())
            .environmentObject(ProfileManager())
    }
}
