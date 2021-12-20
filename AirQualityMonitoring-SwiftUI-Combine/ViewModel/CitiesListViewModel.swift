//
//  CitiesListViewModel.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Combine
import SwiftUICharts

/// `CitiesListViewModel` as an `ObservableObject`
///
/// A ViewModel to connect View and Model
/// Get a list of cities
public class CitiesListViewModel: ObservableObject {
        
    /// A public variable as an Array to store `CityData`,
    /// initialized with empty array.
    ///
    /// The @Published variable can be subscribed and get notified when the array is updated
    @Published var cities = [CityData]()
    
    /// A public variable as fixed size Array of Air Quality Indices of a City,
    /// to be used on the Detail (Realtime graph) page
    @Published var cityAQIs = [Double](repeating: 0.0, count: 10)
    
    /// A `Set` of subscriptions which are cancellable
    public var subscriptions = Set<AnyCancellable>()
    
    /// A `DataProvider` is a Data Source
    public var provider: DataProvider?
    
    /// A private variable for the selected city
    private var selectedCityData: CityData?
    
    /// `Init` method
    /// - Parameter dataProvider: a `DataProvider`
    public init(with dataProvider: DataProvider) {
        provider = dataProvider
        subscribeToCityAQIData()
        subscribeToCityInformation()
        provider?.subscribe()
    }
    
    /// A private method to check if city is available current city list
    /// - Parameter cityData: A `CityDataResponse` object
    /// - Returns: `CityData` if matches with parameter of city data, otherwise `nil`
    private func isCityExist(cityData: CityDataResponse) -> CityData? {
        let matchedItems = self.cities.filter {  $0.name == cityData.city }
        return matchedItems.first ?? nil
    }
    
    /// A private method to append city data
    /// - Parameter cityData: A `CityDataResponse`, received from Air quality index service
    private func addCity(cityData: CityDataResponse) {
        let c = CityData()
        c.name = cityData.city
        c.aqi = cityData.aqi
        self.cities.append(c)
    }
    
    /// A private method to subscribe to Data-Stream for Air quality index of Cities
    ///
    /// Check if city data is exist, if yes then update, otherwise append.
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
    
    /// A private method to subscribe to Data-Stream for Air quality index
    ///
    /// Add the latest AQI value for city (if recieved), otherwise recent is re-added to the city's aqi array
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
    
    /// A method to select current city when showing a realtime graph on Detail Page.
    ///
    /// - Parameter city: A `CityData` object
    public func setSelectedCity(city: CityData) {
        cityAQIs = [Double](repeating: 0.0, count: 10)
        selectedCityData = city
        self.cityAQIs.removeFirst()
        self.cityAQIs.append(city.aqi)
        self.objectWillChange.send()
    }
    
    /// A method to clear all data, selectedCity etc.
    public func clearCityAQIs() {
        selectedCityData = nil
        cityAQIs.removeAll()
        self.objectWillChange.send()
    }
    
    /// deinit the subscriptions, values etc
    deinit {
        print("CitiesListViewModel deInit")
        provider?.unsubscribe()
    }
}
