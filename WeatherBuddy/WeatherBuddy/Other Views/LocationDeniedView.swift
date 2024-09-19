//
//  LocationDeniedView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Label("Location Denied", systemImage: "location.slash.fill")
        }, description: {
            Text("Please enable location services in device settings.")
        }, actions: {
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }) {
                Text("Open Settings")
            }
            .buttonStyle(.borderedProminent)
        })
    }
}

#Preview {
    LocationDeniedView()
}
