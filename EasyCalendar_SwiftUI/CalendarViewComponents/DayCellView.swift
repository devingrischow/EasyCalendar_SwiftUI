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
    @EnvironmentObject var calendarVM:CalendarViewModel

    ///This is the day number for the Cell
    var dayNumber:Int
    
    var body: some View {
        // *Ensure the number is a positive number, a actual calandar value
        
            
            
        if  dayNumber == 25{
            
            Text("\(dayNumber)")
            
                .multilineTextAlignment(.center)
                .frame(width: calendarVM.getCalendarFrameSize().width / 11)
                .padding([.top, .bottom], 5)

                .foregroundStyle(.white)
                .background(.red)
                .cornerRadius(3)
            
        }else if dayNumber > 0 {
            
            Text("\(dayNumber)")
                .frame(width: calendarVM.getCalendarFrameSize().width / 11)
            
        }else{
            //Handle all non calendar values and just put hidden text there
            Text("\(dayNumber)")
                .frame(width: calendarVM.getCalendarFrameSize().width / 11)
            //Set foreground to white to make invisible
                .foregroundStyle(.white)
        }
        
        
    }
}

