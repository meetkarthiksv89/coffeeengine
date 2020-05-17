//
//  ViewController.swift
//  Coffee Recommendation Engine
//
//  Created by Karthik Venkatesh on 5/15/20.
//  Copyright © 2020 Karthik Venkatesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var result: UILabel!
    
    let coffeeModel = CoffeeClassifier()
    override func viewDidLoad() {
        super.viewDidLoad()
        result.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func classifyTapped(_ sender: Any) {
        result.isHidden = false
        do {
            let prediction = try coffeeModel.prediction(text: textField.text ?? "")
            
            // the property names are dependent up on the structure of the model
            result.text = prediction.label
          
        } catch {
            print("Error on prediction")
        }
    }
}

