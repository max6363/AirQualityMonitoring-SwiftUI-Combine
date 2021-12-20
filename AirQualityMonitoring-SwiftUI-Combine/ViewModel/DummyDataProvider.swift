//
//  DummyDataProvider.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 20/12/21.
//

import Foundation

/// A dummy data provider class for SwiftUI Previews
class DummyDataProvider: DataProvider {
    let dummyCities: [CityDataResponse] = [
        CityDataResponse(city: "Mumbai", aqi: 49.5),
        CityDataResponse(city: "Delhi", aqi: 299.01),
        CityDataResponse(city: "Kolkata", aqi: 125.969),
        CityDataResponse(city: "Chennai", aqi: 343.08),
        CityDataResponse(city: "Bengaluru", aqi: 425.47),
        CityDataResponse(city: "Lucknow", aqi: 75.6),
        CityDataResponse(city: "Pune", aqi: 550),
    ]
    
    /// `init` method
    ///
    /// send dummy cities to subscribers (mostly SwiftUI previews)
    override init() {
        super.init()
        self.citySubscription.send(dummyCities)
    }
}
