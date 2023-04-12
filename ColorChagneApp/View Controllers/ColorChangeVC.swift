//
//  ColorChangeVC.swift
//  ColorChagneApp
//
//  Created by Khusain on 26.03.2023.
//

import UIKit

final class ColorChangeVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redValueLabel.text = string(redSlider.value)
        greenValueLabel.text = string(greenSlider.value)
        blueValueLabel.text = string(blueSlider.value)
        
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
        dismiss(animated: true)
    }
    
}

// MARK: - Extension View Setup
extension ColorChangeVC {
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

