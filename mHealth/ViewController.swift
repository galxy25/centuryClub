//
//  ViewController.swift
//  mHealth
//
//  Created by Levi Schoen on 5/21/15.
//  Copyright (c) 2015 Levi Schoen. All rights reserved.
//

import UIKit
import CoreData
import HealthKit

var userData = [NSManagedObject]()
var userDaily = [NSManagedObject]()
var userRunning = [NSManagedObject]()

var maleLE = [0:76.1,
  1:75.62,
  2:74.65,
  3:73.67,
  4:72.69,
  5:71.7,
  6:70.71,
  7:69.72,
  8:68.73,
  9:67.74,
  10:66.74,
  11:65.75,
  12:64.76,
  13:63.76,
  14:62.78,
  15:61.8,
  16:60.82,
  17:59.86,
  18:58.9,
  19:57.95,
  20:57,
  21:56.06,
  22:55.13,
  23:54.2,
  24:53.27,
  25:52.34,
  26:51.41,
  27:50.48,
  28:49.55,
  29:48.62,
  30:47.68,
  31:46.75,
  32:45.82,
  33:44.88,
  34:43.95,
  35:43.02,
  36:42.08,
  37:41.15,
  38:40.22,
  39:39.3,
  40:38.37,
  41:37.45,
  42:36.53,
  43:35.62,
  44:34.72,
  45:33.82,
  46:32.93,
  47:32.05,
  48:31.17,
  49:30.31,
  50:29.45,
  51:28.6,
  52:27.76,
  53:26.93,
  54:26.1,
  55:25.29,
  56:24.48,
  57:23.69,
  58:22.9,
  59:22.12,
  60:21.34,
  61:20.57,
  62:19.81,
  63:19.05,
  64:18.3,
  65:17.57,
  66:16.84,
  67:16.13,
  68:15.43,
  69:14.75,
  70:14.07,
  71:13.4,
  72:12.75,
  73:12.12,
  74:11.49,
  75:10.89,
  76:10.3,
  77:9.72,
  78:9.17,
  79:8.63,
  80:8.1,
  81:7.6,
  82:7.11,
  83:6.65,
  84:6.21,
  85:5.78,
  86:5.38,
  87:5,
  88:4.64,
  89:4.3,
  90:3.99,
  91:3.7,
  92:3.44,
  93:3.2,
  94:2.98,
  95:2.79,
  96:2.62,
  97:2.47,
  98:2.34,
  99:2.22,
  100:2.1,
  101:1.99,
  102:1.88,
  103:1.78,
  104:1.68,
  105:1.59,
  106:1.5,
  107:1.41,
  108:1.32,
  109:1.24,
  110:1.17,
  111:1.09,
  112:1.02,
  113:0.95,
  114:0.89,
  115:0.83,
  116:0.77,
  117:0.71,
  118:0.66,
  119:0.6
]
var femaleLE = [0:80.94,
  1:80.39,
  2:79.43,
  3:78.44,
  4:77.46,
  5:76.47,
  6:75.47,
  7:74.48,
  8:73.49,
  9:72.5,
  10:71.5,
  11:70.51,
  12:69.52,
  13:68.52,
  14:67.53,
  15:66.54,
  16:65.56,
  17:64.57,
  18:63.59,
  19:62.61,
  20:61.63,
  21:60.66,
  22:59.68,
  23:58.71,
  24:57.74,
  25:56.77,
  26:55.79,
  27:54.82,
  28:53.85,
  29:52.88,
  30:51.92,
  31:50.95,
  32:49.98,
  33:49.02,
  34:48.06,
  35:47.1,
  36:46.14,
  37:45.18,
  38:44.23,
  39:43.27,
  40:42.32,
  41:41.38,
  42:40.43,
  43:39.5,
  44:38.56,
  45:37.63,
  46:36.71,
  47:35.79,
  48:34.88,
  49:33.97,
  50:33.07,
  51:32.18,
  52:31.29,
  53:30.4,
  54:29.52,
  55:28.65,
  56:27.77,
  57:26.91,
  58:26.04,
  59:25.19,
  60:24.34,
  61:23.49,
  62:22.65,
  63:21.83,
  64:21.01,
  65:20.2,
  66:19.4,
  67:18.62,
  68:17.84,
  69:17.08,
  70:16.33,
  71:15.59,
  72:14.87,
  73:14.16,
  74:13.46,
  75:12.77,
  76:12.11,
  77:11.46,
  78:10.83,
  79:10.21,
  80:9.61,
  81:9.03,
  82:8.47,
  83:7.93,
  84:7.41,
  85:6.91,
  86:6.44,
  87:5.99,
  88:5.56,
  89:5.17,
  90:4.8,
  91:4.45,
  92:4.13,
  93:3.84,
  94:3.58,
  95:3.34,
  96:3.13,
  97:2.94,
  98:2.76,
  99:2.6,
  100:2.45,
  101:2.31,
  102:2.17,
  103:2.03,
  104:1.91,
  105:1.79,
  106:1.67,
  107:1.56,
  108:1.45,
  109:1.35,
  110:1.26,
  111:1.17,
  112:1.08,
  113:1,
  114:0.92,
  115:0.84,
  116:0.77,
  117:0.71,
  118:0.66,
  119:0.6
]

var initialUserLE:Double = 0
var minutesLEchange = 0

class ViewController: UIViewController {
  let healthManager:HealthManager = HealthManager()
  @IBOutlet var dailyStat: UILabel!
  
  @IBOutlet var intialLEMinutes: UILabel!
  @IBOutlet var totalMinutesGained: UILabel!
  
    override func viewDidLoad() {
    //1
    var appDelegate =
    UIApplication.sharedApplication().delegate as! AppDelegate
    
    var managedContext = appDelegate.managedObjectContext!
    
    var fetchRequest = NSFetchRequest(entityName:"UserData")
    fetchRequest.returnsObjectsAsFaults = false;
    
    var error: NSError?
    
    var fetchedResults =
    managedContext.executeFetchRequest(fetchRequest,
      error: &error) as? [NSManagedObject]
    
    if var results = fetchedResults {
      userData = results
      if userData.count > 0 {
        var temp = userData[userData.count-1]
        var temp6 = temp.valueForKey("initialLE") as! Double
        println("Temp6: \(temp6)")
        initialUserLE = temp6
        temp6 = temp6 * 525949
        intialLEMinutes.text = "Initial Minutes Of Life: \(temp6)"
      }
      else {
        println("No data to show")
      }
      
    } else {
      println("Could not fetch \(error), \(error!.userInfo)")
    }
    
//      var fetchRequest2 = NSFetchRequest(entityName:"UserDaily")
//      fetchRequest2.returnsObjectsAsFaults = false;
//      
//      var error2: NSError?
//      
//      var fetchedResults2 =
//      managedContext.executeFetchRequest(fetchRequest2,
//        error: &error2) as? [NSManagedObject]
//      
//      if var results2 = fetchedResults2 {
//        userDaily = results2
//        var temp2=userDaily.first
//        if (temp2 != nil)  {
//          println(userDaily)
//        }
//        else
//        {
//          println("Nope")
//        }
//      } else {
//        println("Could not fetch \(error2), \(error2!.userInfo)")
//      }
      
      var fetchRequest3 = NSFetchRequest(entityName:"UserRunning")
      fetchRequest3.returnsObjectsAsFaults = false;
      
      var error3: NSError?
      
      var fetchedResults3 =
      managedContext.executeFetchRequest(fetchRequest3,
        error: &error3) as? [NSManagedObject]
      
      if var results3 = fetchedResults3 {
        userRunning = results3
        if (userRunning.count > 0 ) {
          var temp3=userRunning[userRunning.count-1]
          println("temp3: \(temp3)")
          var temp4 = temp3.valueForKey("accumulatedLE") as! Double
          var temp5 = (temp4 - (initialUserLE * 525949))
          
          totalMinutesGained.text = "Total Gained Since Start: \(temp5)"
          var temp42 = temp3.valueForKey("dailyGain")! as! Double
          dailyStat.text = "\(temp42)"
        }
        
      } else {
        println("Could not fetch \(error3), \(error3!.userInfo)")
      }

      healthManager.authorizeHealthKit { (authorized,  error) -> Void in
        if authorized {
          println("HealthKit authorization received.")
        }
        else
        {
          println("HealthKit authorization denied!")
          if error != nil {
            println("\(error)")
          }
        }
      }
      
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

