//
//  SearchView.swift
//  FrostBite
//
//  Created by TaqieAllah on 05/06/2026.
//

import SwiftUI
import SwiftData

import SwiftUI

struct SearchView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SearchViewModel()
    
    let onSelectCity: (String) -> Void
    
    var body: some View {
        ZStack {
            Image(ThemeHelper.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(ThemeHelper.isMorning ? 0.10 : 0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HStack {
                    TextField("Search city...", text: $viewModel.searchText)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .submitLabel(.search)
                        .onSubmit {
                            Task {
                                await viewModel.search()
                            }
                        }
                    
                    Button("Go") {
                        Task {
                            await viewModel.search()
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .foregroundColor(ThemeHelper.textColor)
                }
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Searching...")
                        .tint(ThemeHelper.textColor)
                        .foregroundColor(ThemeHelper.textColor)
                    Spacer()
                } else if !viewModel.errorMessage.isEmpty {
                    Spacer()
                    Text(viewModel.errorMessage)
                        .foregroundColor(ThemeHelper.textColor)
                        .multilineTextAlignment(.center)
                    Spacer()
                } else if let result = viewModel.result {
                    VStack(spacing: 12) {
                        Text(result.location.name)
                            .font(.largeTitle.bold())
                            .foregroundColor(ThemeHelper.textColor)
                        
                        Text("\(result.location.region), \(result.location.country)")
                            .foregroundColor(ThemeHelper.textColor.opacity(0.9))
                        
                        Text("\(Int(result.current.tempC))°")
                            .font(.system(size: 56, weight: .light))
                            .foregroundColor(ThemeHelper.textColor)
                        
                        Text(result.current.condition.text)
                            .foregroundColor(ThemeHelper.textColor)
                        
                        RemoteImageView(url: URL(string: "https:\(result.current.condition.icon)"))
                            .frame(width: 64, height: 64)
                        
                        Button("Open This City") {
                            onSelectCity(result.location.name)
                            dismiss()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .foregroundColor(ThemeHelper.textColor)
                    }
                    .padding()
                    .background(ThemeHelper.cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    
                    Spacer()
                } else {
                    Spacer()
                    Text("Enter a city name to get weather")
                        .foregroundColor(ThemeHelper.textColor)
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}
