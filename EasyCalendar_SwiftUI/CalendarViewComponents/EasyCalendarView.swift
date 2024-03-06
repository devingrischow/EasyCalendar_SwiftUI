//
//  EasyCalendarView.swift
//  EasyCalendar_SwiftUI
//
//  Created by Devin Grischow on 3/5/24.
//

import SwiftUI

struct EasyCalendarView: View {
    
    //Initialize Calender View Controller
    
    
    var body: some View {
        
        
        VStack{
            
            
            //Weekday Names To Declare
            Group{
                WeekdayNamesRow()
                    .padding(.bottom, 5)
                
                //Calendar weekday views values
                CalenderFullBodyView(week1Row: [1,2,3,4,5,6,7], week2Row: [1,2,3,4,5,6,7], week3Row: [1,2,3,4,5,6,7], week4Row: [1,2,3,4,5,6,7], week5Row: [1,2,3,4,5,6,7])
                
                //Bottom Of Vstack
            }
            .padding([.leading,.trailing], 16)

            
        }
        //Frame off the Sides
        
        
        
        
    }
}


#Preview {
    EasyCalendarView()
    
    
}


///This view is the view that places the weekday names onto the calendar.
struct WeekdayNamesRow: View {
    
    var weekDaysArray:[String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        HStack{
            
            
            Group{
                ForEach(weekDaysArray, id: \.self) { weekday in
                    
                    Spacer()
                    
                    Text(weekday)
                        .frame(width: 32)
                    
                    Spacer()
                        
                }
            }
            .lineLimit(1)
            .font(.system(size: 13))

            //.frame(width: 32, height: 18)
            
            
            
        }
        
        
    }
}









//MARK: Calder Full Body View
///This is the full calendar view for the Calendar Body. \
///
///This is for the Ability to be swapped with a reduced view to see only the  current weeks values
struct CalenderFullBodyView: View {
    
    var week1Row:[Int]
    var week2Row:[Int]
    var week3Row:[Int]
    var week4Row:[Int]
    var week5Row:[Int]
    
    ///This is the combined array of the week rows that make up the **Full Body  View**, takes 5 of the week arrows.
    var combinedWeeks:[[Int]]
    
    //This is the Initializer for the Full Body View
    init(week1Row: [Int], week2Row: [Int], week3Row: [Int], week4Row: [Int], week5Row: [Int]) {
        self.week1Row = week1Row
        self.week2Row = week2Row
        self.week3Row = week3Row
        self.week4Row = week4Row
        self.week5Row = week5Row
        
        combinedWeeks = [week1Row, week2Row, week3Row, week4Row, week5Row]
        
        
    }
    
    var body: some View {
        //VStack to hold the Week Rows
        VStack{
            
            Group{
                
                ForEach(combinedWeeks, id:\.self){ weekRow in
                                        
                    WeekRowView(dayRows: weekRow)
                    
                    
                }
                
            }
            //Padding from the bottom of each **ROW**
            .padding(.bottom, 6)
            
            //Bottom Of Vstack
        }
        
        //Side To Side Padding
    }
}




//-+————---------------------------—————+



//MARK: Row Component
///This is a singular week Component for the View
///View takes a array of the days that should be put it, **rowDays**
struct WeekRowView: View {
    
    var dayRows:[Int]
    
    var body: some View {
        
        
        HStack{
            
            
            Group{
                
                ForEach(dayRows, id: \.self){ index in
                    
                    Spacer()
                    
                    DayCellView(dayNumber: index)
                        .frame(width: 30)
                    Spacer()
                    
                }
            }
            .lineLimit(1)
            .font(.system(size: 20).weight(.semibold))
//            .frame(width: 40, height: 40)
                
                //Bottom Of Hstack
            
            
        }
        
    }
}



