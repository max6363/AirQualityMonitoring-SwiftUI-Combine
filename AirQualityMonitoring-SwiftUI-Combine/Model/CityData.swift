//
//  CityData.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Combine
import SwiftUI

struct CityDataResponse: Codable {
    let city: String
    let aqi: Double
}

class CityData: Identifiable {
    let id: UUID = UUID()
    var name: String = ""
    var aqi: Double = 0.0
}

extension CityData {
    var airQuality: AirQualityIndexClassification {
        get {
            return AirQualityIndexClassifier
                .classifyAirQualityIndex(aqi: self.aqi)
        }
    }
    
    var aqiColor: Color {
        get {
            return AirQualityIndexInfoClassifier
                .color(index: self.airQuality)
                .suColor
        }
    }
    
    var aqiDescriptionText: String {
        get {
            return AirQualityIndexInfoClassifier
                .text(index: self.airQuality)
        }
    }
}
