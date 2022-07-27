//
//  WeightHistoryStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI
import SwiftUICharts

let weightHistory: [Double] = [176, 178, 184, 172, 174, 175, 173, 165, 162, 161, 171, 163, 181, 154, 176]

struct WeightHistoryStruct: View {
    @EnvironmentObject var profile: ProfileManager
    @State private var weightEntryStr: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Weight History")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            
            ZStack {
                if profile.weightHistory.isEmpty {
                    ZStack {
                        BackgroundRectangle()
                        Text("No Weight History\nAvailable")
                            .font(.system(size: 30, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black.opacity(0.6))
                    }
                } else {
                    let chartStyle = ChartStyle(
                        backgroundColor: profile.preferredTheme.opacity(0.15),
                        accentColor: .white,
                        gradientColor: GradientColor(
                            start: profile.preferredTheme.opacity(0.4),
                            end: profile.preferredTheme) ,
                        textColor: .black.opacity(0.7),
                        legendTextColor: .black,
                        dropShadowColor: .black.opacity(0.2))

                    // Bar Chart
                    BarChartView(data: ChartData(values: profile.getWeightChartData()),
                                 title: "Weight History",
                                 legend: "Weight",
                                 style: chartStyle,
                                 form: CGSize(width: 320, height: 350),
                                 dropShadow: true,
                                 cornerImage: nil,
                                 animatedToBack: true)
                    .id(profile.weightHistory)
                    
                }
                
                
            }
            
            // TODO: REMOVE THIS TEMPORARY WEIGHT ENTRY FIELD
            TextField("Weight Entry", text: $weightEntryStr)
                .keyboardType(.numbersAndPunctuation)
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .padding()
                .foregroundColor(.black.opacity(0.6))
                .background(profile.preferredTheme.opacity(0.3))
                .cornerRadius(15)
                .onSubmit {
                    self.storeWeight()
                }
            
            
            Spacer()
        }
    }
    
    
    func storeWeight() {
        if let weightEntry = Double(self.weightEntryStr) {
            // Appends weight to weightHistory array unless current date is equal to most recent date in weightHistoryDates array
            if getDate() == profile.weightHistoryDates.last {
                // Changes last element of weightHistory to current entry
                profile.weightHistory[profile.weightHistory.count-1] = weightEntry
            } else {
                // Appends current entry and date to both weightHistory and weightHistoryDates
                profile.weightHistory.append(weightEntry)
                profile.weightHistoryDates.append(getDate())
                updateUserInfo(updatedField: "WeightHistoryDates", info: profile.weightHistoryDates, infoType: [String].self)
            }
            // Updates weightHistory on Firebase
            updateUserInfo(updatedField: "WeightHistory", info: profile.weightHistory, infoType: [Double].self)
        }
        weightEntryStr = ""
        
    }
    
    
}

struct WeightHistoryStruct_Previews: PreviewProvider {
    static var previews: some View {
        WeightHistoryStruct()
            .environmentObject(ProfileManager())
    }
}
