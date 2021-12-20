//
//  CityDataRow.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import SwiftUI

/// A `View` to render a row of City information
///
/// This is a part of a List of Cities.
struct CityDataRow: View {
    
    /// A `@Binding` variable for the city.
    ///
    /// The view is rendered when this property is updated.
    @Binding var city: CityData
    
    var body: some View {
        HStack {
            ZStack (alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 1, y: 1)
                
                VStack(alignment: .leading) {
                    Text(city.name)
                        .font(.system(size: 22, weight: .medium, design: .default))
                    
                    
                    CityAQIInfoView(city: $city)
                }
                .padding(5)                
            }
        }
    }
}

/// A `PreviewProvider` for `CityDataRow`
///
/// We can check that the View is rendered as expected
struct CityDataRow_Previews: PreviewProvider {
    
    @State static var cityData: CityData = {
        let data = CityData()
        data.aqi = 250.3
        data.name = "Ahmedabad"
        return data
    }()
    
    static var previews: some View {
        CityDataRow(city: $cityData)
            .frame(width: .infinity, height: 50)
            .padding()
    }
}
