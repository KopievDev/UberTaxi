//
//  Alert.swift
//  UberTaxi
//
//  Created by Ivan Kopiev on 08.08.2021.
//

import UIKit

extension MainViewController {
    func showAlert(with title: String, message: String, handler:  ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(alertOk)
        
        present(alert, animated: true)
    }
}
