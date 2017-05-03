//
//  GoogleMapViewController.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import Foundation
import GoogleMaps

protocol GMSMapDelegate: class {
    func didTap() -> Void
}

class GoogleMapViewController: UIViewController, MarkerDelegate {
    
    var map: GMSMapView?
    var markers = [GMSMarker]()
    var overlay = MarkerView.loadFromNib()
    var arrow: UIImageView!
    
    weak var delegate: GMSMapDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrow = UIImageView(frame: CGRect(x: 0, y: 25, width: 15, height: 4))
        arrow.image = UIImage(named: "arrow_marker")
        
        if let APIKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsAPI") as? String {
            
            GMSServices.provideAPIKey(APIKey)
            let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
            map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = map!
            map?.delegate = self
        }
    }
    
    func setDelegate(_ controller: ListTableViewController) {
        controller.delegate = self
    }
    
    func renderMarkers() {

        
        for fueling in fuelingList {
            let position = CLLocationCoordinate2DMake(fueling.lat, fueling.lng)
            let marker = GMSMarker(position: position)
            marker.map = map
            marker.isDraggable = false
            marker.icon = UIImage()
            marker.userData = fueling.id

            markers.append(marker)
            
        }
        
        let position = CLLocationCoordinate2DMake((fuelingList.last?.lat)!, (fuelingList.last?.lng)!)
        let cameraUpdate = GMSCameraUpdate.setTarget(position, zoom: 15.0)
        CATransaction.begin()
        CATransaction.setValue(Int(1.0), forKey: kCATransactionAnimationDuration)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        map!.animate(with: cameraUpdate)
        CATransaction.commit()

    }
    
    func didTap(_ id: Int) {
        
        map?.selectedMarker = markers.filter { $0.userData as! Int == id }.first
        
        let fueling = fuelingList.filter { $0.id == id }.first
        
        let position = CLLocationCoordinate2DMake((fueling?.lat)!, (fueling?.lng)!)
        let cameraUpdate = GMSCameraUpdate.setTarget(position, zoom: 15.0)
        
        overlay.addressLabel.text = fueling?.address
        overlay.costLabel.text = fueling?.cost.appending(" ₽")
        
        CATransaction.begin()
        CATransaction.setValue(Int(1.0), forKey: kCATransactionAnimationDuration)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        map!.animate(with: cameraUpdate)
        CATransaction.commit()
    }
    
}

extension GoogleMapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        delegate?.didTap()
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        
        overlay.removeFromSuperview()
        arrow.removeFromSuperview()
        let anchor = mapView.selectedMarker?.position
        let point = mapView.projection.point(for: anchor!)
        
        arrow.center = CGPoint(x: point.x, y: point.y - 5)
        mapView.addSubview(arrow)
        
        overlay.center = CGPoint(x: point.x + 55, y: point.y - 20)
        mapView.addSubview(overlay)
        
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        if mapView.selectedMarker != nil && (self.overlay.superview != nil) {
            let anchor = mapView.selectedMarker?.position
            let point = mapView.projection.point(for: anchor!)
            overlay.center = CGPoint(x: point.x + 55, y: point.y - 20)

            arrow.center = CGPoint(x: point.x, y: point.y - 5)
            mapView.addSubview(arrow)
        }
        

        
    }
    
}
