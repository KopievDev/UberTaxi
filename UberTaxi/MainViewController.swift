//
//  MainViewController.swift
//  UberTaxi
//
//  Created by Ivan Kopiev on 08.08.2021.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {
    // MARK: - Properties
    lazy var mainView: MainView = {
        let view = MainView(frame: self.view.frame)
        view.findPanel.delegate = self
        view.delegate = self
        view.mapView.delegate = self
        return view
    }()
    var annotationArray = [MKPointAnnotation]()
    var distance = Double()
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
    
    func setupPlacemark(adressPlace: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressPlace) {[weak self] (placemarks,error ) in
            if error != nil {
                self?.showAlert(with: "Ошибка", message: "Адрес не найден", handler: nil)
                return
            }
            guard let placemarks = placemarks else {return}
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = adressPlace
            guard let placemarkLocation = placemark?.location else {return}
            annotation.coordinate = placemarkLocation.coordinate
            self?.annotationArray.append(annotation)
            self?.mainView.mapView.showAnnotations(self!.annotationArray, animated: true)
        }
    }
    
    func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .automobile
        request.requestsAlternateRoutes = false
        
        let diraction = MKDirections(request: request)
        diraction.calculate {[weak self] responce, err in
            if err != nil {
                self?.showAlert(with: "Ошибка", message: "Маршрут недоступен!", handler: nil)
                return
            }
            guard let responce = responce else {
                self?.showAlert(with: "Ошибка", message: "Маршрут недоступен!", handler: nil)
                return
            }
            
            let route = responce.routes[0]
            print("Расстояние \(route.distance)")
            self?.distance = route.distance
            self?.mainView.mapView.addOverlay(route.polyline)
            
        }
        
    }
    
    func resetAnnotation() {
        mainView.mapView.removeOverlays(mainView.mapView.overlays)
        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
        annotationArray = [MKPointAnnotation]()
        mainView.resetView()
    }
    
    // MARK: - Selectors
}
// MARK: - SearchAdressDelegate
extension MainViewController: SearchAdressDelegate {
    func wasEnteredFirst(adress: String) {
        print("first adress = \(adress)")
        setupPlacemark(adressPlace: adress)
    }
    
    func wasEnteredSecond(adress: String) {
        print("second adress = \(adress)")
        setupPlacemark(adressPlace: adress)
    }
    
    func didTapButton() {
        print(annotationArray.count)
        if annotationArray.count == 2 {
            createDirectionRequest(startCoordinate: annotationArray[0].coordinate, destinationCoordinate: annotationArray[1].coordinate)
            mainView.mapView.showAnnotations(annotationArray, animated: true)
            mainView.showOrderButton(with: distance)
        }
    }
}

extension MainViewController: MainViewDelegate {
    func didTapOrderButton() {
        showAlert(with: "Заказ", message: "Такси выехало") { _ in
        }
    }
    
    func didTapResetButton() {
        resetAnnotation()
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .systemPink
        return renderer
        
    }
}
