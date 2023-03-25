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
        
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
        
        setupColorView()
    }
    
    override func viewWillLayoutSubviews() {
        colorView.layer.cornerRadius = colorView.frame.height / 10
    }

    // MARK: - Actions
    @IBAction func colorChangeDrag(_ sender: UISlider) {
        let valueWithTwoSigns = String(format: "%.2f", sender.value)
        
        switch sender.restorationIdentifier {
        case ColorRGB.red.rawValue:
            redValueLabel.text = valueWithTwoSigns
            redSlider.value = sender.value
        case ColorRGB.green.rawValue:
            greenValueLabel.text = valueWithTwoSigns
            greenSlider.value = sender.value
        default:
            blueValueLabel.text = valueWithTwoSigns
            blueSlider.value = sender.value
        }
        
        setupColorView()
    }
}


