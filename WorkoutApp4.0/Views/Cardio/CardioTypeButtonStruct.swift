//
//  CardioTypeButtonStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/28/22.
//

import Foundation
import SwiftUI

struct CardioTypeButton: View {
    
    private var buttonName: String
    private var completion: ()->()
    
    init(_ buttonName: String, completion: @escaping ()->()) {
        self.buttonName = buttonName
        self.completion = completion
    }
    
    var body: some View {
        Button(
            action: {
                self.completion()
            },
            label: {
                ZStack {
                    BackgroundRectangle(width: UIScreen.main.bounds.width * 0.9, height: 100, opacity: 0.08)
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 0)
                    
                    HStack {
                        Text(self.buttonName)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.black.opacity(0.7))
                            .padding(.leading, 50)
                        Spacer()
                        Image("biking-photo")
                            .resizable()
                            .frame(width: 120, height: 100)
                    }
                }
            })
        
        
    }
}


struct CardioTypeButton_Previews: PreviewProvider {
    static var previews: some View {
        CardioTypeButton("Biking") {
            print("Test")
        }
        .environmentObject(ProfileManager())
    }
}
