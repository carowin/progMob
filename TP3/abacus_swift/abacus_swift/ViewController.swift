//
//  ViewController.swift
//  abacus_swift
//
//  Created by Caroline Huynh and Loise ZHU on 24/10/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var geekSwitch: UISwitch!
    @IBOutlet weak var tensSC: UISegmentedControl!
    @IBOutlet weak var unitsSC: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.stepper.maximumValue = 99
        self.stepper.minimumValue = 0
        self.slider.maximumValue = 99
        self.slider.minimumValue = 0
        self.geekSwitch.setOn(false, animated: false)
    }

    
    func ifSwitchIsOn(result: Int){
        if geekSwitch.isOn{//on passe en hexa
            self.resultLabel.text = String(result, radix:16)
        }else{//on passe en décimal
            self.resultLabel.text = String(result)
        }
    }
    
    func ifValueEqual42(result: Int){
        if result==42{//on doit le mettre en rouge
            self.resultLabel.textColor = UIColor.red
            self.resultLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        }else{
            self.resultLabel.textColor = UIColor.black
            self.resultLabel.font = UIFont.systemFont(ofSize: 16.0)
        }
    }
    
    func methodForSegmentedControl(){
        var stepperValue:Int = Int(self.stepper!.value)
        self.tensSC.selectedSegmentIndex = Int(stepperValue/10)
        self.unitsSC.selectedSegmentIndex = Int(stepperValue%10)
    }
    
    func updateFromSegmentedControl(){
        var resultat:Int = (self.tensSC.selectedSegmentIndex*10)+self.unitsSC.selectedSegmentIndex
        ifSwitchIsOn(result: resultat)
        ifValueEqual42(result: resultat)
        self.slider.value = Float(resultat)
        self.stepper.value = Double(resultat)
    }
    
    @IBAction func actionStepper(_ sender: Any) {
        self.slider.value = Float(self.stepper.value)
        ifSwitchIsOn(result: Int(self.stepper!.value))
        ifValueEqual42(result: Int(self.stepper!.value))
        methodForSegmentedControl()
    }
    
    @IBAction func actionSwitch(_ sender: Any) {
        ifSwitchIsOn(result: Int(self.stepper!.value))
    }
    
    @IBAction func actionTensSC(_ sender: Any) {
        updateFromSegmentedControl()
    }
    
    @IBAction func actionUnitsSC(_ sender: Any) {
        updateFromSegmentedControl()
    }
    
    @IBAction func actionSlider(_ sender: Any) {
        self.stepper.value = Double(self.slider.value)
        ifSwitchIsOn(result: Int(self.slider!.value))
        ifValueEqual42(result: Int(self.slider!.value))
        methodForSegmentedControl()
    }
    
    @IBAction func actionResetButton(_ sender: Any) {
        self.stepper.value = 0
        self.slider.value = 0
        methodForSegmentedControl()
        ifSwitchIsOn(result: Int(self.slider!.value))
    }
    
}

