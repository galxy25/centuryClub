//
//  SecondViewController.swift
//  mHealth
//
//  Created by Levi Schoen on 5/21/15.
//  Copyright (c) 2015 Levi Schoen. All rights reserved.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {
  
  @IBOutlet var hoursSlept: UISlider!
  @IBOutlet var userSlept: UILabel!
  @IBAction func selectHoursSlept(sender: AnyObject) {
    var temp = Int(hoursSlept.value)
    userSlept.text="\(temp)"
  }
  
  
  @IBOutlet var drinksDrunk: UISlider!
  @IBOutlet var userDrinks: UILabel!
  @IBAction func selectDrinksDrunk(sender: AnyObject) {
    var temp = Int(drinksDrunk.value)
    userDrinks.text="\(temp)"
  }
  
  
  @IBOutlet var cigsSmoked: UISlider!
  @IBOutlet var userCigs: UILabel!
  @IBAction func selectCigsSmoked(sender: AnyObject) {
    var temp = Int(cigsSmoked.value)
    userCigs.text="\(temp)"
  }
  
  
  @IBOutlet var minutesExercised: UISlider!
  @IBOutlet var minutesMoved: UILabel!
  
  @IBAction func selectMinutesMoved(sender: AnyObject) {
    var temp = Int(minutesExercised.value)
    minutesMoved.text="\(temp)"
  }
  
  @IBAction func submitDailyData(sender: AnyObject) {
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var context : NSManagedObjectContext! = appDel.managedObjectContext!
    
    var entity =  NSEntityDescription.entityForName("UserDaily",
      inManagedObjectContext:
      context)
    
    var tempData = NSManagedObject(entity: entity!,
      insertIntoManagedObjectContext:context)
    
    var temp = Int(hoursSlept.value)
    tempData.setValue(temp, forKey: "sleepHours")
    
    var temp2 = Int(drinksDrunk.value)
    tempData.setValue(temp2, forKey: "drinks")
    
    var temp3 = Int(cigsSmoked.value)
    tempData.setValue(temp3, forKey: "cigarettes")
    
    var temp4 = Int(minutesExercised.value)
    tempData.setValue(temp4, forKey: "minutesMoved")
    
    var error: NSError?
    if !context.save(&error) {
      println("Could not save \(error), \(error?.userInfo)")
    }

    calculateLEChange()
  }
  func calculateLEChange() {
    if (userData.count == 0) {
      return
    } else {
      let latestDemo = userData[userData.count-1]
      let gainFromExercise = Int(minutesExercised.value) * 7
      
      if (latestDemo.valueForKey("isSmoker") ) {
        if (latestDemo.valueForKey("heavySmoker")) {
          
        }
        else {
          
        }
      }
      let gainFromSleeping =
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
