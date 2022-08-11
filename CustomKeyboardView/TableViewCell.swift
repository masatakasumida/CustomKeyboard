//
//  TableViewCell.swift
//  CustomKeyboardView
//
//  Created by 住田雅隆 on 2022/08/11.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var calculatorTextField: UITextField!

    func setup(name: String, calculatorText: String) {
        nameLabel.text = name
        calculatorTextField.text = calculatorText
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
