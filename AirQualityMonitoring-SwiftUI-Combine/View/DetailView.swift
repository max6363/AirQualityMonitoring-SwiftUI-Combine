//
//  DetailView.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 15/12/21.
//

import SwiftUI
import SwiftUICharts

struct DetailView: View {
    
    @EnvironmentObject var modelData: CitiesListViewModel
    @Binding var city: CityData
    
    let chartStyle = ChartStyle(backgroundColor: .white,
                                accentColor: .blue,
                                secondGradientColor: .blue,
                                textColor: .black,
                                legendTextColor: .blue,
                                dropShadowColor: .black.opacity(0.5))
    
    var body: some View {
        VStack (alignment: .leading) {
            CityAQIInfoView(city: $city)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: -10, trailing: 0))
            
            LineView(data: modelData.cityAQIs,
                     title: nil,
                     legend: "Air Quality Index (in Realtime)",
                     style: chartStyle)                            
        
        }
        .navigationTitle(city.name)        
        .onAppear(perform: {
            modelData.setSelectedCity(city: city)
        })
        .onDisappear(perform: {
            modelData.clearCityAQIs()
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    @State static var dummyCity: CityData = {
        let city = CityData()
        city.name = "Delhi"
        city.aqi = 111.50
        return city
    }()
    
    @State static var dataModel: CitiesListViewModel =  {
        let dModel = CitiesListViewModel(with: DummyDataProvider())
        dModel.setSelectedCity(city: dummyCity)
        
        return dModel
    }()
    
    static var previews: some View {
        DetailView(city: $dummyCity)
            .environmentObject(self.dataModel)
    }
}
