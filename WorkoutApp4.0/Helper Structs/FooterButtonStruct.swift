//
//  FooterButtonStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import Foundation
import SwiftUI

struct FooterButton: View {
    private var iconName: String
    private var buttonSize: CGFloat
    private var buttonColor: Color
    private var buttonAction: () -> ()
    private var fontWeight: Font.Weight
    
    init(iconName: String, buttonSize: CGFloat = 30, buttonColor: Color, fontWeight: Font.Weight = .bold, buttonAction: @escaping () -> ()) {
        self.iconName = iconName
        self.buttonSize = buttonSize
        self.buttonColor = buttonColor
        self.buttonAction = buttonAction
        self.fontWeight = fontWeight
    }
    
    var body: some View {
        Button(action: { self.buttonAction() }, label: {
            Image(systemName: iconName)
                .font(.system(size: self.buttonSize, weight: self.fontWeight))
                .foregroundColor(self.buttonColor)
        })
    }
}
