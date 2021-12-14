//
//  CityData.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Combine

struct CityDataResponse: Codable {
    let city: String
    let aqi: Float
}

class CityData: Identifiable {
    let id: UUID = UUID()
    var name: String = ""
    var aqi: Float = 0.0
}
