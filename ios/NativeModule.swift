//
//  NativeModule.swift
//  NativeModuleExample
//
//  Created by Hoang Doan on 10/30/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation
import CoreLocation


@objc(NativeModule)
class NativeModule: RCTEventEmitter, CLLocationManagerDelegate {
  
  var locationManager: CLLocationManager!

  
  override init() {
    super.init()
    locationManager = CLLocationManager()
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.requestWhenInUseAuthorization()

    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.allowsBackgroundLocationUpdates = true
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    let numLat = NSNumber(value: (locValue.latitude) as Double)
    let numlong = NSNumber(value: (locValue.longitude) as Double)
    self.sendEvent(event: "GetLocation", data: [numLat, numlong])

  }
  
  @objc(startGetLocation)
  func startGetLocation() {
    if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined, .restricted, .denied:
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

      case .authorizedAlways, .authorizedWhenInUse:
        locationManager.startUpdatingLocation()
      }
    } else {
      print("Location services are not enabled")
    }
  }
  
  @objc(stopGetLocation)
  func stopGetLocation(){
    locationManager.stopUpdatingLocation()
  }
  
  @objc(getString:)
  func getString(data: String) -> Void {
    print(data)
    sendEvent(event: "getData", data: "data " + data )
  };
  
  func sendEvent(event: String, data: Any) {
    let body: [String: Any] = ["name": event, "data": data]
    self.sendEvent(withName: "NativeModule", body: body)
  }
  
  override func supportedEvents() -> [String]! {
    return ["NativeModule"]
  }
  
}
