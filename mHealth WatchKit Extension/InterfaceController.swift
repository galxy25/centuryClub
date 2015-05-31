//
//  InterfaceController.swift
//  mHealth WatchKit Extension
//
//  Created by Levi Schoen on 5/31/15.
//  Copyright (c) 2015 Levi Schoen. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

  @IBOutlet var dailyStat: WKInterfaceLabel!
  @IBAction func tellMeMore() {
    dailyStat.setText("Coming soon!")
    
  }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
      
      let defaults = NSUserDefaults.standardUserDefaults()
      if let name = defaults.stringForKey("userRunning")
      {
        println(name)
      }
      else {
        println("Nope")
      }
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
