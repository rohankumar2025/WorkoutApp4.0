//
//  MainViewController.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/22/22.
//

import SwiftUI

enum Tab {
    case defaultView
    case nutritionView
    case liftingView
    case cardioView
    case coreView
    case settingsView
}
class AnimationInfo : ObservableObject {
    @Published var tabOpened = Tab.defaultView
}

struct MainViewController: View {
    @StateObject var animations = AnimationInfo()
    @StateObject var profile = ProfileManager()
    
    
    @Namespace var animationNamespace
    
    var body: some View {
        ZStack {
            if profile.isLoggedIn {
                switch animations.tabOpened {
                case Tab.nutritionView:
                    NutritionView(animationNamespace: self.animationNamespace)
                case Tab.liftingView:
                    LiftingView(animationNamespace: self.animationNamespace)
                case Tab.cardioView:
                    CardioView(animationNamespace: self.animationNamespace)
                case Tab.coreView:
                    CoreView(animationNamespace: self.animationNamespace)
                case Tab.settingsView:
                    SettingsView(animationNamespace: self.animationNamespace)
                default:
                    HomescreenMainView(animationNamespace: self.animationNamespace)
                }
            } else {
                AuthenticationView()
            }
            
        }
        .environmentObject(animations)
        .environmentObject(profile)
        
    }
}

struct MainViewController_Previews: PreviewProvider {
    static var previews: some View {
        MainViewController()
    }
}
