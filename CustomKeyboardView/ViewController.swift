//
//  ViewController.swift
//  CustomKeyboardView
//
//  Created by 住田雅隆 on 2022/08/11.
//

import UIKit

class ViewController: UIViewController, CustomKeyboardViewDelegate {
    func customKeyboardView(_ customKeyboardView: CustomKeyboardView, didSelectKey number: String) {
        guard let formulaText = calculationTextField.text else { return }

        switch number {
        case "0"..."9":
            if calculationTextField.text == "0" {
                calculationTextField.text = "\(number)"
            } else {
                calculationTextField.text = formulaText + number
            }
        case "+", "-", "×", "÷":

            calculationTextField.text = formulaText.removingDuplicateSymbols() + number
        case "⌫":
            guard let deleteBackward = calculationTextField.text?.dropLast() else { return }
            if calculationTextField.text?.count == 1 {
                calculationTextField.text = "0"
            } else {
                calculationTextField.text = String(deleteBackward)
            }
        case "=":
            let answer = formattedAnswer(calculationTextField.text ?? "0")
            calculationTextField.text = answer
        default:
            break
        }
    }

    @IBOutlet weak var calculationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        calculationTextField.text = ""
        createKeyboardView()
    }

    func createKeyboardView() {
        let keyboard = CustomKeyboardView(frame: .init(origin: .zero, size: .init(width: 284, height: 284)))
        keyboard.delegate = self
        calculationTextField.inputView = keyboard
        // toolbar
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        toolbar.tintColor = .black
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.doneButton))
        let taxButton = UIBarButtonItem(title: "税込(10%)", style: .done, target: self, action: #selector(self.taxButton))

        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolbar.setItems([doneButton, flexibleItem, taxButton], animated: true)
        calculationTextField.inputAccessoryView = toolbar
        let acButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width / 2 - 40, y: 5, width: 80, height: 35))
        acButton.backgroundColor = .systemGray5
        acButton.layer.cornerRadius = 8
        acButton.layer.shadowOpacity = 0.7
        acButton.layer.shadowRadius = 3
        acButton.layer.shadowColor = UIColor.black.cgColor
        acButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        acButton.setTitle("AC", for: UIControl.State.normal)
        acButton.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        acButton.addTarget(self, action: #selector(tapAcButton), for: UIControl.Event.touchUpInside)
        toolbar.addSubview(acButton)
    }

    @objc func tapAcButton(_ sender: UIButton) {
        calculationTextField.text = "0"
    }
    @objc func taxButton() {
        if calculationTextField.text == "" {
            calculationTextField.text = "0"
        }
        var answer = formattedAnswer(calculationTextField.text ?? "0")
        let taxAnswer = (Double(answer) ?? 0) * 1.1
        answer = String(Int(floor(taxAnswer)))
        calculationTextField.text = answer
    }
    @objc func doneButton() {
        if calculationTextField.text == "" {
            calculationTextField.text = "0"
        }
        let answer = formattedAnswer(calculationTextField.text ?? "0")
        calculationTextField.text = answer
        calculationTextField.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        calculationTextField.endEditing(true)
    }

    func formattedAnswer(_ formula: String) -> String {
        var formattedFormula: String = formula.replacingOccurrences(of:
                                                                        // この文言の意味がよく解っていない
                                                                    "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
                                                                    with: "$1.0",
                                                                    options: NSString.CompareOptions.regularExpression,
                                                                    range: nil
        ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        if formattedFormula.hasSuffix("+") || formattedFormula.hasSuffix("-") || formattedFormula.hasSuffix("*") || formattedFormula.hasSuffix("/") {
            let replaceFormula = String(formattedFormula.dropLast())

            formattedFormula = replaceFormula
        }
        let expression = NSExpression(format: formattedFormula)
        let answer = expression.expressionValue(with: nil, context: nil) as! Double
        // 小数点切り捨て
        let answerString = String(floor(answer))
        if answerString.hasSuffix(".0") {
            return answerString.replacingOccurrences(of: ".0", with: "")
        } else { return answerString }
    }
}

extension String {
    func removingDuplicateSymbols() -> String {
        let duplicateSymbol: CharacterSet = ["+", "-", "×", "÷"]
        return self.trimmingCharacters(in: duplicateSymbol)
    }
}


