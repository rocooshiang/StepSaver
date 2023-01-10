//
//  TimerViewController.swift
//  OneHourWalker
//
//  Created by Matthew Maher on 2/18/16.
//  Copyright © 2016 Matt Maher. All rights reserved.
//

import UIKit
import CoreLocation
import HealthKit

class TimerViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var txtStep: UITextField!
    
    let healthManager: HealthKitManager = HealthKitManager()
    
    @IBAction func onClickSaveStep(_ sender: UIButton) {
        let step = Double(txtStep.text ?? "75000") ?? 75000
        healthManager.saveStep(step: step, date: Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We cannot access the user's HealthKit data without specific permission.
        getHealthKitPermission()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func getHealthKitPermission() {
        
        // Seek authorization in HealthKitManager.swift.
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                print("Permission allow")
            } else {
                if error != nil {
                    print(error)
                }
                print("Permission denied.")
            }
        }
    }
}
