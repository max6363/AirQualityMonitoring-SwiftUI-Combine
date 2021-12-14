//
//  CityDataRow.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import SwiftUI

struct CityDataRow: View {
    
    @Binding var city: CityData
    
    func airQuality() -> AirQualityIndexClassification {
        return AirQualityIndexClassifier
            .classifyAirQualityIndex(aqi: self.city.aqi)
    }
    
    func aqiColor() -> Color {
        return AirQualityIndexInfoClassifier
            .color(index: self.airQuality())
            .suColor
    }
    
    func aqiDescriptionText() -> String {
        return AirQualityIndexInfoClassifier
            .text(index: self.airQuality())
    }
    
    var body: some View {
        HStack {
            ZStack (alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 1, y: 1)
                
                VStack(alignment: .leading) {
                    Text(city.name)
                        .font(.system(size: 22, weight: .medium, design: .default))
                    
                    HStack {
                        Text(String(format: "%.2f", city.aqi))
                            .font(.system(size: 18, weight: .medium, design: .default))

                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 3, height: 3)
                        
                        Circle()
                            .foregroundColor(self.aqiColor())
                            .frame(width: 15, height: 15)
                            .cornerRadius(7.5)
                            .shadow(color: .black, radius: 0.5, x: 0, y: 0)
                        
                        Circle()
                            .foregroundColor(.black)
                            .frame(width: 3, height: 3)
                        
                        Text(self.aqiDescriptionText())
                            .font(.callout)
                    }
                }
                .padding(5)                
            }
        }
    }
}

struct CityDataRow_Previews: PreviewProvider {
    
    @State static var cityData: CityData = {
        let data = CityData()
        data.aqi = 250.3
        data.name = "Ahmedabad"
        return data
    }()
    
    static var previews: some View {
        CityDataRow(city: $cityData)
            .frame(width: .infinity, height: 50)
            .padding()
    }
}