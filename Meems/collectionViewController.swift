//
//  collectionViewController.swift
//  Meems
//
//  Created by raxit cholera on 12/8/15.
//  Copyright © 2015 kodeguide. All rights reserved.
//

import Foundation
import UIKit

class collectionViewController : UICollectionViewController {
    
    var memes: [MeemObject] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    @IBOutlet weak var flowLayout:UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        self.title = "Meems Collection View"
        let space:CGFloat = 3.0
        let dimention = (self.view.frame.width - (2 * space )) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimention, dimention)
    }
    override func viewWillAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    @IBAction func AddClicked(sender: AnyObject) {
    let controller = self.storyboard!.instantiateViewControllerWithIdentifier("meemCreat") as! ViewController
        
    presentViewController(controller, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let editviewMeem = self.storyboard!.instantiateViewControllerWithIdentifier("meemCreat") as! ViewController
//        editviewMeem.openInEditMode(memes[indexPath.row])
//        presentViewController(editviewMeem, animated: true, completion: nil)
        
        let viewMeem = self.storyboard!.instantiateViewControllerWithIdentifier("ViewMeem") as! ViewMeem
        viewMeem.meemedImage = memes[indexPath.row].memedImage
        navigationController?.pushViewController(viewMeem, animated: true)

        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("meemCollectionCell", forIndexPath: indexPath) as! CollectionViewCell
        let mem = memes[indexPath.row]
        cell.created_Image.image = mem.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
}