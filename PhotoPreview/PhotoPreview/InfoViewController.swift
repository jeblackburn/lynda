//
//  InfoViewController.swift
//  PhotoPreview
//
//  Created by Jon on 1/4/15.
//  Copyright (c) 2015 Jonathan Blackburn. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var currentPhoto: Photo?

    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBAction func dismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = currentPhoto!.notes

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
