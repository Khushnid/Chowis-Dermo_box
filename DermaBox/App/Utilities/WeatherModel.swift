//
//  WeatherModel.swift
//  MySkin
//
//  Created by Benedick Icban on 6/10/20.
//  Copyright © 2020 Chowis Co Ltd. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    var main: Temperature?
    var city: String?
    var wind: Wind?
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case city = "name"
        case wind = "wind"
    }
}

struct Wind: Codable {
    var speed: Float
    var deg: Float
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}

struct Temperature: Codable {
    var temp: Float
    var feels_like: Float
    var tempMin: Float
    var tempMax: Float
    var pressure: Float
    var humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct UVModel: Codable {
    var uv: Float?
    
    enum CodingKeys: String, CodingKey {
        case uv = "value"
    }
}


struct OneCallWeatherModel: Codable {
    var current: CurrentModel?
    var daily: [DailyModel]?
    
    enum CodingKeys: String, CodingKey {
        case current = "current"
        case daily = "daily"
    }
}

extension OneCallWeatherModel {
    var diffHumidity: String {
        let returnVal = "(0%→)"
        
        guard let today = current else { return returnVal }
        guard let yesterday = yesterday else { return returnVal }
        
        
        //↓ ↑ →
        let humidDiff = Int(today.humidity - yesterday.humidity)
        switch (humidDiff.signum()) {
            case 1:
                return "(\(abs(humidDiff))%↑)"
            case -1:
                return "(\(abs(humidDiff))%↓)"
            case 0:
                return "(\(abs(humidDiff))%→)"
            default:
                return returnVal
        }
    }
    
    var diffUV: String {
        let returnVal = "(0+)"
        guard let today = current else { return returnVal }
        guard let yesterday = yesterday else { return returnVal }
        let uvDiff = Int(today.uvi - yesterday.uvi)
        switch (uvDiff.signum()) {
            case 1:
                return "(\(abs(uvDiff))+)"
            case -1:
                return "(\(abs(uvDiff))-)"
            case 0:
                return "(\(abs(uvDiff))+)"
            default:
                return returnVal
        }
    }
    
    var today: DailyModel? {
        guard let today = daily?.first(where: { Calendar.current.isDateInToday($0.dateTime) }) else { return nil }
        return today
    }
        
    var yesterday: DailyModel? {
        
        guard let yesterday = daily?.first(where: { Calendar.current.isDateInYesterday($0.dateTime) }) else { return nil }
        return yesterday
    }
}

struct CurrentModel: Codable {
    var uvi: Float
    var humidity: Float
    var temp: Float
    var dt: Double
    
    enum CodingKeys: String, CodingKey {
        case uvi = "uvi"
        case humidity = "humidity"
        case temp = "temp"
        case dt = "dt"
    }
}

struct DailyModel: Codable {
    var dt: Double
    var humidity: Float
    var temp: TemperatureModel?
    var uvi: Float
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case humidity = "humidity"
        case temp = "temp"
        case uvi = "uvi"
    }
}

extension DailyModel {
    var dateTime: Date { return Date(timeIntervalSince1970: dt) }
}

struct TemperatureModel: Codable {
    var tempMin: Float
    var tempMax: Float
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "min"
        case tempMax = "max"
    }
}


//{
// "lat": 33.44,
// "lon": -94.04,
// "timezone": "America/Chicago",
// "timezone_offset": -18000,
// "current": {
//   "dt": 1588935779,
//   "sunrise": 1588936856,
//   "sunset": 1588986260,
//   "temp": 16.75,
//   "feels_like": 16.07,
//   "pressure": 1009,
//   "humidity": 93,
//   "dew_point": 15.61,
//   "uvi": 8.97,
//   "clouds": 90,
//   "visibility": 12874,
//   "wind_speed": 3.6,
//   "wind_deg": 280,
//   "weather": [
//     {
//       "id": 501,
//       "main": "Rain",
//       "description": "moderate rain",
//       "icon": "10n"
//     },
//     {
//       "id": 200,
//       "main": "Thunderstorm",
//       "description": "thunderstorm with light rain",
//       "icon": "11n"
//     }
//   ],
//   "rain": {
//     "1h": 2.79
//   }
// },
//  "minutely": [
//   {
//     "dt": 1588935780,
//     "precipitation": 2.789
//   },
//   ...
// },
// "hourly": [
//     {
//     "dt": 1588935600,
//     "temp": 16.75,
//     "feels_like": 13.93,
//     "pressure": 1009,
//     "humidity": 93,
//     "dew_point": 15.61,
//     "clouds": 90,
//     "wind_speed": 6.66,
//     "wind_deg": 203,
//     "weather": [
//       {
//         "id": 501,
//         "main": "Rain",
//         "description": "moderate rain",
//         "icon": "10n"
//       }
//     ],
//     "rain": {
//       "1h": 2.92
//     }
//   },
//   ...
// }
//   "daily": [
//       {
//     "dt": 1588960800,
//     "sunrise": 1588936856,
//     "sunset": 1588986260,
//     "temp": {
//       "day": 22.49,
//       "min": 10.96,
//       "max": 22.49,
//       "night": 10.96,
//       "eve": 18.45,
//       "morn": 18.14
//     },
//     "feels_like": {
//       "day": 18.72,
//       "night": 6.53,
//       "eve": 16.34,
//       "morn": 16.82
//     },
//     "pressure": 1014,
//     "humidity": 60,
//     "dew_point": 14.35,
//     "wind_speed": 7.36,
//     "wind_deg": 342,
//     "weather": [
//       {
//         "id": 502,
//         "main": "Rain",
//         "description": "heavy intensity rain",
//         "icon": "10d"
//       }
//     ],
//     "clouds": 68,
//     "rain": 15.38,
//     "uvi": 8.97
//   },
//   ...
//   }
