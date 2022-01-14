//
//  CityDataResponse.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 20/12/21.
//

import Foundation

/// A model to parse air quality index values from the Server Data-Stream
public struct CityDataResponse: Codable {
    let city: String
    let aqi: Double
}
