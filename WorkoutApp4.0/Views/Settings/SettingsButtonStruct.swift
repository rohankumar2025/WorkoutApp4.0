//
//  SettingsButtonStruct.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import Foundation
import SwiftUI

/// Top-right button to display settings info
/// - parameter color: Color of button
/// - parameter tabToOpen: Tab opened by clicking button
/// - parameter animationNamespace: namespace inherited for animations to occur
/// - parameter offsetY: optional y-offset to help make sure button does not end up offscreen
struct SettingsButton: View {
    @EnvironmentObject var animations: AnimationInfo
    
    var animationNamespace: Namespace.ID
    private var color: Color
    private var tabToOpen: Tab
    private var offsetY: CGFloat
    
    init(_ color: Color = .white, tabToOpen: Tab, animationNamespace: Namespace.ID, offsetY: CGFloat = 0) {
        self.color = color
        self.animationNamespace = animationNamespace
        self.tabToOpen = tabToOpen
        self.offsetY = offsetY
    }
    
    var body: some View {
        Button(action: {
            withAnimation(Animation.linear(duration: 0.2)) {
                animations.tabOpened = self.tabToOpen
            }
        }, label: {
            Image(systemName: "line.3.horizontal.circle.fill")
                .font(.system(size: 30, weight: .light))
                .foregroundColor(color)
                .padding()
                .matchedGeometryEffect(id: "settingsButton", in: self.animationNamespace)
                .offset(y: self.offsetY)
        })
    }
}
