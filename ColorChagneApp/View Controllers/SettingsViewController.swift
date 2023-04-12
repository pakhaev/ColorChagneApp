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
    
    var color: UIColor!
    
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueLabel.text = string(Float(color.getRGBA.red))
        greenValueLabel.text = string(Float(color.getRGBA.green))
        blueValueLabel.text = string(Float(color.getRGBA.blue))
        
        redSlider.value = color.getRGBA.red
        greenSlider.value = color.getRGBA.green
        blueSlider.value = color.getRGBA.blue
        
        setupColorView()
        
    }
    
    override func viewWillLayoutSubviews() {
        colorView.layer.cornerRadius = colorView.frame.height / 10
    }

    // MARK: - Actions
    @IBAction func colorChangeDrag(_ sender: UISlider) {
        let valueWithTwoSigns = string(sender.value)
        
        switch sender {
        case redSlider:
            redValueLabel.text = valueWithTwoSigns
            redSlider.value = sender.value
        case greenSlider:
            greenValueLabel.text = valueWithTwoSigns
            greenSlider.value = sender.value
        default:
            blueValueLabel.text = valueWithTwoSigns
            blueSlider.value = sender.value
        }
        setupColorView()
    }
    
    
    @IBAction func doneTappedButton() {
        delegate.setBackground(for: colorView.backgroundColor!)
        dismiss(animated: true)
    }
    
}

// MARK: - Extension View Setup
extension SettingsViewController {
    func setupColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func string(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
}

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
