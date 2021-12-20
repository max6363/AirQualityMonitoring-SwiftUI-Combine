# DataProvider

`DataProvider` as an `ObservableObject`

``` swift
public class DataProvider: ObservableObject 
```

Provides facility to subscribe/unsubscribe to Air Quality Index (Raw Values),
parsing them to data model `CityDataResponse`,
and notify to Subscribers

## Inheritance

`ObservableObject`, `WebSocketDelegate`

## Methods

### `didReceive(event:client:)`

A callback from WebSocket

``` swift
public func didReceive(event: WebSocketEvent, client: WebSocket) 
```

#### Parameters

  - event: a `WebSocketEvent` event obejct with specific type. i.e. success, failures, data etc.
  - client: a `WebSocket`client object
