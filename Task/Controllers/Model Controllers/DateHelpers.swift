//
//  DateHelpers.swift
//  Task
//
//  Created by Deniz Tutuncu on 1/30/19.
//  Copyright © 2019 Deniz Tutuncu. All rights reserved.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
