//
//  ServerAPI.swift
//  CarSelect
//
//  Created by Django on 2/8/22.
//

import Moya

/// Server API
public enum ServerAPI {
    /// getWeatherForecast
    /// model: the model used to fire the request
    case getWeatherForecast(_ model: ServerWeatherForcastModelReq)
}

// MARK: - TargetType
extension ServerAPI: TargetType {
    public var headers: [String : String]? {
        return nil
    }

    public var baseURL: URL {
        return "https://api.openweathermap.org".urlValue!
    }

    public var path: String {
        switch self {
        case .getWeatherForecast:
            return "/data/2.5/forecast/daily"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getWeatherForecast:
            return .get
        }
    }

    public var sampleData: Data {
        /// use it for unit test or you can just fire a request instead
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        /// append the appid here, cuz it should be used in every request
        let appID = "648a3aac37935e5b45e09727df728ac2"
        switch self {
        case .getWeatherForecast(let model):
            var param = model.dictValue() ?? [:]
            param["APPID"] = appID
            return .requestParameters(
                parameters: param,
                encoding: URLEncoding.queryString
            )
        }
    }
}
