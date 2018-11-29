//
//  infoDictionary.swift
//  cse335lab02
//
//  Created by Patrick Archer on 9/4/18.
//  Copyright © 2018 Patrick Archer - Self. All rights reserved.
//

import Foundation
class infoDictionary {
    
    var infoRepo:[String:foodInfo] = [String:foodInfo]()
    init() {}
    
    func add(f:foodInfo)   // may need to only use 1 parameter (f:foodInfo)
    {
        // print("adding" + f.foodName!)    // for debug
        infoRepo[f.foodName!] = f
    }
    
    func search(n:String) -> foodInfo?
    {
        var found = false
        
        // parse through full foodInfo dictionary list searching for passed name key
        for (name, _) in infoRepo
        {
            if name.lowercased() == n.lowercased() {
                found = true
                break
            }
        }
        
        // if name key found, grab the entry (& its corresponding info) from the dictionary repo
        if found
        {
            return infoRepo[n]
        }else{
            // else if entry not found, return nil
            return nil
        }
        
    }
    
    /*func searchNext(n:String) -> foodInfo?
    {
        var found = false
        
        // parse through full foodInfo dictionary list searching for passed name key
        for (name, _) in infoRepo
        {
            if name.lowercased() == n.lowercased() {
                found = true
                break
            }
        }
        
        // if name key found, grab the entry (& its corresponding info) from the dictionary repo
        if found
        {
            return infoRepo[n]
        }else{
            // else if entry not found, return nil
            return nil
        }
        
    }*/
    
    func deleteEntry(n: String)
    {
        infoRepo[n] = nil
    }
    
    func edit(n: String, m: String)
        // (where n is the name of the food w/ the changing location, and m is the new location name)
    {
        var found = false
        
        // parse through full foodInfo dictionary list searching for passed name key
        for (name, _) in infoRepo
        {
            if name == n {
                found = true
                break
            }
        }
        
        // if name key found, grab the entry (& its corresponding info) from the dictionary repo
        if found
        {
            // proceed to edit location of found entry
            infoRepo[n]?.changeFoodLocation(newLoc: m)
        }else{
            // else if entry not found, do nothing *(maybe alert user?)*
            //...
        }
    }
    
    func getNextLoc(n:String, l:String) -> String
    {
        //...
        
        return ""
    }
    
}
