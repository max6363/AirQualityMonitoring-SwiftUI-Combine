# CitiesListViewModel

`CitiesListViewModel` as an `ObservableObject`

``` swift
public class CitiesListViewModel: ObservableObject 
```

A ViewModel to connect View and Model
Get a list of cities

## Inheritance

`ObservableObject`

## Initializers

### `init(with:)`

`Init` method

``` swift
public init(with dataProvider: DataProvider) 
```

#### Parameters

  - dataProvider: a `DataProvider`

## Properties

### `subscriptions`

A `Set` of subscriptions which are cancellable

``` swift
public var subscriptions 
```

### `provider`

A `DataProvider` is a Data Source

``` swift
public var provider: DataProvider?
```

## Methods

### `setSelectedCity(city:)`

A method to select current city when showing a realtime graph on Detail Page.

``` swift
public func setSelectedCity(city: CityData) 
```

#### Parameters

  - city: A `CityData` object

### `clearCityAQIs()`

A method to clear all data, selectedCity etc.

``` swift
public func clearCityAQIs() 
```
