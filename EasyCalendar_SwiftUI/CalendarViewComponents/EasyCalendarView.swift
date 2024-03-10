//
//  EasyCalendarView.swift
//  EasyCalendar_SwiftUI
//
//  Created by Devin Grischow on 3/5/24.
//

import SwiftUI

struct EasyCalendarView: View {
    
    //Initialize Calender View Controller
    
    
    //Initialize the Calendar Date Values
    @StateObject var calendarViewModel:CalendarViewModel = CalendarViewModel()
    
    @State private var calandarWeeksBody:[[Int]] =  [[29,30,31,32,33,34,35],[29,30,31,32,33,34,35],[29,30,31,32,33,34,35],[29,30,31,32,33,34,35],[29,30,31,32,33,34,35],[29,30,31,32,33,34,35]] //Initialize with dummy numbers
    
    
    @State private var monthYearLabel:[Int] = []
    
    var body: some View {
        
        
        VStack{
            
            
            //Weekday Names To Declare
            MonthLabelAndChanger().environmentObject(calendarViewModel)
                .padding(.bottom, 38)
            
            
            Group{
                WeekdayNamesRow().environmentObject(calendarViewModel)
                    .padding(.bottom, 5)
                
                //Calendar weekday views values
                CalenderFullBodyView(week1Row: calandarWeeksBody[0], week2Row: calandarWeeksBody[1], week3Row: calandarWeeksBody[2], week4Row: calandarWeeksBody[3], week5Row: calandarWeeksBody[4], week6Row: calandarWeeksBody[5]).environmentObject(calendarViewModel)
                
                //Bottom Of Vstack
            }
            .padding([.leading,.trailing], 16)
            
            
            
            
        }
        .onAppear{
            //On view appear, call the getMonthDay function to get the day values to populate the calendar
            calendarViewModel.getCalendarDaysArrays()
            
            calandarWeeksBody = calendarViewModel.getCalandarWeeksBody()
            
            
        }
        
        .onChange(of: calendarViewModel.calendarModel.monthOffset){ offset in
            calandarWeeksBody = calendarViewModel.getCalandarWeeksBody()
            print(calendarViewModel.getCalandarWeeksBody())

        }
        
        
        //Bottom of Vstacl
        
        
        
        
    }
    
    
    
    
    
    
    
}


#Preview {
    EasyCalendarView()
    
    
}


///This view houses the current MONTH label
///It also contains the arrow buttons to allow the user to go to and from month values
struct MonthLabelAndChanger:View {
    
    @EnvironmentObject var calendarVM:CalendarViewModel
    
    var body: some View {
        
        HStack{
            
            HStack{
                Button(){
                    print("Decrement")
                    calendarVM.decrementMonth()
                    
                    
                }label: {
                    
                    Image(systemName: "chevron.left")
                        .resizable()
                    
                        .fontWeight(.semibold)
                    
                        .frame(width: 22, height: 40)
                    
                        .padding(.leading, 16)
                }
                
                //Month + Year Label
                HStack{
                    
                        Text("\(calendarVM.getMonthLabel()),")
                            .frame(height: 22)
                            .font(.system(size: 20))

                     
                        
                        Text("\(calendarVM.getYearLabel())")
                        .font(.system(size: 17))
                        .frame(height: 22, alignment:.bottom)
                    

                }
                .padding([.trailing, .leading], 54)
                
                
                
                
                Button(){
                    print("Increment")
                    
                    calendarVM.incrementMonth()
                }label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .fontWeight(.semibold)
                    
                        .frame(width: 22, height: 40)
                }
                
                
                
            }
            
            Spacer()
            
            
            //Bottom of HStack
        }
        
    }
    
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
    var week6Row:[Int]
    
    ///This is the combined array of the week rows that make up the **Full Body  View**, takes 5 of the week arrows.
    var combinedWeeks:[[Int]]
    
    //This is the Initializer for the Full Body View
    init(week1Row: [Int], week2Row: [Int], week3Row: [Int], week4Row: [Int], week5Row: [Int], week6Row: [Int]) {
        self.week1Row = week1Row
        self.week2Row = week2Row
        self.week3Row = week3Row
        self.week4Row = week4Row
        self.week5Row = week5Row
        self.week6Row = week5Row
        
        combinedWeeks = [week1Row, week2Row, week3Row, week4Row, week5Row, week6Row]
        
        
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



