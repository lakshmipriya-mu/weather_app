//
//  MoreInfoTableViewCell.swift
//  Weather App
//
//  Created by Lakshmi Priya on 6/1/23.
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var windInfoLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var pressureText: UILabel!
    @IBOutlet weak var windText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        pressureText.text = "Pressure Info"
        windText.text = "Wind Info"

    }
    
    func configure(wind: String, pressure: String) {
        windInfoLabel.text = "\(wind) m/hr"
        pressureLabel.text = pressure
    }

}
