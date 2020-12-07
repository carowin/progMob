//
//  AnAnnotion.swift
//  JeMeSouviens
//
//  Created by Caroline Huynh on 07/12/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AnAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var img : UIImageView? = nil
    
    init(c: CLLocationCoordinate2D) {
        coordinate = c
        super.init()
    }
    
    convenience init(c: CLLocationCoordinate2D, t: String) {
        self.init(c: c)
        title = t
    }
    
    convenience init(c: CLLocationCoordinate2D, t: String, st: String) {
        self.init(c: c)
        title = t
        subtitle = st
    }
    
    func setSubTitle(st: String) {
        subtitle = st
    }
    
    func setImage(imageview: UIImageView) {
        img = imageview
    }
}
