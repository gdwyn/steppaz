//
//  HealthKitManager.swift
//  steppaz
//
//  Created by Godwin IE on 07/03/2025.
//

import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    
    private let healthStore = HKHealthStore()
    private let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }
        
        healthStore.requestAuthorization(toShare: nil, read: [stepsQuantityType]) { success, error in
            completion(success, error)
        }
    }
    
    func fetchStepsCount(for date: Date, completion: @escaping (Int, Error?) -> Void) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        let query = HKStatisticsQuery(
            quantityType: stepsQuantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum
        ) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0, error)
                return
            }
            
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            completion(steps, nil)
        }
        
        healthStore.execute(query)
    }
}
