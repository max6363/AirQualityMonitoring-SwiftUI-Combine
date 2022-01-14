//
//  DataProvider.swift
//  AirQualityMonitoring-SwiftUI-Combine
//
//  Created by Minhaz on 14/12/21.
//

import Foundation
import Starscream
import Combine

/// `DataProvider` as an `ObservableObject`
///
/// Provides facility to subscribe/unsubscribe to Air Quality Index (Raw Values),
/// parsing them to data model `CityDataResponse`,
/// and notify to Subscribers
public class DataProvider: ObservableObject {
    
    var citySubscription = CurrentValueSubject<[CityDataResponse], Error>([CityDataResponse]())
    
    var isConnected: Bool = false
            
    /// A private variable of `WebSocket` to create an instance of WebSocket with given server URL-String
    private var socket: WebSocket? = {
        guard let url = URL(string: ServerConnection.url) else {
            print("can not create URL from: \(ServerConnection.url)")
            return nil
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        
        var socket = WebSocket(request: request)
        return socket
    }()
        
    /// A method to subscribe to the WebSocket
    func subscribe() {
        self.socket?.delegate = self
        self.socket?.connect()
    }
    
    /// A method to unsubscribe from the WebSocket
    func unsubscribe() {
        self.socket?.disconnect()
    }
    
    deinit {
        self.socket?.disconnect()
        self.socket = nil
    }
}

/// `DataProvider` extension
///
/// to implement `WebSocketDelegate` - handle response and errors.
extension DataProvider: WebSocketDelegate {
    
    /// A callback from WebSocket
    /// - Parameters:
    ///   - event: a `WebSocketEvent` event obejct with specific type. i.e. success, failures, data etc.
    ///   - client: a `WebSocket`client object
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
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
        
    /// A method to handle response received from WebSocket.
    /// Parse the response in `CityDataResponse` Array and send to Subscribers.
    ///
    /// - Parameter text: a text recieved from WebSocket in `String`.
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
        
    /// A private method to handle error received from the WebSocket.
    /// Send Error object to Subscribers.
    ///
    /// - Parameter error: An `Error` object
    private func handleError(error: Error?) {
        if let e = error {
            citySubscription.send(completion: .failure(e))
        }
    }
}
