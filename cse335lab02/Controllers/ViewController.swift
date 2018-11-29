//
//  ViewController.swift
//  cse335lab02
//
//  Created by Patrick Archer on 9/4/18.
//  Copyright © 2018 Patrick Archer - Self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /***************************/
    //  Begin declarations
    /***************************/
    @IBOutlet weak var label_searchReturnedFollowing: UILabel!
    @IBOutlet weak var label_food: UILabel!
    @IBOutlet weak var label_whereToFindFood: UILabel!
    
    @IBOutlet weak var label_foundFoodName: UILabel!
    @IBOutlet weak var label_foundFoodLoc: UILabel!
    
    @IBOutlet weak var barbutton_edit: UIBarButtonItem!
    @IBOutlet weak var barbutton_nextEntry: UIBarButtonItem!
    @IBOutlet weak var barbutton_prevEntry: UIBarButtonItem!
    
    // outlet declaration for bottom toolbar
    @IBOutlet weak var toolbar: UIToolbar!
    
    // create dictionary using MVC architecture
    var infoDict:infoDictionary = infoDictionary()
    
    // create alert controller
    //let alertController: UIAlertController = UIAlertController(title: "Alert", message: "", preferredStyle: .Alert)
    
    /***************************/
    //  Begin setup methods
    /***************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // hide all unnecessary labels from initial use screen
        self.label_searchReturnedFollowing.isHidden = true
        self.label_food.isHidden = true
        self.label_whereToFindFood.isHidden = true
        self.label_foundFoodName.isHidden = true
        self.label_foundFoodLoc.isHidden = true
        self.barbutton_nextEntry.isEnabled = false
        self.barbutton_prevEntry.isEnabled = false
        self.barbutton_edit.isEnabled = false
        
        //...
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //...
    }
    
    /***************************/
    //  Begin custom methods
    /***************************/
    
    /*
    // make the keyboard disapear as user touches outside the  text boxes
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        //self.unit2.resignFirstResponder()
        //self.unit1.resignFirstResponder()
    }
    */

    // if user presses the "add" button (plus sign), do...
    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        
        self.hideSearchResults() // hides unnecessary info from user
        
        // general alert popup setup
        let popup_addEntry = UIAlertController(title: "Add Entry", message: "Please enter a food name and the name of an establishment to find it (eg., Tacos & Taco Bell). Once finished, press OK.", preferredStyle: UIAlertControllerStyle.alert)
        
        // configure foodName textfield
        popup_addEntry.addTextField { (tf_foodName) in
            tf_foodName.placeholder = "FOOD NAME"
        }
        
        // configure foodLocation textfield
        popup_addEntry.addTextField { (tf_foodLocation) in
            tf_foodLocation.placeholder = "FOOD LOCATION"
        }
        
        // defines what to do when "OK" button tapped in popup alert and adds the button to the alert popup
        let alertAction_okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            var user_foodName = popup_addEntry.textFields![0].text!.lowercased() // store enterred name to var
            var user_foodLocation = popup_addEntry.textFields![1].text! // store enterred location to var
            
            
            
            // check if either text field is empty; if not, proceed
            if user_foodName.isEmpty == false &&
                user_foodLocation.isEmpty == false
            {
                // create new food record using MVC; store in dictionary
                //foodInfo.init(n: user_foodName, l: user_foodLocation)
                let newFoodRecord = foodInfo.init(n: user_foodName, l: user_foodLocation)
                self.infoDict.add(f: newFoodRecord)
                
                print(self.infoDict.infoRepo.description) // debug
                
                // clear all text fields
                user_foodName = ""
                user_foodLocation = ""
                
                
                
                
            }else{
                // Alert message will be displayed to the user if there is no input or input is in incorrect types
                let alert = UIAlertController(title: "DATA INPUT ERROR", message: "Data inputs are either empty or incorrect types. Please try again.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        })
        
        // defines what to do when "CANCEL" button tapped in popup alert and adds the button to the alert popup
        let alertAction_cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.cancel, handler: nil)
        
        // add required alert components (textfields already added) to alert view
        popup_addEntry.addAction(alertAction_okButton)
        popup_addEntry.addAction(alertAction_cancelButton)
        
        // present popup alert to user
        self.present(popup_addEntry, animated: true, completion: nil)
        
    }
    
    // if user presses the "delete" button (trash can), do...
    @IBAction func deleteEntry(_ sender: UIBarButtonItem) {
        
        self.hideSearchResults() // hides unnecessary info from user
        
        // general alert popup setup
        let popup_addEntry = UIAlertController(title: "Delete Entry", message: "Please enter the name of the food you would like to delete. NOTE: This will also delete all locations for where this food is found. Once ready, press OK.", preferredStyle: UIAlertControllerStyle.alert)
        
        // configure foodName textfield
        popup_addEntry.addTextField { (tf_foodName) in
            tf_foodName.placeholder = "FOOD NAME"
        }
        
        // defines what to do when "OK" button tapped in popup alert and adds the button to the alert popup
        let alertAction_okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            var user_foodName = popup_addEntry.textFields![0].text!.lowercased() // store enterred name to var
            
            // check if text field is empty; if not, proceed
            if user_foodName.isEmpty == false
            {
                // proceed with deletion of food entry
                self.infoDict.deleteEntry(n: user_foodName)
                
                print(self.infoDict.infoRepo.description) // debug
                
                // clear all text fields
                user_foodName = ""
                
                
                
                
            }else{
                // Alert message will be displayed to the user if there is no input or input is in incorrect types
                let alert = UIAlertController(title: "DATA INPUT ERROR", message: "Data input either empty or incorrect types. Please try again.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        })
        
        // defines what to do when "CANCEL" button tapped in popup alert and adds the button to the alert popup
        let alertAction_cancelButton = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
        // add required alert components (textfields already added) to alert view
        popup_addEntry.addAction(alertAction_okButton)
        popup_addEntry.addAction(alertAction_cancelButton)
        
        // present popup alert to user
        self.present(popup_addEntry, animated: true, completion: nil)
    }
    
    // if user presses the "search" button (magnifying glass), do...
    @IBAction func searchEntry(_ sender: UIBarButtonItem) {
        // general alert popup setup
        let popup_addEntry = UIAlertController(title: "Search for Entry", message: "Please enter the name of the food you would like to search for locations for. Once ready, press OK.", preferredStyle: UIAlertControllerStyle.alert)
        
        // configure foodName textfield
        popup_addEntry.addTextField { (tf_foodName) in
            tf_foodName.placeholder = "FOOD NAME"
        }
        
        // defines what to do when "OK" button tapped in popup alert and adds the button to the alert popup
        let alertAction_okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            var user_foodName = popup_addEntry.textFields![0].text!.lowercased() // store enterred name to var
            
            // check if text field is empty; if not, proceed
            if user_foodName.isEmpty == false
            {
                // proceed with search for food entry
                let foundFoodInfo = self.infoDict.search(n: user_foodName)
                
                // update info displayed to user
                self.updateInfo(f: foundFoodInfo)
                
                // displays now-necessary info to user
                self.displaySearchResults()
                
                //print(self.infoDict.infoRepo.description) // debug
                
                // clear all text fields
                user_foodName = ""
                
                
                
                
            }else{
                // Alert message will be displayed to the user if there is no input or input is in incorrect types
                let alert = UIAlertController(title: "DATA INPUT ERROR", message: "Data input either empty or incorrect types. Please try again.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        })
        
        // defines what to do when "CANCEL" button tapped in popup alert and adds the button to the alert popup
        let alertAction_cancelButton = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
        // add required alert components (textfields already added) to alert view
        popup_addEntry.addAction(alertAction_okButton)
        popup_addEntry.addAction(alertAction_cancelButton)
        
        // present popup alert to user
        self.present(popup_addEntry, animated: true, completion: nil)
    }
    
    // if user presses the "edit" bar button, do...
    @IBAction func editEntry(_ sender: UIBarButtonItem) {
        
        print("In editEntry()") // debug
        
        // general alert popup setup
        let popup_editEntry = UIAlertController(title: "Edit Location of Food Entry", message: "In the text box below, enter the new name of the location you would like for this current food entry.  Press OK when ready.", preferredStyle: UIAlertControllerStyle.alert)
        
        // configure foodName textfield
        popup_editEntry.addTextField { (tf_Loc) in
            tf_Loc.placeholder = "NEW LOCATION FOR CURRENT ENTRY"
        }
        
        // defines what to do when "OK" button tapped in popup alert and adds the button to the alert popup
        let alertAction_okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let current_entryKey = self.label_foundFoodName.text!.lowercased() // retrieve current entry's key
            var user_newLoc = popup_editEntry.textFields![0].text! // store enterred name to var
            
            // check if text field is empty; if not, proceed
            if user_newLoc.isEmpty == false
            {
                // Modify searched-for entry's location
                self.infoDict.edit(n: current_entryKey, m: user_newLoc)
                
                // update info displayed to user
                self.label_foundFoodLoc.text = user_newLoc
                
                print(self.infoDict.infoRepo.description) // debug
                
                // clear all text fields
                user_newLoc = ""
                
                
                
                
            }else{
                // Alert message will be displayed to the user if there is no input or input is in incorrect types
                let alert = UIAlertController(title: "DATA INPUT ERROR", message: "Data input either empty or incorrect types. Please try again.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        })
        
        // defines what to do when "CANCEL" button tapped in popup alert and adds the button to the alert popup
        let alertAction_cancelButton = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
        // add required alert components (textfields already added) to alert view
        popup_editEntry.addAction(alertAction_okButton)
        popup_editEntry.addAction(alertAction_cancelButton)
        
        // present popup alert to user
        self.present(popup_editEntry, animated: true, completion: nil)
        
    }
    
    var nextEntryPressCount:Int = 1
    var prevEntryPressCount:Int = 1
    
    // if user presses the "Next Entry" bar button, do...
    @IBAction func barbutton_nextEntry(_ sender: UIBarButtonItem) {
        
        print("In nextEntry()") // debug
        
        // increment # times nextEntry button pressed by user in single search session
        nextEntryPressCount = nextEntryPressCount + 1
        
        //let user_foodName = self.label_foundFoodName.text! // store enterred name to var
        //let user_foodLoc = self.label_foundFoodLoc.text! // store enterred loc to var
        
        let foundFoodKeys = self.infoDict.infoRepo.keys // create var for current list of dictionary keys
        let foundFoodValues = self.infoDict.infoRepo.values   // create var for current list of foodItem values [foodName, foodLocation]
        print(foundFoodKeys.debugDescription)   // debug
        print(foundFoodValues.debugDescription) // debug
        
        let foodValuesFirstDropped = foundFoodValues.dropLast()
        let nextFoodInfo = foodValuesFirstDropped.first
        
        //self.label_foundFoodLoc.text! = (foodValuesFirstDropped.first?.foodLocation!)!
        
        
        
        
        // proceed with search for food entry
        //let foundFoodInfo = self.infoDict.searchNext(n: user_foodName)
        
        // update info displayed to user
        //self.updateInfo(f: nextFoodInfo)
        
        self.label_foundFoodLoc.text! = (nextFoodInfo?.foodLocation!)!
        
        // displays now-necessary info to user
        self.displaySearchResults()
        
        print(nextFoodInfo.debugDescription)    // debug
        print(nextFoodInfo?.foodName!)
        print(nextFoodInfo?.foodLocation!)
        
        
        
    }
    
    // if user presses the "Prev. Entry" bar button, do...
    @IBAction func barbutton_prevEntry(_ sender: UIBarButtonItem) {
        
        print("In prevEntry()") // debug
        
        // increment # times prevEntry button pressed by user in single search session
        prevEntryPressCount = prevEntryPressCount + 1
        
        //let user_foodName = self.label_foundFoodName.text! // store enterred name to var
        //let user_foodLoc = self.label_foundFoodLoc.text! // store enterred loc to var
        
        let foundFoodKeys = self.infoDict.infoRepo.keys // create var for current list of dictionary keys
        let foundFoodValues = self.infoDict.infoRepo.values   // create var for current list of foodItem values [foodName, foodLocation]
        print(foundFoodKeys.debugDescription)   // debug
        print(foundFoodValues.debugDescription) // debug
        
        //var foodValuesFirstDropped = foundFoodValues.dropFirst(prevEntryPressCount)
        //print(foodValuesFirstDropped)
        //var nextFoodInfo = foodValuesFirstDropped.popFirst()
        
        var refinedFoodValueList = foundFoodValues.reversed().dropFirst()
        let nextFoodInfo = refinedFoodValueList.popFirst()
        
        
        
        //self.label_foundFoodLoc.text! = (foodValuesFirstDropped.first?.foodLocation!)!
        
        
        
        
        // proceed with search for food entry
        //let foundFoodInfo = self.infoDict.searchNext(n: user_foodName)
        
        // update info displayed to user
        self.updateInfo(f: nextFoodInfo)
        
        //self.label_foundFoodLoc.text! = (nextFoodInfo?.foodLocation!)!
        
        // displays now-necessary info to user
        self.displaySearchResults()
        
        print(nextFoodInfo.debugDescription)    // debug
        print(nextFoodInfo?.foodName!)
        print(nextFoodInfo?.foodLocation!)

    }
    
    // use this func to update values displayed to users
    func updateInfo(f: foodInfo?)
    {
        if f?.foodName == nil || f?.foodLocation == nil
        {
            self.label_foundFoodName.text = "No Record Found"
            self.label_foundFoodLoc.text = "No Record Found"
        }else{
            self.label_foundFoodName.text = f?.foodName!
            self.label_foundFoodLoc.text = f?.foodLocation!
        }
    }
    
    // quick-use func to hide all unnecessary labels from main screen
    func hideSearchResults()
    {
        self.label_searchReturnedFollowing.isHidden = true
        self.label_food.isHidden = true
        self.label_whereToFindFood.isHidden = true
        self.label_foundFoodName.isHidden = true
        self.label_foundFoodLoc.isHidden = true
        self.barbutton_nextEntry.isEnabled = false
        self.barbutton_prevEntry.isEnabled = false
        self.barbutton_edit.isEnabled = false
    }
    
    // quick-use func to un-hide all unnecessary labels from main screen
    func displaySearchResults()
    {
        self.label_searchReturnedFollowing.isHidden = false
        self.label_food.isHidden = false
        self.label_whereToFindFood.isHidden = false
        self.label_foundFoodName.isHidden = false
        self.label_foundFoodLoc.isHidden = false
        self.barbutton_nextEntry.isEnabled = true
        self.barbutton_prevEntry.isEnabled = true
        self.barbutton_edit.isEnabled = true
    }
    
    
}

