//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Richard Hodgkins on 26/11/2014.
//  Copyright (c) 2014 Rich H. All rights reserved.
//

import UIKit

struct SectionItem {
    
    let headerTitle: String?
    let footerTitle: String?
    private var rows = [DataRow]()
    
    mutating func addRow(row: DataRow)
    {
        rows.append(row)
    }
}

struct DataRow {
    
    let reuseIdentifier: String!
    let title: String!
    let subtitle: String?
    let deletable: Bool!
    let movable: Bool!
    let deleteTitle: String?
    private var actions = [UITableViewRowAction]()
    
    mutating func addAction(style: UITableViewRowActionStyle, title: String!, handler: (UITableViewRowAction!, NSIndexPath!) -> Void)
    {
        let action = UITableViewRowAction(style: style, title: title, handler: handler)
        actions.append(action)
    }
}

extension UITableViewRowAnimation {
    
    func navButtonTitle() -> String! {
        switch (self) {
            case Fade:
                return "Fade"
            case Right:
                return "Right"
            case Left:
                return "Left"
            case Top:
                return "Top"
            case Bottom:
                return "Bottom"
            case None:
                return "None"
            case Middle:
                return "Middle"
            case Automatic:
                return "Auto"
        }
    }
    
    mutating func next() {
        switch (self) {
            case Fade:
                self = .Right
            case Right:
                self = .Left
            case Left:
                self = .Top
            case Top:
                self = .Bottom
            case Bottom:
                self = .None
            case None:
                self = .Middle
            case Middle:
                self = .Automatic
            case Automatic:
                self = .Fade
        }
    }
}

class ViewController: UITableViewController {
    
    private lazy var data = ViewController.createInitialData()

    @IBOutlet private var addTypeBarButtonItem: UIBarButtonItem!
    private var currentAnimationType: UITableViewRowAnimation = UITableViewRowAnimation.Fade {
        didSet {
           self.addTypeBarButtonItem.title = currentAnimationType.navButtonTitle()
        }
    }

    class func createInitialData() -> [SectionItem]
    {
        var data = [SectionItem]()
        
        for index in 1...10 {
            data.append(self.createStandardSection(index))
        }
        
        return data
    }
    
    class func createStandardSection(index: Int) -> SectionItem
    {
        return SectionItem(headerTitle: "Section \(index)", footerTitle: "Footer \(index)", rows: [])
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItem!, addTypeBarButtonItem]
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.currentAnimationType = UITableViewRowAnimation.Fade
    }
    
    @IBAction func didTapAdd()
    {
        
    }
    
    
    @IBAction func didTapAddType()
    {
        self.currentAnimationType.next()
    }
    
    // MARK: Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].rows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = data[indexPath.section].rows[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(item.reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        return cell
    }
    
    // MARK: Table view delegate
    
}

