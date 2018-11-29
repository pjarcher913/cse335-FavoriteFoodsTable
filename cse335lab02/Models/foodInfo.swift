//
//  foodInfo.swift
//  cse335lab02
//
//  Created by Patrick Archer on 9/4/18.
//  Copyright © 2018 Patrick Archer - Self. All rights reserved.
//

import Foundation

// foodInfo class defines the foodInfo structure
class foodInfo {
    
    var foodName:String? = nil
    var foodLocation:String? = nil
    
    init(n:String, l:String) {
        self.foodName = n
        self.foodLocation = l
    }
    
    func changeFoodLocation(newLoc:String)
    {
        self.foodLocation = newLoc
    }
    
}
