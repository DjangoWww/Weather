//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Django on 2/8/22.
//

import XCTest
@testable import Weather
import RxSwift
import RxCocoa
import RxRelay
import RxTest
import RxBlocking
import PromiseKit

/// to test the WeatherListVM
public final class WeatherListVMTests: XCTestCase {
    private var _disposeBag: DisposeBag!
    private var _viewModel: WeatherListVM!
    private var _scheduler: ConcurrentDispatchQueueScheduler!
    private var _testScheduler: TestScheduler!

    public override func setUpWithError() throws {
        _disposeBag = DisposeBag()
        _viewModel = WeatherListVM()
        _scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        _testScheduler = TestScheduler(initialClock: 0)
    }

    public override func tearDownWithError() throws {
        _disposeBag = nil
        _viewModel = nil
        _scheduler = nil
        _testScheduler = nil
    }

    /// to test if the InitialState is correct
    func testInitialState() throws {
        let viewStateObs = _testScheduler.createObserver(WeatherListVM.ViewState.self)
        let tableSectionsObs = _testScheduler.createObserver([WeatherListVM.TableSection].self)

        _viewModel.viewStateDriver.drive(viewStateObs).disposed(by: _disposeBag)
        _viewModel.tableSectionsDriver.drive(tableSectionsObs).disposed(by: _disposeBag)

        // the initial state
        XCTAssertRecordedElements(viewStateObs.events, [.`init`])
        XCTAssertRecordedElements(tableSectionsObs.events, [[]])
    }

    /// to test if reqWeatherList gets the correct response
    func testReqWeatherList() throws {
        // create obs and bind viewModel to it
        let viewStateObs = _testScheduler.createObserver(WeatherListVM.ViewState.self)
        let tableSectionsObs = _testScheduler.createObserver([WeatherListVM.TableSection].self)
        _viewModel.viewStateDriver.drive(viewStateObs).disposed(by: _disposeBag)
        _viewModel.tableSectionsDriver.drive(tableSectionsObs).disposed(by: _disposeBag)

        // fire a request
        _viewModel.getWeatherList()

        // blocking it and wait for the newest result
        let tableSectionsRes = try _viewModel.tableSectionsDriver.skip(1).toBlocking().first()

        // see if that's what we expected or not
        XCTAssertRecordedElements(
            viewStateObs.events,
            [.`init`, .loading, .success]
        )
        guard let sectionModel = tableSectionsRes?.first else {
            XCTFail("it's not possible to be here")
            return
        }
        XCTAssert(sectionModel.items.count != .zero)
    }
}

/// to test the WeatherListVM
public final class WeatherDetailVMTests: XCTestCase {
    private var _disposeBag: DisposeBag!
    private var _viewModel: WeatherDetailVM!
    private var _scheduler: ConcurrentDispatchQueueScheduler!
    private var _testScheduler: TestScheduler!
    private var _detailModel: ServerWeatherForcastModelRes.DetailModel!

    public override func setUpWithError() throws {
        let tempModel = ServerWeatherForcastModelRes.DetailModel.TempModel(
            day: 12,
            min: 6,
            max: 12,
            night: 8,
            eve: 7,
            morn: 6
        )
        let feelsModel = ServerWeatherForcastModelRes.DetailModel.FeelsModel(
            day: 13,
            night: 7,
            eve: 5,
            morn: 5
        )
        let weatherModel = ServerWeatherForcastModelRes.DetailModel.WeatherModel(
            id: 123,
            main: "the main",
            description: "the des",
            icon: "the icon"
        )
        _detailModel = ServerWeatherForcastModelRes.DetailModel(
            dt: 123123,
            sunrise: 123123,
            sunset: 123123,
            temp: tempModel,
            feels_like: feelsModel,
            pressure: 123,
            humidity: 123,
            weather: [weatherModel],
            speed: 112.0,
            deg: 111,
            gust: 31231.8,
            clouds: 12,
            pop: 3213.6
        )
        _disposeBag = DisposeBag()
        _viewModel = WeatherDetailVM()
        _scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        _testScheduler = TestScheduler(initialClock: 0)
    }

    public override func tearDownWithError() throws {
        _disposeBag = nil
        _viewModel = nil
        _scheduler = nil
        _testScheduler = nil
        _detailModel = nil
    }

    func testInitialState() throws {
        let tempStateObs = _testScheduler.createObserver(WeatherDetailVM.TempState.self)

        _viewModel.tempStateDriver.drive(tempStateObs).disposed(by: _disposeBag)

        // the initial state should be empty
        XCTAssertRecordedElements(tempStateObs.events, [])
    }

    func testIfTheTempStateIsCorrect() throws {
        /// accept the detailModel which should result in ViewModel.TempState change
        _viewModel.accept(detailModel: _detailModel)

        let tempStateObs = _testScheduler.createObserver(WeatherDetailVM.TempState.self)
        _viewModel.tempStateDriver.drive(tempStateObs).disposed(by: _disposeBag)

        // see if that's what we expected or not
        // it should be .normal(12) since the we use the max temp
        /*
         let tempModel = ServerWeatherForcastModelRes.DetailModel.TempModel(
             day: 12,
             min: 6,
             max: 12,       this one is used to indicate whether it's hot or cold or normal
             night: 8,
             eve: 7,
             morn: 6
         )
         */
        XCTAssertRecordedElements(
            tempStateObs.events,
            [.normal(12)]
        )
    }
}

// MARK: - ServerProviderTests
public final class ServerProviderTests: XCTestCase {
    private var _serverProvider: ServerProvider!
    /// the model we use for request
    private var _modelReq: ServerWeatherForcastModelReq!

    public override func setUpWithError() throws {
        _serverProvider = ServerProvider()
        _modelReq = ServerWeatherForcastModelReq(
            city: "Paris",
            mode: .json,
            units: .metric,
            cnt: 16
        )
    }

    public override func tearDownWithError() throws {
        _serverProvider = nil
        _modelReq = nil
    }

    /// to test if the provider is working correctly and the result from server is valid
    func testReqWeatherForecast() throws {
        let expectation = expectation(description: "expectation for info result")
        var serverWeatherForecastModelRes: ServerWeatherForcastModelRes? = nil
        let promise: Promise<ServerWeatherForcastModelRes> = _serverProvider
            .request(target: .getWeatherForecast(_modelReq))
        promise
            .done { model in
                serverWeatherForecastModelRes = model
                expectation.fulfill()
            }
            .catch { XCTFail($0.errorDescription) }
        let waiter = XCTWaiter()

        // wait for 30 secs
        waiter.wait(for: [expectation], timeout: 30)
        if serverWeatherForecastModelRes == nil {
            XCTFail("should't be here")
        }
    }
}

// MARK: - extension for XCTest
// MARK: ServerWeatherForcastModelRes.DetailModel: Equatable
extension ServerWeatherForcastModelRes.DetailModel: Equatable {
    public static func == (
        lhs: ServerWeatherForcastModelRes.DetailModel,
        rhs: ServerWeatherForcastModelRes.DetailModel
    ) -> Bool {
        return lhs.dt == lhs.dt
        && lhs.sunrise == rhs.sunrise
        && lhs.sunset == rhs.sunset
        && lhs.speed == rhs.speed
    }
}
// MARK: WeatherListVM.ViewState: Equatable
extension WeatherListVM.ViewState: Equatable {
    public static func == (
        lhs: WeatherListVM.ViewState,
        rhs: WeatherListVM.ViewState
    ) -> Bool {
        switch (lhs, rhs) {
        case (.`init`, .`init`):
            return true
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true
        case (.failedWith, .failedWith):
            return true
        default:
            return false
        }
    }
}

// MARK: WeatherDetailVM.TempState: Equatable
extension WeatherDetailVM.TempState: Equatable {
    public static func == (
        lhs: WeatherDetailVM.TempState,
        rhs: WeatherDetailVM.TempState
    ) -> Bool {
        switch (lhs, rhs) {
        case (.hot(let temp1), .hot(let temp2)):
            return temp1 == temp2
        case (.cold(let temp1), .cold(let temp2)):
            return temp1 == temp2
        case (.normal(let temp1), .normal(let temp2)):
            return temp1 == temp2
        default:
            return false
        }
    }
}
