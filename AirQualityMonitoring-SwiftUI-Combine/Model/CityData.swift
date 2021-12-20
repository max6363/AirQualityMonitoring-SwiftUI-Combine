//
//  CityData.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Combine
import SwiftUI

/// A model to show this in List
///
/// Confirms to `Identifiable` protocol for the SwiftUI List compatibility
public class CityData: Identifiable {
    public let id: UUID = UUID()
    var name: String = ""
    var aqi: Double = 0.0
}

/// `CityData` extension
///
/// Retrieve the other information based on air quality index value
public extension CityData {
    
    /// A variable - to get `AirQualityIndexClassification`
    /// based on air quality index value
    var airQuality: AirQualityIndexClassification {
        get {
            return AirQualityIndexClassifier
                .classifyAirQualityIndex(aqi: self.aqi)
        }
    }
        
    /// A variable - to get `Color`
    /// based on Air Quality Classification
    var aqiColor: Color {
        get {
            return AirQualityIndexInfoClassifier
                .color(index: self.airQuality)
                .suColor
        }
    }
        
    /// A variable - to get air quality classification description text in `String`
    var aqiDescriptionText: String {
        get {
            return AirQualityIndexInfoClassifier
                .text(index: self.airQuality)
        }
    }
}
