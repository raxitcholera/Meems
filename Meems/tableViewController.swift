//
//  tableViewController.swift
//  Meems
//
//  Created by raxit cholera on 12/8/15.
//  Copyright © 2015 kodeguide. All rights reserved.
//

import Foundation
import UIKit

class tableViewController:UITableViewController {
    
    var memes: [MeemObject] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBAction func addClicked(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("meemCreat") as! ViewController
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        title = "Meems Table View"
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let editviewMeem = self.storyboard!.instantiateViewControllerWithIdentifier("meemCreat") as! ViewController
//        editviewMeem.openInEditMode(memes[indexPath.row])
//        presentViewController(editviewMeem, animated: true, completion: nil)
        let viewMeem = self.storyboard!.instantiateViewControllerWithIdentifier("ViewMeem") as! ViewMeem
        viewMeem.meemedImage = memes[indexPath.row].memedImage
        navigationController?.pushViewController(viewMeem, animated: true)
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("meemTableCell")!
        let mem = memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = mem.topText
        cell.imageView?.image = mem.memedImage

        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text =  mem.bottomText
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var allMeems: [MeemObject] = appDel.memes
            allMeems.removeAtIndex(indexPath.row)
            appDel.memes = allMeems
            tableView.reloadData()
        }
    }
}