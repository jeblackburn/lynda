//
//  ViewController.swift
//  PickerStuff
//
//  Created by Jon on 12/30/14.
//  Copyright (c) 2014 Jonathan Blackburn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let moods: [String] = ["Happy", "Contented", "Snide", "Bubbly", "Enraged", "Dilapidated"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.moods.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.moods[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0, 1, 3:
            NSLog("Happyish")
            self.view.backgroundColor = UIColor.yellowColor()
        default:
            NSLog("Unhappyish")
            self.view.backgroundColor = UIColor.redColor()
        }
    }
}

