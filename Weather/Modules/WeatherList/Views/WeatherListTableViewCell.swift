//
//  WeatherListTableViewCell.swift
//  Weather
//
//  Created by Django on 2/8/22.
//

import UIKit

/// tableView cell for weatherlist vc
public final class WeatherListTableViewCell: UITableViewCell {

    @IBOutlet private weak var _dtLabel: UILabel!
    @IBOutlet private weak var _desLabel: UILabel!
    @IBOutlet private weak var _dayLabel: UILabel!
    @IBOutlet private weak var _minLabel: UILabel!
    @IBOutlet private weak var _maxLabel: UILabel!
    @IBOutlet private weak var _backGroundView: UIView!

    /// set the model
    public var model: ServerWeatherForcastModelRes.DetailModel? {
        didSet {
            _dtLabel.text = "dt:" + (model?.dt.stringValue ?? .emptyString)
            _desLabel.text = "des:" + (model?.weather.first?.description ?? .emptyString)
            _dayLabel.text = "day:" + (model?.temp.day.stringValue ?? .emptyString)
            _minLabel.text = "min:" + (model?.temp.min.stringValue ?? .emptyString)
            _maxLabel.text = "max:" + (model?.temp.max.stringValue ?? .emptyString)
        }
    }

    /// change this for a different background color
    public var isEven: Bool = false {
        didSet {
            _backGroundView.backgroundColor = isEven ? .darkGray : .brown
        }
    }
}

// MARK: - life cycle
extension WeatherListTableViewCell {
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

