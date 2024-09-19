//
//  WeatherAlert.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/15/24.
//

import SwiftUI
import WeatherKit

struct WeatherAlertView: View {
    let weatherManager = WeatherManager.shared
    let summary: String
    let source: String
    let details: URL
    @State private var showSheet: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .padding(.bottom, 3)
            Spacer()
            VStack {
                Text(summary)
                    .font(.system(size: 30))
                Text(source)
                
            }
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.2))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            WebView(url: details)
        }
    }
}

