//
//  Extensions + ColorChangeVC.swift
//  ColorChagneApp
//
//  Created by Khusain on 26.03.2023.
//

import UIKit

extension ColorChangeVC {
    func setupColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

extension ColorChangeVC {
    enum ColorRGB: String {
        case red
        case green
        case blue
    }
}
