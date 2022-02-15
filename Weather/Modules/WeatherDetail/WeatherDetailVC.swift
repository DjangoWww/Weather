//
//  WeatherDetailVC.swift
//  Weather
//
//  Created by Django on 2/8/22.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

/// the detail vc to show weather
public final class WeatherDetailVC: UIViewController {
    deinit {
        printDebug("WeatherListVC deinit")
    }

    @IBOutlet private weak var _tempStateLabel: UILabel!
    @IBOutlet private weak var _detailTextView: UITextView!

    private let _viewModel = WeatherDetailVM()
    private let _disposeBag = DisposeBag()
}

// MARK: - Life cycle
extension WeatherDetailVC {
    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "Weather Detail"
        _bindViewModel()
    }
}

// MARK: - private funcs
extension WeatherDetailVC {
    /// bind viewModel with ui
    private func _bindViewModel() {
        /// the the tempState whether its hard cold or normal
        _viewModel.tempStateDriver
            .map { "TempState: " + $0.getDisplayName() }
            .drive(_tempStateLabel.rx.text)
            .disposed(by: _disposeBag)

        ///
        _viewModel.detailModelDriver
            .map { $0._getDescription() }
            .drive(_detailTextView.rx.text)
            .disposed(by: _disposeBag)
    }
}

// MARK: - public funcs
extension WeatherDetailVC {
    /// use this func to accept the detailModel
    public func accept(
        detailModel: ServerWeatherForcastModelRes.DetailModel
    ) {
        _viewModel.accept(detailModel: detailModel)
    }
}

// MARK: - DetailModel extension for description
extension ServerWeatherForcastModelRes.DetailModel {
    /// the detail information for the DetailModel
    fileprivate func _getDescription() -> String {
        return "\(self)"
    }
}
