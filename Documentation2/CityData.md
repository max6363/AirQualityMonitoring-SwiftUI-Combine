# CityData

A model to show this in List

``` swift
public class CityData: Identifiable 
```

Confirms to `Identifiable` protocol for the SwiftUI List compatibility

## Inheritance

`Identifiable`

## Properties

### `id`

``` swift
public let id: UUID 
```

### `airQuality`

A variable - to get `AirQualityIndexClassification`
based on air quality index value

``` swift
var airQuality: AirQualityIndexClassification 
```

### `aqiColor`

A variable - to get `Color`
based on Air Quality Classification

``` swift
var aqiColor: Color 
```

### `aqiDescriptionText`

A variable - to get air quality classification description text in `String`

``` swift
var aqiDescriptionText: String 
```
