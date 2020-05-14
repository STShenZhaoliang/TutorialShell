//
//  Date+STKit.swift
//  STKitSwift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2019 沈天
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
/// This extension add some useful functions to Date.
public extension Date {
    // MARK: - Variables
    
    /// Set and get current year.
    var year: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.year], from: self)
            guard let year = components.year else {
                return 0
            }
            return year
        }
        set {
            update(components: [.year: newValue])
        }
    }
    
    /// Set and get current month.
    var month: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.month], from: self)
            
            guard let month = components.month else {
                return 0
            }
            
            return month
        }
        set {
            update(components: [.month: newValue])
        }
    }
    
    /// Set and get current day.
    var day: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.day], from: self)
            
            guard let day = components.day else {
                return 0
            }
            
            return day
        }
        set {
            update(components: [.day: newValue])
        }
    }
    
    /// Set and get current hour.
   var hour: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.hour], from: self)
            
            guard let hour = components.hour else {
                return 0
            }
            
            return hour
        }
        set {
            update(components: [.hour: newValue])
        }
    }
    
    /// Set and get current minute.
    var minute: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.minute], from: self)
            
            guard let minute = components.minute else {
                return 0
            }
            
            return minute
        }
        set {
            update(components: [.minute: newValue])
        }
    }
    
    /// Set and get current second.
    var second: Int {
        get {
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.second], from: self)
            
            guard let second = components.second else {
                return 0
            }
            
            return second
        }
        set {
            update(components: [.second: newValue])
        }
    }
    
    /// Get current nanosecond.
   var nanosecond: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.nanosecond], from: self)
        
        guard let nanosecond = components.nanosecond else {
            return 0
        }
        
        return nanosecond
    }
    
    /// Get the weekday number from
    /// - 1 - Sunday.
    /// - 2 - Monday.
    /// - 3 - Tuerday.
    /// - 4 - Wednesday.
    /// - 5 - Thursday.
    /// - 6 - Friday.
    /// - 7 - Saturday.
    var weekday: Int {
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.weekday], from: self)
        
        guard let weekday = components.weekday else {
            return 0
        }
        
        return weekday
    }
    
    /// Editable date components.
    ///
    /// - year: Year component.
    /// - month: Month component.
    /// - day: Day component.
    /// - hour: Hour component.
    /// - minute: Minute component.
    /// - second: Second component.
    enum EditableDateComponents: Int {
        case year
        case month
        case day
        case hour
        case minute
        case second
    }
    
    // MARK: - Functions
    
    /// Update current Date components.
    ///
    /// - Parameters:
    ///   - components: Dictionary of components and values to be updated.
    mutating func update(components: [EditableDateComponents: Int]) {
        let autoupdatingCalendar = Calendar.autoupdatingCurrent
        var dateComponents = autoupdatingCalendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second, .nanosecond], from: self)
        
        for (component, value) in components {
            switch component {
            case .year:
                dateComponents.year = value
            case .month:
                dateComponents.month = value
            case .day:
                dateComponents.day = value
            case .hour:
                dateComponents.hour = value
            case .minute:
                dateComponents.minute = value
            case .second:
                dateComponents.second = value
            }
        }
        
        let calendar = Calendar(identifier: autoupdatingCalendar.identifier)
        guard let date = calendar.date(from: dateComponents) else {
            return
        }
        self = date
    }
}
