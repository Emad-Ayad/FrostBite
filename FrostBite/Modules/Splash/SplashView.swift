//
//  SplashView.swift
//  FrostBite
//
//  Created by TaqieAllah on 06/06/2026.
//

import SwiftUI
import Lottie

struct SplashView: View {
    
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()         
        } else {
            ZStack {
                LinearGradient(
                    colors: ThemeHelper.isMorning
                    ? [
                        Color.blue.opacity(0.7),
                        Color.cyan.opacity(0.5),
                        Color.white
                    ]
                    : [
                        Color.indigo,
                        Color.blue.opacity(0.6),
                        Color.black
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {

                    LottieView {
                        LottieAnimation.named("weather_animation")
                    }
                    .playing(loopMode: .loop)
                    .frame(width: 250, height: 250)

                    Text("FrostBite")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)

                }
            }
            .task {
                try? await Task.sleep(for: .seconds(2.5))
                withAnimation(.easeInOut(duration: 0.5)) {
                    isActive = true
                }
            }
        }
    }
}
