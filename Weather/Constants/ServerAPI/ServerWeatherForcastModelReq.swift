//
//  ServerWeatherForcastModelReq.swift
//  Weather
//
//  Created by Django on 2/8/22.
//

import Foundation

/// the request model for WeatherForcast request
public struct ServerWeatherForcastModelReq: Codable {
    let city: String
    let mode: ModeType
    let units: UnitsType
    let cnt: Int

    private enum CodingKeys: String, CodingKey {
        case city   = "q"
        case mode
        case units
        case cnt
    }
}

extension ServerWeatherForcastModelReq {
    
    /// the model type, it has two value
    /// json
    /// xml
    public enum ModeType: String, Codable {
        case json
        case xml
    }
    
    /// the units type, it has three value
    /// standard
    /// metric
    /// imperial
    public enum UnitsType: String, Codable {
        case standard
        case metric
        case imperial
    }
}
