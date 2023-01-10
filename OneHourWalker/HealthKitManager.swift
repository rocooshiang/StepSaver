//
//  HealthKitManager.swift
//  OneHourWalker
//
//  Created by Matthew Maher on 2/19/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((_ success: Bool, _ error: Error?) -> Void)!) {
                
        // State the health data type(s) we want to write from HealthKit.
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
        
        
        // Just in case OneHourWalker makes its way to an iPad...
        if !HKHealthStore.isHealthDataAvailable() {
            print("Can't access HealthKit.")
        }
        
        // Request authorization to read and/or write the specific data.
        
        healthKitStore.requestAuthorization(toShare: healthDataToWrite, read: nil) { success, error in
            if( completion != nil ) {
                completion(success, error)
            }
        }
    }
    
    
    func saveStep(step: Double, date: Date) {
                
        // Set the quantity type to the running/walking distance.
        let distanceType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        // Set the unit of measurement to miles.
        let stepQuantity = HKQuantity(unit: .count(), doubleValue: step)
        
        
        // Set the official Quantity Sample.
        let stepSample = HKQuantitySample(type: distanceType!, quantity: stepQuantity, start: date, end: date)
        
        
        // Save the distance quantity sample to the HealthKit Store.
        healthKitStore.save(stepSample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error)
            } else {
                print("汗水沒在流～～～灌入\(Int(step))步")
            }
        })
    }
}
