//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Jon on 1/1/15.
//  Copyright (c) 2015 Jonathan Blackburn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    let devCourses = [("Programming the Internet of Things With Android ", " Michael Lehman"),
        ("C# Essential Training", "David Gassner"),
        ("C++ Essential Training", "Bill Weinman"),
        ("Code Clinic: C#", "David Gassner"),
        ("Code Clinic: PHP", "David Powers"),
        ("Programming the Internet of Things With Android ", " Michael Lehman"),
        ("C# Essential Training", "David Gassner"),
        ("C++ Essential Training", "Bill Weinman"),
        ("Code Clinic: C#", "David Gassner"),
        ("Code Clinic: PHP", "David Powers"),
        ("Programming the Internet of Things With Android ", " Michael Lehman"),
        ("C# Essential Training", "David Gassner"),
        ("C++ Essential Training", "Bill Weinman"),
        ("Code Clinic: C#", "David Gassner"),
        ("Code Clinic: PHP", "David Powers"),
        ("Code Clinic: C++", "Bill Weinman")]
    
    let webCourses = [("Web Stuff 1", " Michael Lehman"),
        ("More Web Stuff", "David Gassner"),
        ("Even More Web Stuff", "Bill Weinman"),
        ("All Kinds of Web Stuff", "David Gassner"),
        ("Web Stuff You Don't Need to Learn", "David Powers"),
        ("Web Stuff 1", " Michael Lehman"),
        ("More Web Stuff", "David Gassner"),
        ("Even More Web Stuff", "Bill Weinman"),
        ("All Kinds of Web Stuff", "David Gassner"),
        ("Web Stuff You Don't Need to Learn", "David Powers"),
        ("Web Stuff 1", " Michael Lehman"),
        ("More Web Stuff", "David Gassner"),
        ("Even More Web Stuff", "Bill Weinman"),
        ("All Kinds of Web Stuff", "David Gassner"),
        ("Web Stuff You Don't Need to Learn", "David Powers"),
        ("Web Stuff 1", " Michael Lehman"),
        ("More Web Stuff", "David Gassner"),
        ("Even More Web Stuff", "Bill Weinman"),
        ("All Kinds of Web Stuff", "David Gassner"),
        ("Web Stuff You Don't Need to Learn", "David Powers"),
        ("Web Stuff You Needed to Learn Until Last Week", "Bill Weinman")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Dev Courses" : "Web Courses"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.devCourses.count
        } else {
            return self.webCourses.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var courses = webCourses
        if indexPath.section == 0 {
            courses = self.devCourses
        }
        let (title, author) = courses[indexPath.row]
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = author
        let myImage = UIImage(named: "CellIcon")
        cell.imageView?.image = myImage
        if indexPath.row % 2 == 0 {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator            
        }
        return cell
    }
}

