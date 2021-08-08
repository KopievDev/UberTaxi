//
//  SearchAdressView.swift
//  UberTaxi
//
//  Created by Ivan Kopiev on 08.08.2021.
//

import UIKit

protocol SearchAdressDelegate: AnyObject {
    func didTapButton()
    func wasEnteredFirst(adress: String)
    func wasEnteredSecond(adress: String)
}

class SearchAdressView: UIView {
    //MARK: - Properies
    
    weak var delegate: SearchAdressDelegate?
    
    let adressFromWhereTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Откуда?"
        tf.accessibilityIdentifier = "first"
        return tf
    }()
    let adressWhereTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Куда?"
        return tf
    }()
    
    let findButton: UIButton = {
       let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
        but.contentMode = .scaleToFill
        but.imageView?.tintColor = .black
        but.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return but
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
        layer.cornerRadius = 16
        backgroundColor = .white
        addSubview(adressWhereTextField)
        addSubview(adressFromWhereTextField)
        addSubview(findButton)
        adressWhereTextField.delegate = self
        adressFromWhereTextField.delegate = self
        createConstraints()
    }
    
    func createConstraints() {
        NSLayoutConstraint.activate([
            // Ardess from
            adressFromWhereTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            adressFromWhereTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            adressFromWhereTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            adressFromWhereTextField.bottomAnchor.constraint(equalTo: adressWhereTextField.topAnchor, constant: -10),
            
            // Ardess to
            adressWhereTextField.leadingAnchor.constraint(equalTo: adressFromWhereTextField.leadingAnchor),
            adressWhereTextField.trailingAnchor.constraint(equalTo: adressFromWhereTextField.trailingAnchor),
            adressWhereTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            // Button
            
            findButton.topAnchor.constraint(equalTo: topAnchor),
            findButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            findButton.leadingAnchor.constraint(equalTo: adressFromWhereTextField.trailingAnchor),
            findButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            
        ])
    }
    
    // MARK: - Selectors
    
    @objc func didTapButton() {
        delegate?.didTapButton()
        endEditing(true)
    }
}

extension SearchAdressView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let adress = textField.text else {
            return
        }
        if textField.accessibilityIdentifier == "first"{
            delegate?.wasEnteredFirst(adress: adress)
        } else {
            delegate?.wasEnteredSecond(adress: adress)
        }
        
    }
}
