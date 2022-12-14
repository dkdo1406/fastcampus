//
//  ViewController.swift
//  LocationTest
//
//  Created by Hyeongjung on 2022/11/18.
//

import UIKit
import CoreLocation
import SnapKit


class ViewController: UIViewController  {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var administrativeAreaLabel: UILabel!
    @IBOutlet weak var localityLabel: UILabel!
    @IBOutlet weak var subLocalityLabel: UILabel!
    @IBOutlet weak var distanceFromGangnamStationLabel: UILabel!
    @IBOutlet weak var compassLabel: UILabel!
    
    @IBOutlet weak var thoroughfareLabel: UILabel!
    @IBOutlet weak var subThoroughfareLabel: UILabel!
    @IBOutlet weak var subAdministrativeAreaLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    @IBOutlet weak var ISOcountryCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var inlandWaterLabel: UILabel!
    @IBOutlet weak var oceanLabel: UILabel!
    @IBOutlet weak var areasOfInterestLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLHeadingFilterNone
        manager.delegate = self
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.startUpdatingLocation()

        requestGPSPermission()
    }

    func requestGPSPermission(){
        locationManager.requestWhenInUseAuthorization()

        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            guard let coordinate = locationManager.location?.coordinate
            else {return}
            latitudeLabel?.text = "\(coordinate.latitude)"
            longtitudeLabel?.text = "\(coordinate.longitude)"
        case .restricted, .notDetermined:
            DispatchQueue.main.async {
                self.requestGPSPermission()
            }
        case .denied:
            print("GPS: ?????? ??????")
        default:
            print("GPS: Default")
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        self.locationManager.startUpdatingHeading()


        // the most recent location update is at the end of the array.
        let location: CLLocation = locations[locations.count - 1]
        let longtitude: CLLocationDegrees = location.coordinate.longitude
        let latitude:CLLocationDegrees = location.coordinate.latitude

        let geoCoder: CLGeocoder = CLGeocoder()
        let local: Locale = Locale(identifier: "Ko-kr") //korea

        geoCoder.reverseGeocodeLocation(location, preferredLocale: local) {
            (place, error) in
            if let address: [CLPlacemark] = place {
//                self.latitudeLabel?.text = "\(latitude)"
//                self.longtitudeLabel?.text = "\(longtitude)"
                self.administrativeAreaLabel?.text = address.last?.administrativeArea
                self.localityLabel?.text = address.last?.locality
                self.subLocalityLabel?.text = address.last?.subLocality

                self.thoroughfareLabel?.text = address.last?.thoroughfare
                self.subThoroughfareLabel?.text = address.last?.subThoroughfare
                self.subAdministrativeAreaLabel?.text = address.last?.subAdministrativeArea
                self.postalCodeLabel?.text = address.last?.postalCode
                self.ISOcountryCodeLabel?.text = address.last?.isoCountryCode
                self.countryLabel?.text = address.last?.country
                self.inlandWaterLabel?.text = address.last?.inlandWater
                self.oceanLabel?.text = address.last?.ocean
                self.nameLabel?.text = address.last?.name
//                self.areasOfInterestLabel?.text = address.last?.areasOfInterest
                

                // ???????????? ??????(??????)
                guard let heading = self.locationManager.heading?.trueHeading.binade
                else {return}

                if(heading > 23 && heading <= 67) {
                    self.compassLabel?.text = "??????" + "???";
                } else if(heading > 68 && heading <= 112){
                    self.compassLabel?.text = "???" + "???";
                } else if(heading > 113 && heading <= 167){
                    self.compassLabel?.text = "??????" + "???";
                } else if(heading > 168 && heading <= 202){
                    self.compassLabel?.text = "???" + "???";
                } else if(heading > 203 && heading <= 247){
                    self.compassLabel?.text = "??????" + "???";
                } else if(heading > 248 && heading <= 293){
                    self.compassLabel?.text = "???" + "???";
                } else if(heading > 294 && heading <= 337){
                    self.compassLabel?.text = "??????" + "???";
                } else if(heading >= 338 || heading <= 22){
                    self.compassLabel?.text = "???" + "???";
                }

//                print("name:\(address.last?.name)")
//                print("isoCountryCode: \(address.last?.isoCountryCode)")
//                print("country: \(address.last?.country)")
//                print("postalCode: \(address.last?.postalCode)")
//                print("administrativeArea: \(address.last?.administrativeArea)")
//                print("subAdministrativeArea:\(address.last?.subAdministrativeArea)")
//                print("locality: \(address.last?.locality)")
//                print("subLocality: \(address.last?.subLocality)")
//                print("thoroughfare: \(address.last?.thoroughfare)")
//                print("subThoroughfare: \(address.last?.subThoroughfare)")
//                print("region:\(address.last?.region)")
//                print("timeZone: \(address.last?.timeZone)")
//
//
                let locationGangnam = CLLocation(latitude: 37.4968985, longitude: 127.0298547)
                let distanceFromGangnamStation = locationGangnam.distance(from: location)
                self.distanceFromGangnamStationLabel?.text
                      = "\(distanceFromGangnamStation / 1000)"

            }
        }
    }
}
