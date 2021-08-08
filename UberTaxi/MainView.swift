//
//  MainViewController.swift
//  UberTaxi
//
//  Created by Ivan Kopiev on 08.08.2021.
//

import UIKit
import MapKit
import CoreLocation

class MainView: UIView {
    //MARK: - Properies
    let mapView = MKMapView()
    
    let findPanel: SearchAdressView = {
        let panel = SearchAdressView()
        panel.translatesAutoresizingMaskIntoConstraints = false
        return panel
    }()
    
    let resetButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сбросить маршрут", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func setUp() {
        mapView.frame = frame
        addSubview(mapView)
        addSubview(findPanel)
        addSubview(resetButton)
        createConstraints()
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            findPanel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            findPanel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            findPanel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            resetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resetButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 60),
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        ])
    }
}

