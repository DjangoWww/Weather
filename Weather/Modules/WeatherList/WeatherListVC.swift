//
//  WeatherListVC.swift
//  Weather
//
//  Created by Django on 2/8/22.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources
import PromiseKit
import MJRefresh

/// the list vc to show weather
public final class WeatherListVC: UIViewController {
    deinit {
        printDebug("WeatherListVC deinit")
    }

    @IBOutlet private weak var _tableView: UITableView!

    private let _viewModel = WeatherListVM()
    private let _disposeBag = DisposeBag()
}

// MARK: - Life cycle
extension WeatherListVC {
    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "Weather List"
        _setUpSubviews()
        _bindViewModel()

        // start request
        _viewModel.getWeatherList()
    }
}

// MARK: - private funcs
extension WeatherListVC {
    /// setup the subviews
    private func _setUpSubviews() {
        // set tht back button title
        navigationItem.backButtonTitle = "List"
        let nibId = UINib(
            nibName: ._weatherListTableViewCell,
            bundle: Bundle.main
        )

        // register the cell for table view
        _tableView.register(
            nibId,
            forCellReuseIdentifier: ._weatherListTableViewCell
        )

        // tableview pull to refresh
        _tableView.mj_header = MJRefreshNormalHeader(
            refreshingBlock: { [weak self] in self?._viewModel.getWeatherList() }
        )
    }

    /// bind data with ui
    private func _bindViewModel() {
        _viewModel.viewStateDriver
            .drive { [weak self] in self?._handleViewState($0) }
            .disposed(by: _disposeBag)

        /// the dataSouce for tableview
        let dataSource = RxTableViewSectionedReloadDataSource<WeatherListVM.TableSection> { dataS, tableV, indexP, model in
            guard let cell = tableV.dequeueReusableCell(
                withIdentifier: ._weatherListTableViewCell,
                for: indexP
            ) as? WeatherListTableViewCell else {
                let assertMsg = "you should register cell be4 use"
                printDebug(assertMsg, assertMessage: assertMsg)
                return UITableViewCell()
            }
            cell.model = model
            cell.isEven = indexP.row % 2 == 0
            return cell
        }

        _viewModel.tableSectionsDriver
            .drive(_tableView.rx.items(dataSource: dataSource))
            .disposed(by: _disposeBag)

        /// handle tableView select
        _tableView.rx
            .modelSelected(ServerWeatherForcastModelRes.DetailModel.self)
            .asDriver()
            .drive { [weak self] in self?._handleModelSelected(with: $0) }
            .disposed(by: _disposeBag)
    }

    /// handle viewState
    private func _handleViewState(
        _ viewState: WeatherListVM.ViewState
    ) {
        switch viewState {
        case .`init`:
            break
        case .loading:
            _tableView.makeActivity()
        case .success:
            _tableView.hideToast()
            _tableView.mj_header?.endRefreshing()
        case .failedWith(let err):
            _tableView.hideToast()
            _tableView.makeToast(err.errorDescription)
        }
    }

    /// handleModelSelected
    private func _handleModelSelected(
        with detailModel: ServerWeatherForcastModelRes.DetailModel
    ) {
        let detailVc = WeatherDetailVC().then {
            $0.accept(detailModel: detailModel)
        }
        navigationController?.pushViewController(detailVc, animated: true)
    }
}

// MARK: - string extension
extension String {
    fileprivate static let _weatherListTableViewCell = "WeatherListTableViewCell"
}
