//
//  ColorChangeVC.swift
//  ColorChagneApp
//
//  Created by Khusain on 26.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    // MARK: - Public properties
    var color: UIColor!
    
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Private properties
    private var red: Float { color.getRGBA.red }
    private var green: Float { color.getRGBA.green }
    private var blue: Float { color.getRGBA.blue }
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupLabels()
        setupSliders()
        
        setupColorView()
    }
    
    override func viewWillLayoutSubviews() {
        colorView.layer.cornerRadius = colorView.frame.height / 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - Actions
    @IBAction func colorChangeDrag(_ sender: UISlider) {
        let valueWithTwoSigns = string(sender.value)
        let value = sender.value
        
        switch sender {
        case redSlider:
            redValueLabel.text = valueWithTwoSigns
            redTF.text = valueWithTwoSigns
            redSlider.value = value
        case greenSlider:
            greenValueLabel.text = valueWithTwoSigns
            greenTF.text = valueWithTwoSigns
            greenSlider.value = value
        default:
            blueValueLabel.text = valueWithTwoSigns
            blueTF.text = valueWithTwoSigns
            blueSlider.value = value
        }
        setupColorView()
    }
    
    @IBAction func doneTappedButton() {
        view.endEditing(true)
        delegate.setBackground(for: colorView.backgroundColor!)
        dismiss(animated: true)
    }
}

// MARK: - Setup values
extension SettingsViewController {
    func setupColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func setupTextFields() {
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        redTF.addButtonToKeyboard(selector: #selector(self.redTF.resignFirstResponder))
        greenTF.addButtonToKeyboard(selector: #selector(self.greenTF.resignFirstResponder))
        blueTF.addButtonToKeyboard(selector: #selector(self.blueTF.resignFirstResponder))
        
        redTF.text = string(red)
        greenTF.text = string(green)
        blueTF.text = string(blue)
    }
    
    func setupLabels() {
        redValueLabel.text = string(red)
        greenValueLabel.text = string(green)
        blueValueLabel.text = string(blue)
    }
    
    func setupSliders() {
        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue
    }
    
    func string(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
}

// MARK: - UIColor
extension UIColor {
    var getRGBA: (red: Float, green: Float, blue: Float, alpha: Float) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (Float(red), Float(green), Float(blue), Float(alpha))
    }
}

// MARK: - Add button for keyboard
extension UITextField {
    func addButtonToKeyboard(selector: Selector?) {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let done = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: selector
        )
        
        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
        
        inputAccessoryView = doneToolbar
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else {
            alertOfTextField(
                title: "Некорректная информация",
                message: "Невозможно использовать введенную вами информацию"
            )
            return
        }
        guard let numberValue = Float(newValue) else {
            alertOfTextField(
                title: "Некорректная информация",
                message: "Введите цифры от 0 до 1!",
                textField: textField
            )
            return
        }
        
        if numberValue < 0 || numberValue > 1 {
            alertOfTextField(
                title: "Диапазон чисел",
                message: "Соблюдайте диапазон значений от 0 до 1",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTF:
            redValueLabel.text = newValue
            redSlider.setValue(numberValue, animated: true)
        case greenTF:
            greenValueLabel.text = newValue
            greenSlider.setValue(numberValue, animated: true)
        default:
            blueValueLabel.text = newValue
            blueSlider.setValue(numberValue, animated: true)
        }
        
        setupColorView()
    }
}

// MARK: - Show alert
extension SettingsViewController {
    func alertOfTextField(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let alertOkAction = UIAlertAction(title: "Ok", style: .default) { _ in
            textField?.text = ""
        }
        
        alert.addAction(alertOkAction)
        present(alert, animated: true)
    }
}
