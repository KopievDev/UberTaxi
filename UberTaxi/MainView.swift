//
//  MainViewController.swift
//  UberTaxi
//
//  Created by Ivan Kopiev on 08.08.2021.
//

import UIKit
import MapKit

protocol MainViewDelegate: AnyObject {
    func didTapResetButton()
    func didTapOrderButton()
}

class MainView: UIView {
    //MARK: - Properies
    let mapView = MKMapView()
    weak var delegate: MainViewDelegate?
    let findPanel: SearchAdressView = {
        let panel = SearchAdressView()
        panel.translatesAutoresizingMaskIntoConstraints = false
        return panel
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сбросить маршрут", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        return button
    }()
    
    private let goButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Заказать такси", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapOrderButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
   private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Расстояние"
        label.isHidden = true
        return label
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
    private func setUp() {
        mapView.frame = frame
        addSubview(mapView)
        addSubview(findPanel)
        addSubview(resetButton)
        addSubview(distanceLabel)
        addSubview(goButton)
        createConstraints()
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            findPanel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            findPanel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            findPanel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            resetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resetButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 60),
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            goButton.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -20),
            goButton.leadingAnchor.constraint(equalTo: resetButton.leadingAnchor),
            goButton.trailingAnchor.constraint(equalTo: resetButton.trailingAnchor),
            goButton.heightAnchor.constraint(equalTo: resetButton.heightAnchor),
            
            distanceLabel.bottomAnchor.constraint(equalTo: goButton.topAnchor, constant: -20),
            distanceLabel.leadingAnchor.constraint(equalTo: resetButton.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: resetButton.trailingAnchor),
            distanceLabel.heightAnchor.constraint(equalTo: resetButton.heightAnchor),
 
        ])
    }
    
    func resetView() {
        findPanel.adressFromWhereTextField.text = ""
        findPanel.adressWhereTextField.text = ""
        goButton.isHidden = true
        distanceLabel.isHidden = true
    }
    
    func showOrderButton(with distance: Double) {
        goButton.isHidden = false
        distanceLabel.isHidden = false
        distanceLabel.text = "Расстояние: \(distance) м"
    }
    
    
    // MARK: - Selectors
    
    @objc func didTapResetButton() {
        delegate?.didTapResetButton()
    }
    
    @objc func didTapOrderButton() {
        delegate?.didTapOrderButton()
    }

}

