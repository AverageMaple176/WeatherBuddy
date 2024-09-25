//
//  AQIView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/21/24.
//

import SwiftUI

struct AQIView: View {
    @State private var barWidth: Double = 0
    let aqi: Int
    let description: String
    let pm2_5: Double
    let pm10: Double
    let o3: Double
    let no2: Double
    let so2: Double
    let co: Double
    
    @State private var showSheet: Bool = false
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Air Quality")
                    .font(.title2)
                Spacer()
                VStack {
                    Text("\(aqi)")
                        .font(.system(size: 50, weight: .light, design: .rounded))
                    Text("\(description)")
                }
                Spacer()
                if aqi == 1 || aqi == 2 {
                    Image(systemName: "aqi.low")
                        .font(.system(size: 40))
                } else if aqi == 3 {
                    Image(systemName: "aqi.medium")
                        .font(.system(size: 40))
                } else if aqi == 4 || aqi == 5 {
                    Image(systemName: "aqi.high")
                        .font(.system(size: 40))
                }
            }
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(colors: [.green, .yellow, .red], startPoint: .leading, endPoint: .trailing))
                        .frame(height: 5)
                        .readSize { size in
                            barWidth = size.width
                        }
                        .overlay {
                            if aqi == 1 {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 20)
                                        Circle()
                                            .fill(.green)
                                            .frame(height: 10)
                                    }
                                    Spacer()
                                }
                            } else if aqi == 2 {
                                HStack {
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .frame(height: 20)
                                        Circle()
                                            .fill(.green)
                                            .frame(height: 10)
                                    }
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                }
                            }else if aqi == 3 {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .frame(height: 20)
                                        Circle()
                                            .fill(.yellow)
                                            .frame(height: 10)
                                    }
                                }
                            } else if aqi == 4 {
                                HStack {
                                    Spacer()
                                    Spacer()
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .frame(height: 20)
                                        Circle()
                                            .fill(.orange)
                                            .frame(height: 10)
                                    }
                                    Spacer()
                                }
                            } else if aqi == 5 {
                                HStack {
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .frame(height: 20)
                                        Circle()
                                            .fill(.red)
                                            .frame(height: 10)
                                    }
                                }
                            }
                        }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            AQIDetailView(aqi: aqi, description: description, pm2_5: pm2_5, pm10: pm10, o3: o3, no2: no2, so2: so2, co: co)
        }
    }
}

