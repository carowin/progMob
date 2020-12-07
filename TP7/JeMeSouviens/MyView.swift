//
//  MyView.swift
//  JeMeSouviens
//
//  Created by Caroline Huynh on 07/12/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import MapKit
import Contacts
import ContactsUI

class MyView : UIView, CLLocationManagerDelegate, MKMapViewDelegate, CNContactPickerDelegate, CNContactViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate {
   /*_____________________ MAP TOP _____________________*/
    let mapType = UISegmentedControl(items:["3D", "Carte", "Satellite", "Hybride"])
    var map = MKMapView()
    var cam : MKMapCamera?

    var lat = 48.846
    var lon = 2.355
    var alt = 50.0
    var ori = 30.0
    
    let locMngr = CLLocationManager()
    var activated = false //true when CLLocationManager is activate

    /*_____________________TOOL BAR BOTTOM_____________________*/
    let contactsC = CNContactPickerViewController()
    let contactsS = CNContactStore()
    var contactVC : CNContactViewController?
    
    let scrollPict = UIScrollView()
    let contactPicture = UIImageView()
    
    let pinLabel = UILabel()
    let locationLabel = UILabel()
    
    let tb = UIToolbar()
    let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
    let contactButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
    let photosButton = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: nil)
    
    var nbPin = 1
    var color = UIColor.orange
    
    
    
    override init(frame : CGRect){
        super.init(frame: frame)

    /*_____________________ MAP TOP _____________________*/
        mapType.selectedSegmentIndex = 1
        mapType.addTarget(self, action: #selector(changeMap), for: .valueChanged)
        map.delegate = self
    /*_____________________LOCATION MANAGER _____________________*/
        
        locMngr.distanceFilter = 1.0
        locMngr.requestWhenInUseAuthorization()
        
    /*_____________________TOOL BAR BOTTOM_____________________*/
        pinLabel.text = "Pins : "+String(nbPin-1)
        pinLabel.font = .systemFont(ofSize: 10)
        locationLabel.text = "Visualisation satellite"
        locationLabel.font = .systemFont(ofSize: 10)
        
        contactsC.delegate = self
        scrollPict.delegate = self
        
        let smallSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        smallSpace.width = 20
        let varSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        tb.items = [plusButton, smallSpace, trashButton, varSpace, refreshButton, smallSpace, contactButton, smallSpace, cameraButton, smallSpace, photosButton]
        
        plusButton.target = self
        plusButton.action = #selector(addPin)
        
        trashButton.target = self
        trashButton.action = #selector(deletePin)
        
        refreshButton.target = self
        refreshButton.action = #selector(getPosition)
        
        contactButton.target = self
        contactButton.action = #selector(search)
        
        cameraButton.target = self
        cameraButton.action = #selector(takePhoto)
        
        photosButton.target = self
        photosButton.action = #selector(displayAlbum)
        
        trashButton.isEnabled = false
        contactButton.isEnabled = false
        cameraButton.isEnabled = false
        photosButton.isEnabled = false
        
        self.addSubview(map)
        self.addSubview(mapType)
        
        self.addSubview(tb)
        self.addSubview(locationLabel)
        self.addSubview(pinLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* appelé lorsqu'on appuie sur + */
    @objc func addPin(){
        let a = AnAnnotation(c: map.centerCoordinate, t: String(format:"Contact %d", nbPin), st: "Pas de contact")
        nbPin += 1
        pinLabel.text = "Pins : "+String(nbPin-1)
        map.addAnnotation(a)
    }
    func nextColor(c:UIColor) -> UIColor{
        switch c{
            case.orange : return .red
            case.red : return .blue
            case.blue : return .green
            case.green : return .black
            case.black : return .purple
            case.purple : return .black
        default: return .orange
            
        }
    }
    
    /* supprime le pin selectionné */
    @objc func deletePin(){
        map.removeAnnotation(map.selectedAnnotations[0])
    }
    
    /* appelé lorsqu'on fait un refresh  */
    @objc func getPosition(){
        if activated {
            activated = false
            locMngr.stopUpdatingLocation()
        }else{
            locMngr.delegate = self
            locMngr.distanceFilter = kCLLocationAccuracyBest //greedy in energy !!
            locMngr.startUpdatingLocation()
            activated = true
        }
    }
    
    /* appelé lorsqu'on cherche un contact */
    @objc func search(){
        contactsS.requestAccess(for: .contacts) { (b:Bool, e : Error?) in
            DispatchQueue.main.async {
                let vc = UIApplication.shared.windows[0].rootViewController
                if(!b){
                    let a = UIAlertController(title: "Erreur", message: "Acces aux contacts refusés", preferredStyle: .alert)
                    a.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                    vc?.present(a, animated:true, completion:nil)
                }else{
                    vc?.present(self.contactsC, animated:true, completion:nil)
                }
            }
        }
    }
    /* affiche la map qu'on a selectionné */
    @objc func changeMap(sender: UISegmentedControl){
        if(sender.selectedSegmentIndex == 0){ //3D
            map.mapType = .satelliteFlyover
        }
        if(sender.selectedSegmentIndex == 1){ //Carte
            map.mapType = .standard
        }
        if(sender.selectedSegmentIndex == 2){ //Satellite
            map.mapType = .satellite
        }
        if(sender.selectedSegmentIndex == 3){ //Hybride
            map.mapType = .hybrid
        }
        if(cam != nil){
            map.camera = cam!
        }
    }
    
    @objc func takePhoto(){
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .camera
        let vc = UIApplication.shared.windows[0].rootViewController
        vc?.present(imgPicker, animated:true, completion:nil)
    }
    
    @objc func displayAlbum(){
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        let vc = UIApplication.shared.windows[0].rootViewController
        vc?.present(imgPicker, animated:true, completion:nil)
    }
    
    /* __________ Delegate ContactPickerViewDelegate__________ */
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let currentPin = map.selectedAnnotations[0] as! AnAnnotation
        currentPin.setSubTitle(st: contact.givenName+" "+contact.familyName)
        map.deselectAnnotation(map.selectedAnnotations[0], animated: true)
    }
    
    /* __________ Delegate Image  __________*/
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("selection photo")
        picker.dismiss(animated: true, completion: nil)
         print("1")
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        print("2")
        let imageView: UIImageView = UIImageView(image: img)
        print("3")
        let currentPin = map.selectedAnnotations[0] as! AnAnnotation
        print("4")
        currentPin.setImage(imageview: imageView)
        print("5")
        //scrollPict.addSubview(imageView)
    }
    
    /* __________ Delegate Location Manager __________ */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locMngr.stopUpdatingLocation()
        activated = false
        print(error)
    }
    
    
    //la photo ne s'affiche pas pq?? no sabe trouver facons de deselectionner le pin qd on selectionne photo
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationLabel.text = String(format: "Positionné sur %2.3f, %2.3f", (manager.location?.coordinate.latitude)!, (manager.location?.coordinate.longitude)!)
        lat = (manager.location?.coordinate.latitude)!
        lon = (manager.location?.coordinate.longitude)!
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let viewpoint = CLLocationCoordinate2D(latitude: lat - 0.01, longitude: lon)
        let span = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
        map.setRegion(MKCoordinateRegion(center: location, span: span), animated: true)
        
        map.showsBuildings = true
        cam = MKMapCamera(lookingAtCenter: location, fromEyeCoordinate: viewpoint, eyeAltitude: alt)
        cam?.heading = ori
        map.camera = cam!
    }
 
        /* __________ Delegate MapView __________ */
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "ppm")
        pin.pinTintColor=color
        color = nextColor(c: color)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        trashButton.isEnabled = true
        contactButton.isEnabled = true
        cameraButton.isEnabled = true
        photosButton.isEnabled = true
        let currentPin = map.selectedAnnotations[0] as! AnAnnotation
        if(currentPin.img != nil){
            self.addSubview(scrollPict)
            scrollPict.addSubview(currentPin.img!)
            scrollPict.setNeedsDisplay()
        }
    }
    
    /*erreur nsexception why no sabe*/
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        trashButton.isEnabled = false
        contactButton.isEnabled = false
        cameraButton.isEnabled = false
        photosButton.isEnabled = false
        let currentPin = map.selectedAnnotations[0] as! AnAnnotation
        if(currentPin.img != nil){
            currentPin.img!.removeFromSuperview()
            scrollPict.removeFromSuperview()
        }
    }
    
    /*____________ DRAW VIEW _____________ */
    func drawInFormat(format: CGSize){
        let sizeBar = 70
        let segControl = 200
        mapType.frame = CGRect(x: Int(format.width)/2-100, y: 50, width: segControl, height:30)
        map.frame = CGRect(x:0, y:0, width:Int(format.width), height:Int(format.height)-sizeBar)
        
        scrollPict.frame = CGRect(x:0,y:Int(format.height)/2, width:Int(format.width), height:Int(format.height)/2-sizeBar)
        
        pinLabel.frame = CGRect(x:Int(format.width)-50, y: Int(format.height)-sizeBar, width: 50, height: 20)
        locationLabel.frame = CGRect(x:Int(format.width)/2-75, y: Int(format.height)-sizeBar, width: 150, height: 20)
        tb.frame = CGRect(x:0, y: Int(format.height)-sizeBar, width: Int(format.width), height: sizeBar)
    }
}
