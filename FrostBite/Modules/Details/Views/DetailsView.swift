//
//  DetailsView.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import SwiftUI

struct DetailsView: View {
    @StateObject private var viewModel: DetailViewModel
    
    init(day: ForecastDayDTO) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(day: day))
    }
    
    var body: some View {
        ZStack {
            Image(ThemeHelper.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(ThemeHelper.isMorning ? 0.10 : 0.25)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    Spacer().padding(.top,20)
                    ForEach(Array(viewModel.hourlyItems.enumerated()), id: \.element.id) { index, item in
                        HStack {
                            Text(viewModel.hourTitle(for: item, index: index))
                                .foregroundColor(ThemeHelper.textColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            RemoteImageView(url: URL(string: "https:\(item.condition.icon)"))
                                .frame(width: 50, height: 50)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("\(Int(item.tempC))°")
                                .foregroundColor(ThemeHelper.textColor)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                        if index != viewModel.hourlyItems.count - 1 {
                            Divider()
                                .background(ThemeHelper.textColor.opacity(0.5))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Hourly Forecast")
        .navigationBarTitleDisplayMode(.inline)
    }
}

