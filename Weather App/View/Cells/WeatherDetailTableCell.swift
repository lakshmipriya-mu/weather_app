//
//  WeatherTableViewCell.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import UIKit

class WeatherDetailTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var temparatureLabel: UILabel!
    @IBOutlet weak var highLowLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroudView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroudView.layer.cornerRadius = 5
        currentWeatherImageView.backgroundColor = .gray
        currentWeatherImageView.layer.cornerRadius = currentWeatherImageView.frame.width/2
    }

    func configure(data: WeatherDetailCellViewModel) {
        titleLabel.text = data.place
        temparatureLabel.text = data.currentTemparature
        feelsLikeLabel.text = data.feelsLikeText
        descriptionLabel.text = data.description
        highLowLabel.text = data.moreInfoLabel
        if let imageUrl = data.imageUrl {
            currentWeatherImageView.load(url: imageUrl)
        }
    }

}
