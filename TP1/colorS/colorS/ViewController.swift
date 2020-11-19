//
//  ViewController.swift
//  colorS
//
//  Created by Caroline Huynh on 14/10/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadre: UIView!
    @IBOutlet weak var stepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stepper.maximumValue = 4
    }

    @IBAction func actionStepper(_ sender: Any) {
        if(stepper.value == 0.0){
            cadre.backgroundColor = .yellow
        }
        if(stepper.value == 1.0){
            cadre.backgroundColor = .red
        }
        if(stepper.value == 2.0){
            cadre.backgroundColor = .purple
        }
        if(stepper.value == 3.0){
            cadre.backgroundColor = .lightGray
        }
        if(stepper.value == 4.0){
            cadre.backgroundColor = .blue
        }
    
    }
    
}

