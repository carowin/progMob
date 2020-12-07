//
//  ViewController.swift
//  JeMeSouviens
//
//  Created by Caroline Huynh on 07/12/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let v = MyView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = v
        
        v.drawInFormat(format: UIScreen.main.bounds.size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //si on a pas les droits d'acces
        if !CLLocationManager.locationServicesEnabled(){
        }
        
    }


}

