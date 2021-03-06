//
//  EksplorMapController.swift
//  Papah
//
//  Created by Jehnsen Hirena Kane on 25/07/21.
//

import UIKit
import CoreLocation
import MapKit
import Combine

protocol EksplorMapDelegate: AnyObject {
    func beginRouteTracking()
}

class EksplorMapController: MVVMViewController<EksplorMapViewModel>, UIGestureRecognizerDelegate {
    
    private var trashBag = Set<AnyCancellable>()
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - initializers
    weak var delegate: EksplorMapBottomSheetDelegate?
    
    // MARK: - Bottom sheet initializers
    var bottomSheetViewController: EksplorMapBottomSheet = EksplorMapBottomSheet(nibName: EksplorMapBottomSheet.id, bundle: nil)
    var configuration: BottomSheetConfiguration!
    var state: BottomSheetState = .initial
    var topConstraint = NSLayoutConstraint()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomSheet()
        attemptLocationAccess()
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel?.onAddressString.sink { address in
            print("CURRENT ADD \(address)")
            self.delegate?.updateAddress(address: address)
        }.store(in: &trashBag)
    }
    
}

extension EksplorMapController: EksplorMapDelegate {
    
    func beginRouteTracking() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        if let wbklData = self.viewModel?.wbklData {
            let destinationLocation = CLLocationCoordinate2D(latitude: Double(wbklData.latitude), longitude: Double(wbklData.longitude))
            createPath(sourceLocation: coordinate, destinationLocation: destinationLocation)
        }
    }
    
}
