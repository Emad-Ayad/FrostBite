//
//  ThemeHelper.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import SwiftUI

struct ThemeHelper {
    
    static var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 5 && hour < 18
    }
    
    static var backgroundImageName: String {
        isMorning ? "morningBackground" : "eveningBackground"
    }
    
    static var textColor: Color {
        isMorning ? .black : .white
    }
    
    static var cardColor: Color {
        isMorning ? Color.white.opacity(0.25) : Color.black.opacity(0.25)
    }
}
