//
//  ViewController.swift
//  Quizz
//
//  Created by m2sar on 19/10/2020.
//  Copyright © 2020 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonG: UIButton!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var theQ: UILabel!
    @IBOutlet weak var questions: UILabel!
    @IBOutlet weak var theA: UILabel!
    @IBOutlet weak var réponses: UILabel!
    @IBOutlet weak var chiffre: UILabel!
    @IBOutlet weak var CNmode: UISwitch!
    
    private let questionFacile = ["première lettre de l'alphabet?","dernière lettre de l'alphabet?","combien font 1+1 ?"]
    private let reponseFacile = ["a","z","2"]
    
    private let questionCN = ["à quelle heure est le couvre-feu?","combien y-a-t-il d'ordinateur dans la salle SAR?"," "]
    private let reponseCN = ["21h","16","508"]
    
    private var cur = 0
    private var triche = 0
    
    var modeCNisON = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CNmode.isOn = false
    }
    
    @IBAction func buttonG(_ sender: UIButton) {
        cur = (cur+1)%questionCN.count
        if(modeCNisON){
            questions.text = questionCN[cur]
            questions.textColor = UIColor.red
        }else{
            questions.text = questionFacile[cur]
            questions.textColor = UIColor.blue
        }
        
    }
    

    @IBAction func buttonA(_ sender: UIButton) {
        if(modeCNisON){
            réponses.text = reponseCN[cur]
            questions.textColor = UIColor.red
        }else{
            réponses.text = reponseFacile[cur]
            questions.textColor = UIColor.blue
        }
        triche+=1
        chiffre.text = String(triche)
    }
    
    @IBAction func buttonD(_ sender: UIButton) {
        cur = (cur-1)%questionCN.count
        if cur < 0 {
            cur = questionCN.count-1
        }
        
        if(modeCNisON){
            questions.text = questionCN[cur]
            questions.textColor = UIColor.red
        }else{
            questions.text = questionFacile[cur]
            questions.textColor = UIColor.blue
        }
    }
    
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if(!modeCNisON){
            modeCNisON = true
        }else{
            questions.text = questionFacile[cur]
            modeCNisON = false
            questions.textColor = UIColor.blue
        }
    }
    
    
    
}

