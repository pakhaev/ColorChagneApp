//
//  MainViewController.swift
//  ColorChagneApp
//
//  Created by Khusain on 12.04.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setBackground(for background: UIColor)
}

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else {return}
        guard let backgroundVC = navigationVC.topViewController as? SettingsViewController else {
            return
            
        }
        backgroundVC.color = view.backgroundColor
        backgroundVC.delegate = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setBackground(for background: UIColor) {
        view.backgroundColor = background
    }
}
