//
//  MainViewController.swift
//  UberTaxi
//
//  Created by Ivan Kopiev on 08.08.2021.
//

import UIKit
class MainViewController: UIViewController {
    // MARK: - Properties
    lazy var mainView: MainView = {
        let view = MainView(frame: self.view.frame)
        view.findPanel.delegate = self
        view.delegate = self
        return view
    }()
    
    var firstAdress: String?
    var secondAdress: String?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
        title = "Uber"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Helpers
    
    // MARK: - Selectors
}
// MARK: - SearchAdressDelegate
extension MainViewController: SearchAdressDelegate {
    func wasEnteredFirst(adress: String) {
         print("first adress = \(adress)")
        firstAdress = adress
    }
    
    func wasEnteredSecond(adress: String) {
        print("second adress = \(adress)")
        secondAdress = adress
    }
    
    func didTapButton() {
         print("did tap button")
    }
    
}

extension MainViewController: MainViewDelegate {
    func didTapResetButton() {
        print("Reset Button presed")
        showAlert(with: "Eroror", message: "reset tapped") { _ in
            print("Uraaa")
        }
    }
}

