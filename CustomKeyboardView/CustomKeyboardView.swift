//
//  CustomKeyboardView.swift
//  CustomKeyboardView
//
//  Created by 住田雅隆 on 2022/08/11.
//
import UIKit

protocol CustomKeyboardViewDelegate: AnyObject {
    func customKeyboardView(_ customKeyboardView: CustomKeyboardView, didSelectKey key: String)
}

final class CustomKeyboardView: UIView {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var diviteButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    weak var delegate: CustomKeyboardViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    private func loadNib() {
        let view = Bundle.main.loadNibNamed("CustomKeyboardView", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
       
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        button0.buttonSetting(button0)
        button1.buttonSetting(button1)
        button2.buttonSetting(button2)
        button3.buttonSetting(button3)
        button4.buttonSetting(button4)
        button5.buttonSetting(button5)
        button6.buttonSetting(button6)
        button7.buttonSetting(button7)
        button8.buttonSetting(button8)
        button9.buttonSetting(button9)
        plusButton.buttonSetting(plusButton)
        minusButton.buttonSetting(minusButton)
        multiplyButton.buttonSetting(multiplyButton)
        diviteButton.buttonSetting(diviteButton)
        equalButton.buttonSetting(equalButton)
        deleteButton.buttonSetting(deleteButton)
    }

    @IBAction private func selectKey(_ sender: UIButton) {
        delegate?.customKeyboardView(self, didSelectKey: sender.titleLabel!.text!)
    }
}
extension UIButton {
    func buttonSetting(_ button: UIButton) {

        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 6
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 3
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)

    }
}
