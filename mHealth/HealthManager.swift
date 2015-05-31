//
//  HealthManager.swift
//  HKTutorial
//
//  Created by ernesto on 18/10/14.
//  Copyright (c) 2014 raywenderlich. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class HealthManager {
  
  let healthKitStore:HKHealthStore = HKHealthStore()
  
  func readMostRecentSample(sampleType:HKSampleType , completion: ((HKSample!, NSError!) -> Void)!)
  {
    
    // 1. Build the Predicate
    let now   = NSDate()
    let past = NSDate.distantPast() as! NSDate
    let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(past, endDate:now, options: .None)
    
    // 2. Build the sort descriptor to return the samples in descending order
    let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
    // 3. we want to limit the number of samples returned by the query to just 1 (the most recent)
    let limit = 1
    
    // 4. Build samples query
    let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit: limit, sortDescriptors: [sortDescriptor])
      { (sampleQuery, results, error ) -> Void in
        
        if let queryError = error {
          completion(nil,error)
          return;
        }
        // Get the first sample
        let mostRecentSample = results.first as? HKQuantitySample
        
        // Execute the completion closure
        if completion != nil {
          completion(mostRecentSample,nil)
        }
    }
    // 5. Execute the Query
    self.healthKitStore.executeQuery(sampleQuery)
  }
  
//  HKSampleType
  func read24HourSample(sampleType:HKQuantityType , completion: ((HKQuantity!, NSError!) -> Void)!)
  {
    
    // 1. Build the Predicate
    let mostRecentPredicate =  self.predicateForSamplesToday()
    
    // 2. Build the sort descriptor to return the samples in descending order
    let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
    // 3. we want to limit the number of samples returned by the query to just 1 (the most recent)
    let limit = 20
    
    // 4. Build samples query
//    let sampleQuery = HKSampleQuery(sampleType: sampleType
    let sampleQuery = HKStatisticsQuery(quantityType: sampleType,
      quantitySamplePredicate: mostRecentPredicate,
      options: .None) { query, result, error in
        
//        if result != nil {
//          completionHandler(nil, error)
//          return
//        }
        
        var totalCalories = 0.0
        println("Results: \(result.sumQuantity())")
        if let quantity = result.sumQuantity() {
          let unit = HKUnit.jouleUnit()
          totalCalories = quantity.doubleValueForUnit(unit)
        }
//        completionHandler(totalCalories, error)
    }
    // 5. Execute the Query
    self.healthKitStore.executeQuery(sampleQuery)
  }

  private func predicateForSamplesToday() -> NSPredicate
  {
    let (starDate: NSDate, endDate: NSDate) = self.datesFromToday()
    
    let predicate: NSPredicate = HKQuery.predicateForSamplesWithStartDate(starDate, endDate: endDate, options: HKQueryOptions.StrictStartDate)
    
    return predicate
  }
  
  private func datesFromToday() -> (NSDate, NSDate)
  {
    let calendar: NSCalendar = NSCalendar.currentCalendar()
    
    let nowDate: NSDate = NSDate()
    
    let starDate: NSDate = calendar.startOfDayForDate(nowDate)
    let endDate: NSDate = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: 1, toDate: starDate, options: NSCalendarOptions.allZeros)!
    
    return (starDate, endDate)
  }

  func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!)
  {
    // 1. Set the types you want to read from HK Store
    let healthKitTypesToRead = NSSet(array:[
      HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth),
      HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBloodType),
      HKObjectType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierBiologicalSex),
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning),
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight),
      HKObjectType.workoutType()
      ])
    
    // 2. Set the types you want to write to HK Store
    let healthKitTypesToWrite = NSSet(array:[
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex),
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned),
    HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBasalEnergyBurned),
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning),
      HKQuantityType.workoutType(),
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate),
      HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed)
      ])
    
    // 3. If the store is not available (for instance, iPad) return an error and don't go on.
    if !HKHealthStore.isHealthDataAvailable()
    {
      let error = NSError(domain: "com.raywenderlich.tutorials.healthkit", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
      if( completion != nil )
      {
        completion(success:false, error:error)
      }
      return;
    }
    
    // 4.  Request HealthKit authorization
    healthKitStore.requestAuthorizationToShareTypes(healthKitTypesToWrite as Set<NSObject>, readTypes: healthKitTypesToRead as Set<NSObject>) { (success, error) -> Void in
      
      if( completion != nil )
      {
        completion(success:success,error:error)
      }
    }
  }
}