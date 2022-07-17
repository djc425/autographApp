//
//  Autographs.swift
//  AutographApp
//
//  Created by David Chester on 7/16/22.
//

import UIKit

class Autographs: NSObject {
    var date: Date
    var image: UIImage

    init(date: Date, image: UIImage){
        self.date = date
        self.image = image
    }
}
