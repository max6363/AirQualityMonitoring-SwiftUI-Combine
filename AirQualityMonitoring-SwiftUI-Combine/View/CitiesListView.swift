//
//  CitiesListView.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import SwiftUI

struct CitiesListView: View {
    
    @StateObject var modelData = CitiesListViewModel(with: DataProvider())
    
    var body: some View {
        NavigationView {
            List {
                ForEach($modelData.cities) { city in
                    CityDataRow(city: city)
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("City AQIs")
            .listStyle(.plain)
        }
    }
}

struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesListView(modelData: CitiesListViewModel(with: DummyDataProvider()))
    }
}
