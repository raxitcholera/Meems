//
//  ViewMeem.swift
//  Meems
//
//  Created by raxit cholera on 12/8/15.
//  Copyright © 2015 kodeguide. All rights reserved.
//

import Foundation
import UIKit

class ViewMeem:UIViewController {
    
    var meemedImage:UIImage?
    
    @IBOutlet weak var displayMeem: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        displayMeem.image = meemedImage
    }
}
