//
//  ViewController.swift
//  FirstDemo
//
//  Created by Jon on 12/26/14.
//  Copyright (c) 2014 Jonathan Blackburn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBAction func buttonPressed(sender: UIButton) {
        self.textLabel.text = "Hello, " + self.textField.text + "!"
        self.textField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
}

