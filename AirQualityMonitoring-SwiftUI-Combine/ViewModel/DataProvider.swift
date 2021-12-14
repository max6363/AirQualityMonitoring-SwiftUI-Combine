//
//  DataProvider.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Starscream
import Combine

class DataProvider: ObservableObject {
    
    var citySubscription = CurrentValueSubject<[CityDataResponse], Error>([CityDataResponse]())
    
    var isConnected: Bool = false
        
    var socket: WebSocket? = {
        guard let url = URL(string: ServerConnection.url) else {
            print("can not create URL from: \(ServerConnection.url)")
            return nil
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        var socket = WebSocket(request: request)
        return socket
    }()
    
    func subscribe() {
        self.socket?.delegate = self
        self.socket?.connect()
    }
    
    func unsubscribe() {
        self.socket?.disconnect()
    }
    
    deinit {
        self.socket?.disconnect()
        self.socket = nil
    }
}

extension DataProvider: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                handleText(text: string)
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                handleError(error: error)
            }
    }
    
    private func handleText(text: String) {
        let jsonData = Data(text.utf8)
        let decoder = JSONDecoder()
        do {
            let resArray = try decoder.decode([CityDataResponse].self, from: jsonData)

            #if DEBUG
            print("Response [Start]")
            _ = resArray.map { cityRes in
                print("\(cityRes.city) => \(cityRes.aqi)")
            }
            print("Response [End]")
            #endif
            citySubscription.send(resArray)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleError(error: Error?) {
        if let e = error {
            citySubscription.send(completion: .failure(e))
        }
    }
}


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
    override init() {
        super.init()
        self.citySubscription.send(dummyCities)
    }
}
