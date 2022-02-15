//
//  WeatherDetailVM.swift
//  Weather
//
//  Created by Django on 2/8/22.
//

import RxSwift
import RxRelay
import RxCocoa

/// WeatherDetailVM
public final class WeatherDetailVM {
    deinit {
        printDebug("WeatherDetailVM deinit")
    }

    public enum TempState {
        case hot(Double)
        case cold(Double)
        case normal(Double)

        /// get the display name
        public func getDisplayName() -> String {
            switch self {
            case .hot(let temp):
                return "Hot (\(temp)℃)"
            case .cold(let temp):
                return "Cold (\(temp)℃)"
            case .normal(let temp):
                return "Normal (\(temp)℃)"
            }
        }
    }

    private let _detailModelRelay = BehaviorRelay<ServerWeatherForcastModelRes.DetailModel?>(value: nil)

    /// the temp state for ui
    public let tempStateDriver: Driver<TempState>
    /// the detailModel
    public let detailModelDriver: Driver<ServerWeatherForcastModelRes.DetailModel>

    public init() {
        tempStateDriver = _detailModelRelay.asDriver()
            .compactMap { $0 }                      // filter nil
            .map { $0.temp.max._getTempState() }    // map to TempState

        // map to driver and filter the nil value
        detailModelDriver = _detailModelRelay.asDriver().compactMap { $0 }
    }
}

// MARK: - public funcs
extension WeatherDetailVM {
    /// request the weather list in paris for 16 days
    public func accept(
        detailModel: ServerWeatherForcastModelRes.DetailModel
    ) {
        _detailModelRelay.accept(detailModel)
    }
}

// MARK: - double extension for temp -> TempState
extension Double {
    fileprivate func _getTempState() -> WeatherDetailVM.TempState {
        if self > 25.0 {
            return .hot(self)
        } else if self < 10 {
            return .cold(self)
        } else {
            return .normal(self)
        }
    }
}
