//
//  ViewController.swift
//  ArithMETic
//
//  Created by Kolli,Pradeep on 2/13/19.
//  Copyright © 2019 Kolli,Pradeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var EnergyConsumedLBL: UILabel!
    
    @IBOutlet weak var TimeToLoosePoundLBL: UILabel!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
//    @IBOutlet weak var activityTF: UITextField!
    
    @IBOutlet weak var CalcBTN: UIButton!
    @IBOutlet weak var clearBTN: UIButton!
    
    @IBOutlet weak var uiPickerView: UIPickerView!
    
    @IBAction func Calculate(_ sender: Any) {
        if weightTF.text != "" && timeTF.text != ""{
            if let weight = Int(weightTF.text!){
                if let time = Int(timeTF.text!){
                let energyConsumedValue = energyConsumed(during: selectedAct!, weight: weight, time: time)
                let timeeToLoosePoundValue = timeToLose1Pound(during: selectedAct!, weight: weight)
                    
                EnergyConsumedLBL.text! = String(format:"%.2f",energyConsumedValue)+" cals"
                TimeToLoosePoundLBL.text! = String(format:"%.2f",timeeToLoosePoundValue)+" minutes"
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
//        activityTF.text! = ""
        EnergyConsumedLBL.text! = "0 cal"
        TimeToLoosePoundLBL.text! = "0 minutes"
    }
    
  
    func calPerMin(during:String,weight:Int) -> Double{
        if let met = metDict[during]{
            return met * 3.5 * Double(weight) / 200
        }
        return 0.0
    }
    func energyConsumed(during:String,weight:Int,time:Int) -> Double{
        return calPerMin(during: selectedAct!, weight: weight) * Double(time)
    }
    func timeToLose1Pound(during:String,weight:Int) -> Double{
        return 3500 / calPerMin(during: selectedAct!, weight: weight)
    }
    var selectedAct:String?
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAct = metDict.keys.sorted()[row]
    }
    var metDict:[String:Double] = [String:Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EnergyConsumedLBL.text! = "0 cal"
        TimeToLoosePoundLBL.text! = "0 minutes"
//        selectedAct = metDict.keys.sorted()[1]
        clearBTN.layer.cornerRadius = 5
        CalcBTN.layer.cornerRadius = 5
        metDict = [
            "Bicycling":8.0,
            "Tennis":8.0,
            "JumpingRope":12.3,
            "RunningSlow": 9.8,
            "RunningFast": 23.0,
            "Swimming": 5.8
        ]
        // Do any additional setup after loading the view, typically from a nib.
    }
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)-> Int {
    return metDict.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String {
    return metDict.keys.sorted()[row]
    }

    
}
//var metDict:[String:Double] = [
//    "Bicycling":8.0,
//    "Tennis":8.0,
//    "JumpingRope":12.3,
//    "RunningSlow": 9.8,
//    "RunningFast": 23.0,
//    "Swimming": 5.8
//]
enum MET:Double {
    case Bicycling,Tennis = 8.0
    case JumpingRope = 12.3
    case RunningSlow = 9.8
    case RunningFast = 23.0
    case Swimming = 5.8
}
