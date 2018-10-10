//
//  ViewController.swift
//  ConvertIt
//
//  Created by Paige Carey on 10/9/18.
//  Copyright © 2018 Paige Carey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var fromUnitsLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var formulaPicker: UIPickerView!
    @IBOutlet weak var decimalSegment: UISegmentedControl!
    @IBOutlet weak var signSegment: UISegmentedControl!
    
    
    var formulaArray = ["miles to kilometers",
                        "kilometers to miles",
                        "feet to meters",
                        "yards to meters",
                        "meters to feet",
                        "meters to yards",
                        "inches to cm",
                        "cm to inches",
                        "fahrenheit to celcius",
                        "celcius to fahrenheit",
                        "quarts to liters",
                        "liters to quarts"]
    var fromUnits = ""
    var toUnits = ""
    var conversionString = ""
    
    
    //MARK:- Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        formulaPicker.delegate = self
        formulaPicker.dataSource = self
        conversionString = formulaArray[formulaPicker.selectedRow(inComponent: 0)]
        userInput.becomeFirstResponder()
        signSegment.isHidden = true

    }
    
    func calculateConversion() {
       
        
        guard let inputValue = Double(userInput.text!) else {
            if userInput.text != "" {
                 showAlert(title: "Cannot Convert Value", message: "\"\(userInput.text!)\" is not a valid number.")
            }
            return
        }
        var outPutValue = 0.0
        switch conversionString {
        case "miles to kilometers":
            outPutValue = inputValue / 0.62137
        case "kilometers to miles":
            outPutValue = inputValue * 0.62137
        case "feet to meters":
            outPutValue = inputValue / 3.2808
        case "yards to meters":
            outPutValue = inputValue / 1.0936
        case "meters to feet":
            outPutValue = inputValue * 3.2808
        case "meters to yards":
            outPutValue = inputValue * 1.0936
        case "inches to cm":
            outPutValue = inputValue / 0.3937
        case "cm to inches":
            outPutValue = inputValue * 0.3937
        case "fahrenheit to celcius":
            outPutValue = (inputValue - 32) * (5/9)
        case "celcius to fahrenheit":
            outPutValue = (inputValue * (5/9)) + 32
        case "quarts to liters":
            outPutValue = inputValue / 1.05669
        case "liters to quarts":
            outPutValue = inputValue * 1.05669
        default:
            showAlert(title: "Unexpected error", message: "share that \"\(conversionString)\" cannot be identified")
        }
        let formatString = decimalSegment.selectedSegmentIndex < decimalSegment.numberOfSegments-1 ? "%.\(decimalSegment.selectedSegmentIndex+1)f" : "%f"
        let outputString = String(format: formatString, outPutValue)
        resultsLabel.text = "\(inputValue) \(fromUnits) = \(outputString) \(toUnits)"
        
        
       
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK:- IBActions
    @IBAction func userInputChanged(_ sender: UITextField) {
        resultsLabel.text = ""
        if userInput.text?.first == "-" {
            signSegment.selectedSegmentIndex = 1
        } else {
            signSegment.selectedSegmentIndex = 0
        }
    }
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
    calculateConversion()
    }
    
    
    @IBAction func decimalSelected(_ sender: Any) {
        calculateConversion()
    }
    
    @IBAction func signSegmentSelected(_ sender: UISegmentedControl) {
        if signSegment.selectedSegmentIndex == 0 { // +selected remove any -
            userInput.text = userInput.text?.replacingOccurrences(of: "-", with: "")
        } else  {
            userInput.text = "-" + userInput.text!
        }
        if userInput.text !=  "-" {
            calculateConversion()
        }
    }
}
    

//MARK:- PickerView Extension
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return formulaArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return formulaArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        conversionString = formulaArray[row]
        
        
        //will be true regardless of case but if both are the word "celcius"
        if conversionString.lowercased().contains("celcius".lowercased()) {
            signSegment.isHidden = false
        } else {
            signSegment.isHidden = true
            userInput.text = userInput.text?.replacingOccurrences(of: "-", with: "")
            signSegment.selectedSegmentIndex = 0
        }
            
        let unitsArray = formulaArray[row].components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitsLabel.text = fromUnits
        calculateConversion()
    }
    
}


