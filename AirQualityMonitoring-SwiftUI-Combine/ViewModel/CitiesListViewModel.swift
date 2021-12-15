//
//  CitiesListViewModel.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Combine
import SwiftUICharts

class CitiesListViewModel: ObservableObject {
    
    @Published var cities = [CityData]()
    
    @Published var cityAQIs = [Double](repeating: 0.0, count: 10)
    
    var subscriptions = Set<AnyCancellable>()
    
    var provider: DataProvider?
    
    private var selectedCityData: CityData?
    
    init(with dataProvider: DataProvider) {
        provider = dataProvider
        subscribeToCityAQIData()
        subscribeToCityInformation()
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
    
    private func subscribeToCityInformation() {
        provider?.citySubscription
            .sink(receiveCompletion: { (error) in
                print("AQI Data stream error: \(error)")
            }, receiveValue: { [unowned self] values in
                
                if let currentCity = selectedCityData {
                                                            
                    self.cityAQIs.removeFirst()
                    
                    let matchedCity = values.filter {  $0.city == currentCity.name }
                    if let matchedCity = matchedCity.first {
                        self.cityAQIs.append(matchedCity.aqi)
                    } else {
                        self.cityAQIs.append(self.cityAQIs.last ?? 0.0)
                    }
                    self.objectWillChange.send()
                }
                #if DEBUG
                print("City Data: \(self.cityAQIs)")
                #endif
            })
            .store(in: &subscriptions)
    }
    
    func setSelectedCity(city: CityData) {
        cityAQIs = [Double](repeating: 0.0, count: 10)
        selectedCityData = city
        self.cityAQIs.removeFirst()
        self.cityAQIs.append(city.aqi)
        self.objectWillChange.send()
    }
    
    func clearCityAQIs() {
        selectedCityData = nil
        cityAQIs.removeAll()
        self.objectWillChange.send()
    }
    
    deinit {
        print("CitiesListViewModel deInit")
        provider?.unsubscribe()
    }
}
