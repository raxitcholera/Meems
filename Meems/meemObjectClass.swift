//
//  meemObjectClass.swift
//  Meems
//
//  Created by raxit cholera on 12/2/15.
//  Copyright © 2015 kodeguide. All rights reserved.
//

import Foundation
import UIKit

struct MeemObject {
    var topText:String?
    var bottomText:String?
    var originalImage:UIImage!
    var memedImage:UIImage!
    init(topText:String,bottomText:String,originalImage:UIImage,memedImage:UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
    }
}