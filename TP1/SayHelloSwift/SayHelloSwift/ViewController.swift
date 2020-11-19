 //
//  ViewController.swift
//  SayHelloSwift
//
//  Created by m2sar on 07/10/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var l: UILabel!
    @IBOutlet weak var button: UIButton!
    var b = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.l.text = ""
    }

    @IBAction func action(_ sender: UIButton) {
        if(b == 0){
            self.button.setTitle("SayBye", for : .normal)
            self.l.text = "Hello"
            self.b = 1
        }else{
            self.button.setTitle("SayHello", for : .normal)
            self.l.text = "ByeBye"
            self.b = 0
        }
        
    }
    
}

