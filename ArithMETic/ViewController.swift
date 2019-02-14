//
//  ViewController.swift
//  ArithMETic
//
//  Created by Kolli,Pradeep on 2/13/19.
//  Copyright © 2019 Kolli,Pradeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var EnergyConsumedLBL: UILabel!
    
    @IBOutlet weak var TimeToLoosePoundLBL: UILabel!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var activityTF: UITextField!
    
    
    @IBAction func Calculate(_ sender: Any) {
        if weightTF.text != "" && timeTF.text != ""{
            if let weight = Int(weightTF.text!){
                if let time = Int(timeTF.text!){
//              let activity = Int(activityTF.text!)!
                EnergyConsumedLBL.text! = "\(energyConsumed(during: .Bicycling, weight: weight, time: time)) cal"
                TimeToLoosePoundLBL.text! = "\(timeToLose1Pound(during: .Bicycling, weight: 160)) minutes"
                }
                
            }
            
        }
        else{
//                CODE FOR ERROR MESSAGE IF WEIGHT n Time are  both empty
            let alertController = UIAlertController(title: "", message: "Enter a valid time and weight",
                                                    preferredStyle: .alert)
            // actions, displayed as Buttons in the alert, specify both the title of the button
            // and what to do -- in the handler -- when the button is tapped)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.show(alertController, sender: nil)
        }
    }
    
    @IBAction func Clear(_ sender: Any) {
        weightTF.text! = ""
        timeTF.text! = ""
        activityTF.text! = ""
        EnergyConsumedLBL.text! = "0 cal"
        TimeToLoosePoundLBL.text! = "0 minutes"
    }
    
  
    func calPerMin(during:MET,weight:Int) -> Double{
        return during.rawValue * 3.5 * Double(weight) / 200
    }
    func energyConsumed(during:MET,weight:Int,time:Int) -> Double{
        return calPerMin(during: during, weight: weight) * Double(time)
    }
    func timeToLose1Pound(during:MET,weight:Int) -> Double{
        return 3500 / calPerMin(during: during, weight: weight)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        EnergyConsumedLBL.text! = "0 cal"
        TimeToLoosePoundLBL.text! = "0 minutes"
        // Do any additional setup after loading the view, typically from a nib.
    }


}

enum MET:Double {
    case Bicycling = 8.0
    case JumpingRope = 12.3
    case RunningSlow = 9.8
    case RunningFast = 23.0
//    case Tennis = 8.0
    case Swimming = 5.8
}
