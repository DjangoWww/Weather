//
//  WeatherListVM.swift
//  Weather
//
//  Created by Django on 2/8/22.
//

import RxSwift
import RxRelay
import RxCocoa
import RxDataSources
import PromiseKit

/// WeatherListVM
public final class WeatherListVM {
    deinit {
        printDebug("WeatherListVM deinit")
    }

    /// the tableView section model for ui layer
    public typealias TableSection = SectionModel<String?, ServerWeatherForcastModelRes.DetailModel>

    /// view state for ui layer
    public enum ViewState {
        case `init`
        case loading
        case success
        case failedWith(error: Error)
    }

    private let _disposeBag = DisposeBag()
    private let _serverProvider = ServerProvider()
    private let _viewStateRelay = BehaviorRelay<ViewState>(value: .`init`)
    private let _tableSectionsRelay = BehaviorRelay<[TableSection]>(value: [])

    /// the view state
    public let viewStateDriver: Driver<ViewState>
    /// the tableView dataSource
    public let tableSectionsDriver: Driver<[TableSection]>

    public init() {
        viewStateDriver = _viewStateRelay.asDriver()
        tableSectionsDriver = _tableSectionsRelay.asDriver()
    }
}

// MARK: - public funcs
extension WeatherListVM {
    /// request the weather list in paris for 16 days
    public func getWeatherList() {
        // the model used for the request
        let modelReq = ServerWeatherForcastModelReq(
            city: "Paris",
            mode: .json,
            units: .metric,
            cnt: 16
        )

        _viewStateRelay.accept(.loading)

        // use promise for the request
        firstly { Guarantee { $0(modelReq) } }
        .then(_getWeatherList)
        .done(_handleSucceed)
        .catch(_handleFailed)
    }
}

// MARK: - private funcs
extension WeatherListVM {
    /// get the result for the model
    /// we can put some data persist logic here and get it from local storage incase needed
    private func _getWeatherList(
        with modelReq: ServerWeatherForcastModelReq
    ) -> Promise<ServerWeatherForcastModelRes> {
        return _serverProvider
            .request(target: .getWeatherForecast(modelReq))
    }

    private func _handleSucceed(
        with res: ServerWeatherForcastModelRes
    ) {
        _viewStateRelay.accept(.success)
        let resItems = res.list
        /// one section
        _tableSectionsRelay.accept([TableSection(model: nil, items: resItems)])
    }

    private func _handleFailed(
        with error: Error
    ) {
        printDebug(error)
        _viewStateRelay.accept(.failedWith(error: error))
    }
}

