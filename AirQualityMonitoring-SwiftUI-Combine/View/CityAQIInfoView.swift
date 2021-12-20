//
//  CityAQIInfoView.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 20/12/21.
//

import SwiftUI

/// A `View` is used to show inline details of air quality index of city (`CityData`)
struct CityAQIInfoView: View {
    
    /// A `@Binding` variable for the city
    ///
    /// The view is rendered when this property is updated.
    @Binding var city: CityData
    
    var body: some View {
        HStack {
            Text(String(format: "%.2f", city.aqi))
                .font(.system(size: 18, weight: .medium, design: .default))

            Circle()
                .foregroundColor(.black)
                .frame(width: 3, height: 3)
            
            Circle()
                .foregroundColor(city.aqiColor)
                .frame(width: 15, height: 15)
                .cornerRadius(7.5)
                .shadow(color: .black, radius: 0.5, x: 0, y: 0)
            
            Circle()
                .foregroundColor(.black)
                .frame(width: 3, height: 3)
            
            Text(city.aqiDescriptionText)
                .font(.callout)
        }
    }
}

/// A `PreviewProvider` for `CityAQIInfoView`
///
/// We can check that the View is rendered as expected
struct CityAQIInfoView_Previews: PreviewProvider {
    
    @State static var cityData: CityData = {
        let data = CityData()
        data.aqi = 250.3
        data.name = "Ahmedabad"
        return data
    }()
    
    static var previews: some View {
        CityAQIInfoView(city: $cityData)
    }
}
