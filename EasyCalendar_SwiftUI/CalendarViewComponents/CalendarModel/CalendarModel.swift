//
//  CalendarModel.swift
//  EasyCalendar_SwiftUI
//
//  Created by Devin Grischow on 3/8/24.
//

import Foundation


struct CalendarModel{
    
    //No Year offset needed, Calendar API adjusts years based off Month
    
    var monthOffset:Int = 0
    
    
    var daysInSelectedMonth:[Int] = []
    
    
    var calendarWeeksBody:[[Int]] = []
    
    
    //MARK: Calendar geometry reader sizes
    var calendarFrameSize:CGSize = .zero
    
    
    
    
    
    
}
