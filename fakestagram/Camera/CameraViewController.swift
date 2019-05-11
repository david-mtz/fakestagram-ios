//
//  CameraViewController.swift
//  fakestagram
//
//  Created by David Arturo Martinez Guzman D3 on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import CoreLocation

class CameraViewController: UIViewController, CLLocationManagerDelegate {

    let client = CreatePostClient()
    
    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let locationCoor = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.location = locationCoor
    }

    @IBAction func uploadImage(_ sender: UIButton) {
        guard let img = UIImage(named: "squirtle") else { return }
        
        var latitude: Double?
        var longitude: Double?
        
        if let location = self.location {
            latitude = location.latitude
            longitude = location.longitude
        }
        
        let payload = CreatePostBase64(title: "SFdsfdsf", imageData: img.toBase64()!, latitude: latitude, longitude: longitude)


        client.create(payload: payload) { (resp) in
            print(resp)
        }
        
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
