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
    
    
    var formulaArray = ["miles to kilometers",
                        "kilometers to miles",
                        "feet to meters",
                        "yards to meters",
                        "meters to feet",
                        "meters to yards"]
    var fromUnits = ""
    var toUnits = ""
    var conversionString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formulaPicker.delegate = self
        formulaPicker.dataSource = self
        conversionString = formulaArray[formulaPicker.selectedRow(inComponent: 0)]

    }
    
    func calculateConversion() {
       
        
        guard let inputValue = Double(userInput.text!) else {
            print("show alert - for some reason we didn't have a conversoin string")
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
        default:
            print("show alert - for some reason we didn't have a conversoin string")
        }
        let formatString = decimalSegment.selectedSegmentIndex < decimalSegment.numberOfSegments-1 ? "%.\(decimalSegment.selectedSegmentIndex+1)f" : "%f"
        let outputString = String(format: formatString, outPutValue)
        resultsLabel.text = "\(inputValue) \(fromUnits) = \(outputString) \(toUnits)"
        
        
       
    }
    

    @IBAction func convertButtonPressed(_ sender: UIButton) {
    calculateConversion()
    }
    
    
    @IBAction func decimalSelected(_ sender: Any) {
        calculateConversion()
    }
}
    


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
        let unitsArray = formulaArray[row].components(separatedBy: " to ")
        fromUnits = unitsArray[0]
        toUnits = unitsArray[1]
        fromUnitsLabel.text = fromUnits
        calculateConversion()
    }
    
}


