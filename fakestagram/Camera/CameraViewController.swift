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
    let pickerController = UIImagePickerController()
    
    @IBOutlet weak var postView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionPostTextView: UITextView!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    var post: Post? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocation()
        setUpPickerController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpViewPost()
    }
    
    func setUpViewPost() {
        if (imageView.image != nil) {
            postView.isHidden = false
        } else {
            postView.isHidden = true
            presentAlertOption()
        }
    }
    
    func presentAlertOption() {
        let alertMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertMenu.addAction(UIAlertAction(title: "Library", style: .default, handler: { (UIAlertAction) in
            self.pickerController.sourceType = .photoLibrary
            self.present(self.pickerController, animated: true, completion: nil)
        }))
        
        alertMenu.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            self.pickerController.sourceType = .camera
            self.present(self.pickerController, animated: true, completion: nil)
        }))
        
        alertMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            self.tabBarController?.selectedIndex = 0
        }))
        
        self.present(alertMenu, animated: true, completion: nil)
    }
    
    func successPost() {
        let alertMenu = UIAlertController(title: nil, message: "Post published!", preferredStyle: .alert)
        alertMenu.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
            self.tabBarController?.selectedIndex = 0
        }))
        self.present(alertMenu, animated: true, completion: nil)
    }
    
    func setUpLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
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

    @IBAction func addPost(_ sender: UIButton) {
    
        guard let image = imageView?.image else {return}
        
        let payload = CreatePostBase64(title: descriptionPostTextView.text, imageData: image.toBase64()!, latitude: location?.latitude, longitude: location?.longitude)

            client.create(payload: payload) { (resp) in
                print(resp)
                self.imageView.image = nil
                self.successPost()
            }

    }
    
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setUpPickerController() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    // Photo selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let imageGallery = info[.editedImage] as? UIImage
            else { return }
        
        imageView.image = imageGallery
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    // Cancel photo
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}



