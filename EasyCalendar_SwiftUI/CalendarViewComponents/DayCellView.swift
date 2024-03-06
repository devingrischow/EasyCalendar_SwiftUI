//
//  DayPieceView.swift
//  EasyCalendar_SwiftUI
//
//  Created by Devin Grischow on 3/5/24.
//


//MARK: THIS IS THE VIEW THAT HOLDS THE DAY ITEM

//Default will hold just just the day, and its selection

//For Easy Eats, Its view will need to be custom more, to be able to change to a state to show there is data there. 

import SwiftUI

///This is a singular day component for the **EasyCalenderView**,And the Components that make it up
struct DayCellView: View {
    
    ///This is the day number for the Cell
    var dayNumber:Int
    
    var body: some View {
        
        
        Text("\(dayNumber)")
            
        
        
    }
}

