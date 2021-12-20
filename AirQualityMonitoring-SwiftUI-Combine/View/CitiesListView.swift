//
//  CitiesListView.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import SwiftUI

/// A `View` to render the list of Cities with their Air Quality Index Information
struct CitiesListView: View {
        
    /// A `@StateObject` variable of `CitiesListViewModel`, which is bind to the List
    ///
    /// The list is updated when Air quality index is changed for any city
    @StateObject var modelData = CitiesListViewModel(with: DataProvider())
        
    /// A default View renders with body variable of `View`
    var body: some View {
        
        /// A navigation-view
        NavigationView {
            
            List {
                ForEach($modelData.cities) { city in
                    ZStack {
                        NavigationLink(destination: DetailView(city: city)) {
                            EmptyView()
                                .listRowSeparator(.hidden)
                        }
                        .opacity(0.0)
                        
                        HStack {
                            CityDataRow(city: city)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("City AQIs")
            .listStyle(.plain)
        }
        .environmentObject(modelData)
    }
}

/// A `PreviewProvider` for `CitiesListView`
///
/// We can check that the View is rendered as expected
struct CitiesListView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesListView(modelData: CitiesListViewModel(with: DummyDataProvider()))
    }
}
