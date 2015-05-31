//
//  SecondViewController.swift
//  mHealth
//
//  Created by Levi Schoen on 5/21/15.
//  Copyright (c) 2015 Levi Schoen. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {
  
  @IBOutlet var userAge: UITextField!
  @IBOutlet var userGender: UISegmentedControl!
  @IBOutlet var userHeight: UITextField!
  @IBOutlet var userWeight: UITextField!
  @IBOutlet var isSmoker: UISegmentedControl!
  @IBOutlet var cigarettesPerDay: UISlider!
  @IBOutlet var hoursExercisePerWeek: UISlider!
  @IBOutlet var diabetes: UISegmentedControl!
  @IBOutlet var hypertension: UISegmentedControl!
  @IBOutlet var highBloodPressure: UISegmentedControl!
  
  @IBAction func cigsCount(sender: AnyObject) {
    let temp = Int(cigarettesPerDay.value)
    cigs.text = "\(temp)"
  }
  @IBOutlet var cigs: UILabel!
  
  @IBAction func exeCount(sender: AnyObject) {
    let temp = Int(hoursExercisePerWeek.value)
    exe.text = "\(temp)"
  }
  @IBOutlet var exe: UILabel!
  
  @IBAction func saveDemographicData(sender: AnyObject) {
    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var context : NSManagedObjectContext! = appDel.managedObjectContext!
    
    var entity =  NSEntityDescription.entityForName("UserData",
      inManagedObjectContext:
      context)
    
    var tempData = NSManagedObject(entity: entity!,
      insertIntoManagedObjectContext:context)
    
    var entity2 =  NSEntityDescription.entityForName("UserRunning",
      inManagedObjectContext:
      context)
    
    var tempData2 = NSManagedObject(entity: entity2!,
      insertIntoManagedObjectContext:context)
    
    if isSmoker.selectedSegmentIndex == 0 {
      tempData.setValue(true, forKey: "isSmoker")
    }
    else {
      tempData.setValue(false, forKey: "isSmoker")
    }

    if diabetes.selectedSegmentIndex == 0 {
      tempData.setValue(true, forKey: "diabetes")
    }
    else {
      tempData.setValue(false, forKey: "diabetes")
    }
    
    if hypertension.selectedSegmentIndex == 0 {
      tempData.setValue(true, forKey: "hypertension")
    }
    else {
      tempData.setValue(false, forKey: "hypertension")
    }
    
    if highBloodPressure.selectedSegmentIndex == 0 {
      tempData.setValue(true, forKey: "highBloodPressure")
    }
    else {
      tempData.setValue(false, forKey: "highBloodPressure")
    }
    
    if userGender.selectedSegmentIndex == 0 {
      tempData.setValue("MALE", forKey: "gender")
    }
    else {
      tempData.setValue("FEMALE", forKey: "gender")
    }
    
    var temp = userAge.text.toInt()
    if temp != nil {
      tempData.setValue(temp, forKey: "age")
    }
    else {
      userAge.text="0"
    }
    
    var temp2 = userHeight.text.toInt()
    if temp2 != nil {
      tempData.setValue(temp2, forKey: "height")
    }
    else {
      userHeight.text="0"
    }
    
    var temp3 = userWeight.text.toInt()
    if temp3 != nil {
      tempData.setValue(temp3, forKey: "weight")
    }
    else {
      userWeight.text="0"
    }
    
    
    tempData.setValue(Int(cigarettesPerDay.value), forKey: "cigarettesPerDay")
    
    if (Int(cigarettesPerDay.value) > 10) {
      tempData.setValue(true, forKey: "heavySmoker")
    }
    else {
      tempData.setValue(false, forKey: "heavySmoker")
    }
    
    tempData.setValue(Int(hoursExercisePerWeek.value), forKey: "hoursExercisePerWeek")
    
    
    tempData.setValue(calculateInitialLE(), forKey: "initialLE")
    tempData2.setValue((calculateInitialLE() * 525949), forKey: "accumulatedLE")
    
    var error2: NSError?
    if !context.save(&error2) {
      println("Could not save \(error2), \(error2?.userInfo)")
    }
    else {
      println("save worked")
      
      var fetchRequest = NSFetchRequest(entityName:"UserData")
      fetchRequest.returnsObjectsAsFaults = false;
      
      var error: NSError?
      
      var fetchedResults =
      context.executeFetchRequest(fetchRequest,
        error: &error) as? [NSManagedObject]
      
      if var results = fetchedResults {
        userData = results
        var temp=userData.first
        if (temp != nil)  {
          
          println("Here")
        }
        else
        {
          println("broken!")
        }
      } else {
        println("Could not fetch \(error), \(error!.userInfo)")
      }
    }
  }
  
  func calculateInitialLE() -> Double {
    var first:Double = 0.0
    if userGender.selectedSegmentIndex == 0 {
      first = maleLE[userAge.text.toInt()!]!
    }else {
      first = femaleLE[userAge.text.toInt()!]!
    }
    
    println(first)
    
    var temp1 = userWeight.text.toInt()!
    var temp2 = userHeight.text.toInt()! * userHeight.text.toInt()!
    var bmi = (Double(temp1) / Double(temp2)) * 733
    
    if bmi > 40  && bmi < 55 {
      first -= 6.5
    }
    else if bmi > 55{
      first -= 13.7
    }
    
    println(first)
    
    if isSmoker.selectedSegmentIndex == 0 {
      if Int(cigarettesPerDay.value) < 10 {
        first -= 6.8
      }
      else {
        first -= 8.8
      }
    }
    
    println(first)

    if diabetes.selectedSegmentIndex == 0 {
      if userGender.selectedSegmentIndex == 0{
        first -= 11
      } else {
        first -= 13
      }
    }
   
    if hypertension.selectedSegmentIndex == 0 || highBloodPressure.selectedSegmentIndex == 0 {
      if userAge.text.toInt()! > 50 {
        first -= 5
      }
    }
      if Int(hoursExercisePerWeek.value) > 1 && Int(hoursExercisePerWeek.value) < 2 {
        first += 1.8
      } else if Int(hoursExercisePerWeek.value) > 2 {
        first += 4.5
      }
    
    println(first)
    return first
    }
  
  override func viewDidLoad() {
    println(userData)
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.view.endEditing( true)
  }
  
  func textFieldShouldReturn(textField: UITextField!) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}
