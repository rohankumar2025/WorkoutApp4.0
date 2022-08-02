//
//  SoundManager.swift
//  WorkoutApp4.0
//
//  Created by Rohan Kumar on 7/27/22.
//

import Foundation
import AVKit
import SwiftUI

class SoundManager {
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(_ soundName: String, extensionName: String = ".mp3") {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: extensionName) else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
