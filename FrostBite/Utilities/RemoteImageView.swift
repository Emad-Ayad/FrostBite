//
//  RemoteImageView.swift
//  FrostBite
//
//  Created by TaqieAllah on 02/06/2026.
//

import SwiftUI

struct RemoteImageView: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 40, height: 40)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.yellow)
            default:
                EmptyView()
            }
        }
        .frame(width: 50, height: 50)
    }
}
