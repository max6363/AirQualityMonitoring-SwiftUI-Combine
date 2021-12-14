//
//  CitiesListViewModel.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Combine

class CitiesListViewModel: ObservableObject {
    
    @Published var cities = [CityData]()
    
    var subscriptions = Set<AnyCancellable>()
    
    var provider: DataProvider?
    
    init(with dataProvider: DataProvider) {
        provider = dataProvider
        subscribeToCityAQIData()
        provider?.subscribe()
    }
    
    private func isCityExist(cityData: CityDataResponse) -> CityData? {
        let matchedItems = self.cities.filter {  $0.name == cityData.city }
        return matchedItems.first ?? nil
    }
    
    private func addCity(cityData: CityDataResponse) {
        let c = CityData()
        c.name = cityData.city
        c.aqi = cityData.aqi
        self.cities.append(c)
    }
    
    private func subscribeToCityAQIData() {
        provider?.citySubscription
            .sink(receiveCompletion: { (error) in
                print("AQI Data stream error: \(error)")
            }, receiveValue: { [unowned self] values in
                
                for cityData in values {
                    if let matchedCity = isCityExist(cityData: cityData) {
                        matchedCity.aqi = cityData.aqi
                        self.objectWillChange.send()
                    } else {
                        self.addCity(cityData: cityData)
                    }
                }
            })
            .store(in: &subscriptions)
    }
    
    deinit {
        print("CitiesListViewModel deInit")
        provider?.unsubscribe()
    }
}
