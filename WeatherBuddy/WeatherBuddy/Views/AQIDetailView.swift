//
//  AQIDetailView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/21/24.
//

import SwiftUI

struct AQIDetailView: View {
    @State private var barWidth: Double = 0
    let aqi: Int
    let description: String
    let pm2_5: Double
    let pm10: Double
    let o3: Double
    let no2: Double
    let so2: Double
    let co: Double
    
    var body: some View {
        VStack {
            if aqi == 1 || aqi == 2 {
                Image(systemName: "aqi.low")
                    .font(.system(size: 80))
                    .padding(.top)
            } else if aqi == 3 {
                Image(systemName: "aqi.medium")
                    .font(.system(size: 80))
                    .padding(.top)
            } else if aqi == 4 || aqi == 5 {
                Image(systemName: "aqi.high")
                    .font(.system(size: 80))
                    .padding(.top)
            }
            Spacer()
            Text("\(aqi)")
                .font(.largeTitle)
            Text(description)
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
            .padding()
            Spacer()
            List {
                HStack {
                    Text("PM2.5:")
                        .font(.system(size: 20))
                    Spacer()
                    Text("\(pm2_5.formatted()) µg/m³")
                        .font(.system(size: 20))
                }
                HStack {
                    Text("PM10:")
                        .font(.system(size: 20))
                    Spacer()
                    Text("\(pm10.formatted()) µg/m³")
                        .font(.system(size: 20))
                }
                HStack {
                    Text("O3:")
                        .font(.system(size: 20))
                    Spacer()
                    Text("\(o3.formatted()) µg/m³")
                        .font(.system(size: 20))
                }
                HStack {
                    Text("NO2:")
                        .font(.system(size: 20))
                    Spacer()
                    Text("\(no2.formatted()) µg/m³")
                        .font(.system(size: 20))
                }
                HStack {
                    Text("SO2:")
                        .font(.system(size: 20))
                    Spacer()
                    Text("\(so2.formatted()) µg/m³")
                        .font(.system(size: 20))
                }
                HStack {
                    Text("CO:")
                        .font(.system(size: 20))
                    Spacer()
                    Text("\(co.formatted()) µg/m³")
                        .font(.system(size: 20))
                }
            }
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    AQIDetailView(aqi: 3, description: "Fair", pm2_5: 10.0, pm10: 5.0, o3: 2.0, no2: 0.5, so2: 0.2, co: 0.1)
}
