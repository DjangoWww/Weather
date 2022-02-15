//
//  ServerWeatherForcastModelRes.swift
//  Weather
//
//  Created by Django on 2/8/22.
//

import Foundation

/// the result for WeatherForcast request
public struct ServerWeatherForcastModelRes: ServerModelTypeRes {
    let city: CityModel
    let cod: String
    let message: Double
    let cnt: Int
    let list: [DetailModel]

    private enum CodingKeys: String, CodingKey {
        case city
        case cod
        case message
        case cnt
        case list
    }
}

extension ServerWeatherForcastModelRes {
    public struct CityModel: Codable {
        let id: Int
        let name: String
        let coord: CoordModel
        let country: String
        let population: Int
        let timezone: Int
    }

    public struct DetailModel: Codable {
        let dt: Int64
        let sunrise: Int64
        let sunset: Int64
        let temp: TempModel
        let feels_like: FeelsModel
        let pressure: Int
        let humidity: Int
        let weather: [WeatherModel]
        let speed: Double
        let deg: Int
        let gust: Double
        let clouds: Int
        let pop: Double
    }
}

extension ServerWeatherForcastModelRes.CityModel {
    public struct CoordModel: Codable {
        let lon: Double
        let lat: Double
    }
}

extension ServerWeatherForcastModelRes.DetailModel {
    public struct TempModel: Codable {
        let day: Double
        let min: Double
        let max: Double
        let night: Double
        let eve: Double
        let morn: Double
    }

    public struct FeelsModel: Codable {
        let day: Double
        let night: Double
        let eve: Double
        let morn: Double
    }

    public struct WeatherModel: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
}

/*
 {
     "city":{
         "id":2988507,
         "name":"Paris",
         "coord":{
             "lon":2.3488,
             "lat":48.8534
         },
         "country":"FR",
         "population":2138551,
         "timezone":3600
     },
     "cod":"200",
     "message":0.0849674,
     "cnt":16,
     "list":[
         {
             "dt":1644062400,
             "sunrise":1644045322,
             "sunset":1644080030,
             "temp":{
                 "day":6.29,
                 "min":3.04,
                 "max":9.92,
                 "night":7.19,
                 "eve":8.28,
                 "morn":3.54
             },
             "feels_like":{
                 "day":3.71,
                 "night":3.88,
                 "eve":5.73,
                 "morn":1.33
             },
             "pressure":1026,
             "humidity":74,
             "weather":[
                 {
                     "id":801,
                     "main":"Clouds",
                     "description":"few clouds",
                     "icon":"02d"
                 }
             ],
             "speed":5.47,
             "deg":228,
             "gust":12.99,
             "clouds":14,
             "pop":0
         },
         {
             "dt":1644148800,
             "sunrise":1644131633,
             "sunset":1644166529,
             "temp":{
                 "day":9.77,
                 "min":6.92,
                 "max":11.05,
                 "night":8.16,
                 "eve":10.25,
                 "morn":7.26
             },
             "feels_like":{
                 "day":6.02,
                 "night":4.48,
                 "eve":9.21,
                 "morn":3.44
             },
             "pressure":1014,
             "humidity":78,
             "weather":[
                 {
                     "id":500,
                     "main":"Rain",
                     "description":"light rain",
                     "icon":"10d"
                 }
             ],
             "speed":9.72,
             "deg":283,
             "gust":22.43,
             "clouds":100,
             "pop":1,
             "rain":2.3
         },
         {
             "dt":1644235200,
             "sunrise":1644217942,
             "sunset":1644253029,
             "temp":{
                 "day":7.65,
                 "min":4.17,
                 "max":8.95,
                 "night":5.94,
                 "eve":7.01,
                 "morn":4.17
             },
             "feels_like":{
                 "day":5.86,
                 "night":4.56,
                 "eve":6.23,
                 "morn":1.7
             },
             "pressure":1032,
             "humidity":51,
             "weather":[
                 {
                     "id":800,
                     "main":"Clear",
                     "description":"sky is clear",
                     "icon":"01d"
                 }
             ],
             "speed":6.52,
             "deg":304,
             "gust":15.81,
             "clouds":6,
             "pop":0.62
         },
         {
             "dt":1644321600,
             "sunrise":1644304249,
             "sunset":1644339529,
             "temp":{
                 "day":8.49,
                 "min":4.31,
                 "max":10.85,
                 "night":7.7,
                 "eve":8.97,
                 "morn":4.31
             },
             "feels_like":{
                 "day":7.32,
                 "night":6.62,
                 "eve":8.21,
                 "morn":2.44
             },
             "pressure":1034,
             "humidity":74,
             "weather":[
                 {
                     "id":804,
                     "main":"Clouds",
                     "description":"overcast clouds",
                     "icon":"04d"
                 }
             ],
             "speed":2.17,
             "deg":203,
             "gust":5.58,
             "clouds":91,
             "pop":0
         },
         {
             "dt":1644408000,
             "sunrise":1644390555,
             "sunset":1644426029,
             "temp":{
                 "day":10.15,
                 "min":4.9,
                 "max":11.64,
                 "night":7.69,
                 "eve":9.07,
                 "morn":4.9
             },
             "feels_like":{
                 "day":8.58,
                 "night":7.69,
                 "eve":9.07,
                 "morn":3.66
             },
             "pressure":1030,
             "humidity":52,
             "weather":[
                 {
                     "id":800,
                     "main":"Clear",
                     "description":"sky is clear",
                     "icon":"01d"
                 }
             ],
             "speed":1.81,
             "deg":187,
             "gust":2.28,
             "clouds":4,
             "pop":0
         },
         {
             "dt":1644494400,
             "sunrise":1644476859,
             "sunset":1644512529,
             "temp":{
                 "day":8,
                 "min":3.73,
                 "max":8,
                 "night":4.26,
                 "eve":3.73,
                 "morn":6.34
             },
             "feels_like":{
                 "day":6.56,
                 "night":2.2,
                 "eve":0.13,
                 "morn":6.34
             },
             "pressure":1027,
             "humidity":77,
             "weather":[
                 {
                     "id":500,
                     "main":"Rain",
                     "description":"light rain",
                     "icon":"10d"
                 }
             ],
             "speed":4.58,
             "deg":7,
             "gust":8.42,
             "clouds":100,
             "pop":0.99,
             "rain":3.16
         },
         {
             "dt":1644580800,
             "sunrise":1644563162,
             "sunset":1644599029,
             "temp":{
                 "day":6.56,
                 "min":2.21,
                 "max":7.66,
                 "night":4.34,
                 "eve":5.67,
                 "morn":2.21
             },
             "feels_like":{
                 "day":4.96,
                 "night":4.34,
                 "eve":5.67,
                 "morn":0.22
             },
             "pressure":1038,
             "humidity":58,
             "weather":[
                 {
                     "id":800,
                     "main":"Clear",
                     "description":"sky is clear",
                     "icon":"01d"
                 }
             ],
             "speed":2.49,
             "deg":335,
             "gust":7.7,
             "clouds":5,
             "pop":0.29
         },
         {
             "dt":1644667200,
             "sunrise":1644649463,
             "sunset":1644685529,
             "temp":{
                 "day":6.28,
                 "min":2.24,
                 "max":8.02,
                 "night":5.52,
                 "eve":6.59,
                 "morn":2.24
             },
             "feels_like":{
                 "day":2.65,
                 "night":1.17,
                 "eve":2.82,
                 "morn":-1.08
             },
             "pressure":1026,
             "humidity":53,
             "weather":[
                 {
                     "id":804,
                     "main":"Clouds",
                     "description":"overcast clouds",
                     "icon":"04d"
                 }
             ],
             "speed":7.04,
             "deg":218,
             "gust":16.52,
             "clouds":100,
             "pop":0.19
         },
         {
             "dt":1644753600,
             "sunrise":1644735762,
             "sunset":1644772028,
             "temp":{
                 "day":8.79,
                 "min":5.13,
                 "max":8.79,
                 "night":7.07,
                 "eve":7.61,
                 "morn":5.94
             },
             "feels_like":{
                 "day":5.66,
                 "night":4.12,
                 "eve":4.88,
                 "morn":2.1
             },
             "pressure":1012,
             "humidity":67,
             "weather":[
                 {
                     "id":500,
                     "main":"Rain",
                     "description":"light rain",
                     "icon":"10d"
                 }
             ],
             "speed":7.12,
             "deg":220,
             "gust":16.25,
             "clouds":76,
             "pop":0.96,
             "rain":5.15
         },
         {
             "dt":1644840000,
             "sunrise":1644822061,
             "sunset":1644858528,
             "temp":{
                 "day":8.63,
                 "min":4.58,
                 "max":10.42,
                 "night":6.67,
                 "eve":8.07,
                 "morn":4.85
             },
             "feels_like":{
                 "day":7.83,
                 "night":4.37,
                 "eve":7.03,
                 "morn":3.74
             },
             "pressure":1023,
             "humidity":69,
             "weather":[
                 {
                     "id":804,
                     "main":"Clouds",
                     "description":"overcast clouds",
                     "icon":"04d"
                 }
             ],
             "speed":3.47,
             "deg":278,
             "gust":9.12,
             "clouds":97,
             "pop":0.38
         },
         {
             "dt":1644926400,
             "sunrise":1644908357,
             "sunset":1644945027,
             "temp":{
                 "day":9.2,
                 "min":5.82,
                 "max":9.2,
                 "night":6.65,
                 "eve":7.1,
                 "morn":6.67
             },
             "feels_like":{
                 "day":6.64,
                 "night":3.26,
                 "eve":4.68,
                 "morn":2.93
             },
             "pressure":1024,
             "humidity":56,
             "weather":[
                 {
                     "id":500,
                     "main":"Rain",
                     "description":"light rain",
                     "icon":"10d"
                 }
             ],
             "speed":6.23,
             "deg":204,
             "gust":15.47,
             "clouds":95,
             "pop":0.7,
             "rain":1.34
         },
         {
             "dt":1645012800,
             "sunrise":1644994653,
             "sunset":1645031526,
             "temp":{
                 "day":8.96,
                 "min":5.92,
                 "max":9.21,
                 "night":5.92,
                 "eve":7.08,
                 "morn":6.2
             },
             "feels_like":{
                 "day":5.7,
                 "night":3.98,
                 "eve":4.19,
                 "morn":2.53
             },
             "pressure":1026,
             "humidity":53,
             "weather":[
                 {
                     "id":500,
                     "main":"Rain",
                     "description":"light rain",
                     "icon":"10d"
                 }
             ],
             "speed":7.03,
             "deg":248,
             "gust":14.8,
             "clouds":52,
             "pop":1,
             "rain":1.61
         },
         {
             "dt":1645099200,
             "sunrise":1645080947,
             "sunset":1645118025,
             "temp":{
                 "day":8.03,
                 "min":3.88,
                 "max":10.65,
                 "night":8.36,
                 "eve":8.77,
                 "morn":3.88
             },
             "feels_like":{
                 "day":7.25,
                 "night":8.36,
                 "eve":8.77,
                 "morn":2.54
             },
             "pressure":1039,
             "humidity":76,
             "weather":[
                 {
                     "id":803,
                     "main":"Clouds",
                     "description":"broken clouds",
                     "icon":"04d"
                 }
             ],
             "speed":1.9,
             "deg":284,
             "gust":4.37,
             "clouds":63,
             "pop":0
         },
         {
             "dt":1645185600,
             "sunrise":1645167240,
             "sunset":1645204523,
             "temp":{
                 "day":10.46,
                 "min":5.39,
                 "max":11.65,
                 "night":7.42,
                 "eve":9.32,
                 "morn":5.39
             },
             "feels_like":{
                 "day":9.05,
                 "night":5.95,
                 "eve":8.38,
                 "morn":5.39
             },
             "pressure":1035,
             "humidity":57,
             "weather":[
                 {
                     "id":802,
                     "main":"Clouds",
                     "description":"scattered clouds",
                     "icon":"03d"
                 }
             ],
             "speed":2.27,
             "deg":134,
             "gust":6.19,
             "clouds":34,
             "pop":0
         },
         {
             "dt":1645272000,
             "sunrise":1645253532,
             "sunset":1645291022,
             "temp":{
                 "day":9.14,
                 "min":4.52,
                 "max":10.44,
                 "night":9.18,
                 "eve":9.8,
                 "morn":4.52
             },
             "feels_like":{
                 "day":6.66,
                 "night":6.92,
                 "eve":7.77,
                 "morn":2.25
             },
             "pressure":1022,
             "humidity":50,
             "weather":[
                 {
                     "id":804,
                     "main":"Clouds",
                     "description":"overcast clouds",
                     "icon":"04d"
                 }
             ],
             "speed":4.64,
             "deg":200,
             "gust":10.33,
             "clouds":100,
             "pop":0.01
         },
         {
             "dt":1645358400,
             "sunrise":1645339822,
             "sunset":1645377520,
             "temp":{
                 "day":10.42,
                 "min":6.8,
                 "max":12.1,
                 "night":9.49,
                 "eve":11.01,
                 "morn":7.44
             },
             "feels_like":{
                 "day":8.9,
                 "night":6.89,
                 "eve":9.71,
                 "morn":4.71
             },
             "pressure":1030,
             "humidity":53,
             "weather":[
                 {
                     "id":804,
                     "main":"Clouds",
                     "description":"overcast clouds",
                     "icon":"04d"
                 }
             ],
             "speed":5.17,
             "deg":239,
             "gust":13.31,
             "clouds":94,
             "pop":0
         }
     ]
 }
 */
