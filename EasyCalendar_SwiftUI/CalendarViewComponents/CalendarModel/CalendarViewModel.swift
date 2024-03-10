//
//  CalendarViewModel.swift
//  EasyCalendar_SwiftUI
//
//  Created by Devin Grischow on 3/8/24.
//

import Foundation




class CalendarViewModel:ObservableObject{
    
    
    //Published variable for the Calendar Model
    @Published var calendarModel:CalendarModel = CalendarModel()

    
    
    //MARK: Get the Months Days
    ///Get all the days in a month based off the current month *plus* the month Offset.
    func getMonthDays(){
        
        //Array to hold the days of the month to display
        var days:[Int] = []
        
        //Get the current month and year values
        let calendar = Calendar.current // Use the current calendar
        
        
       //call the first of the month Function and get the value to use for the getting the date
        
        
        
        let adjustedFirsdtDay = getFirstDayOfAdjustedMonthDate()
        
        //Get the range of days based on the desired adjusted month
        guard let range = calendar.range(of: .day, in: .month, for: adjustedFirsdtDay) else {
            return
        }
        
        
        
        //First clear all past days from the SelectedDaysArray
        calendarModel.daysInSelectedMonth = []
        
        
        //Loop through the range of days and add each day value to the Days array
        for day in range{
            
            //Add the DAY to days in selected month Model Array
            calendarModel.daysInSelectedMonth.append(day)
        }
        
        
        print("used Month, \(adjustedFirsdtDay.description)")
        print("Print Days In Month", calendarModel.daysInSelectedMonth)
        
        
        
        
        
        
        
        
        
        
    }
    //-+————Bottom Of Get Month Days—————+
    
    
    /// function that returns the current month and year as an Int
    /// Used to easily get the month and year, to be used to get the days
    func getCurrentMonthYear() -> [Int] {
        let currentDate = Date() // Get the current date
        let calendar = Calendar.current // Use the current calendar
        
        let month = calendar.component(.month, from: currentDate) // Extract the month component from the current date
        
        let year = calendar.component(.year, from: currentDate)
        
        return [month, year] // Return the month as an integer
    }
    //-+————Bottom Of get current Month+Year—————+
    
    
    
    
    
    
    //MARK: Get Month Str Value
    
    ///Get the month Label value for the current selected Calendar based off the Offset of the month value (if there is one)
    func getMonthLabel() -> String{
        
        let currentDate = Date() // Get the current date
        let calendar = Calendar.current
        
        
        //Get the Adjusted Month Value
        //Adjust the month and year values
        guard let adjustedDate = calendar.date(byAdding: .month, value: calendarModel.monthOffset, to: currentDate) else{
            return ""//No value was detected, so return a empty string
        }
        
                                
        //Create a date formatter to get the formatted date to return
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM" //Abriviate the month to be 3 letters
        
        return dateFormatter.string(from: adjustedDate)
        
        
        
    }
    
    func getYearLabel() -> String{
        
        let currentDate = Date() // Get the current date
        let calendar = Calendar.current
        
        
        //Get the Adjusted Month Value
        //Adjust the month and year values
        guard let adjustedDate = calendar.date(byAdding: .month, value: calendarModel.monthOffset, to: currentDate) else{
            return ""//No value was detected, so return a empty string
        }
        
                                
        //Create a date formatter to get the formatted date to return
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY" //Abriviate the month to be 3 letters
        
        return dateFormatter.string(from: adjustedDate)
        
        
        
    }
    //-+————Bottom Of Get month label + Year Label —————+
    
    
    
    
    
    //MARK: Increment Month value
    ///Increment the month value by 1
    ///Used to determine the position of the calendar and what the user is looking at.
    func incrementMonth(){
        calendarModel.monthOffset += 1
        
        //AS soon as the user presses the Increment value, Recalculate the Month Values
        getCalendarDaysArrays()
    }
    
    
    //MARK: Decrement Month Value
    ///Decrement the month value of the calendar by 1
    ///Used to determine the position of the calendar, and what the user is looking at. 
    func decrementMonth(){
        calendarModel.monthOffset -= 1
        
        //AS soon as the user presses the decrement value, Recalculate the Month Values
        getCalendarDaysArrays()
    }
    
    
    
    
    //Format the days array into a usable format for the calendar month body.
    
    
    //MARK: Get First Day Offset Month
    
    ///Get the first day of the current month, then add whatever the users add offset is
    ///Return that Date Object
    func getFirstDayOfAdjustedMonthDate() -> Date{
        
        
        //Get the current month and year values
        let calendar = Calendar.current // Use the current calendar
        
        
        let currMonthYear = getCurrentMonthYear()
        
        //Adjust the value of the year and months to get what the user selected
        
        //let adjustedMonth:Int = currMonthYear[0] + monthOffset
        //let adjustedYear:Int = currMonthYear[1] + yearOffset
        
        var toUseComponents = DateComponents(year: currMonthYear[1], month: currMonthYear[0])
        
        
        
        
        //set the day components to the first day of the month
        toUseComponents.day = 1
        
        // Attempt to create a Date from components (the start of the month)
        guard let firstDayOfMonth = calendar.date(from: toUseComponents) else {
            return .now // Return now if the date could not be created, indicating an error
        }
        
        
        
        //Adjust the month and year values
        guard let adjustedDate = calendar.date(byAdding: .month, value: calendarModel.monthOffset, to: firstDayOfMonth) else{
            return .now//No value was detected, so return now
        }
        
        
        return adjustedDate
        
    }
    
    
    
    
    
    //MARK: Format Days To Calendar Arrays.
    
    func getCalendarDaysArrays(){
        
        //Before Getting the calendar Days array, get the month days into the model FIRST
        getMonthDays()
        
        
        var calendarMonthWeeks:[[Int]] = []
        
        //Calendar of current timezone
        let calendar = Calendar.current
        
        //Start Looping through the Array of days
        var weekForMonthComponent:[Int] = []
        
        
        var weekDayComponentAddCount:Int = 0
        
        var dayIndex = 1
        
        while calendarMonthWeeks.count != 7{
//        for dayIndex in 1..<42{ //loop 42 times, AKA the length of the month
            
            print("dayinex, \(dayIndex)")
            
            //Check if the weekDay count is , if it is take the weekday components,
            //add them to the months array, then clear and reset the counter and array
            if weekDayComponentAddCount == 7{
                
                //First append the current weekday components
                calendarMonthWeeks.append(weekForMonthComponent)
                
                //then empty the array
                weekForMonthComponent = []
                
                //finally reset the counter
                weekDayComponentAddCount = 0
                
                
            }
            
            
            
            
            
            //The first week and last week are important

            
            
            //Get the weekDay of the first day
            if dayIndex == 1{
                //Get the first day of the month Date
                let firstDateOfMonth = getFirstDayOfAdjustedMonthDate()
                
                //get the weekday Digit Value
                
                //Make a DateComponent From the date
                
                let firstWeekdayDigit = calendar.component(.weekday, from: firstDateOfMonth)
                print("FIRST WEEKDAY IS: \(firstWeekdayDigit)\n")
                
                //Switch on the Days of the week, and add items accordingly depending on where they start for days of the week
                switch(firstWeekdayDigit){
                    
                case 1:
                    //SUNDAY, NO EXTRA ITEMS NEEDED, JUST ADD THE DAY TO THE ARRAY
                    //Just Append the FIRST DAY
                    weekForMonthComponent.append(dayIndex)
                    
                    
                    weekDayComponentAddCount = 1
                    
                    //if the array value is 1, the day is sunday, thus no subtraction needed
                    dayIndex += 1


                    
                case 2:
                    //MONDAY, ADD A 0 into the calendar for sunday, and set the count to 2 to the array for how many days skipped
                    //In the UI when the value is 0, it wont display anything.
                    weekForMonthComponent = [0, dayIndex]
                
                    weekDayComponentAddCount = 2
                    
//                    maxArrayValue -= 1 //one position moved, minus 1 from needed
                    dayIndex += 1


                    
                case 3:
                    
                    //TUESDAY, follow the pattern from above and add space for sun, mon, and this tuesday
                    weekForMonthComponent = [0,-1,dayIndex]
                    
                    weekDayComponentAddCount = 3
                    
//                    maxArrayValue -= 2
                    
                    dayIndex += 1

                    
                case 4:
                    //WED
                    weekForMonthComponent = [0,-1,-2,dayIndex]
                    
                    weekDayComponentAddCount = 4
                    
//                    maxArrayValue -= 3
                    dayIndex += 1


                    
                case 5:
                    //Thurs
                    weekForMonthComponent = [0,-1,-2,-3, dayIndex]
                    
                    weekDayComponentAddCount = 5
                    
//                    maxArrayValue -= 4
                    dayIndex += 1


                    
                case 6:
                    //FRI
                    weekForMonthComponent = [0,-1,-2,-3, -4, dayIndex]
                    
                    weekDayComponentAddCount = 6
                    
//                    maxArrayValue -= 5
                    

                    dayIndex += 1

                case 7:
                    //Sat
                    weekForMonthComponent = [0,-1,-2,-3, -4, -5, dayIndex]
                    
                    weekDayComponentAddCount = 7
                    
//                    maxArrayValue -= 6
                    dayIndex += 1
                    
                default:
                    print("how'd we get here?")
                }
                
            }else{
                
                
                
                
                
                
                //Check if the day index value is over the count of the array, if it is add the -value to the days array (so they can be handeld for empty month values.
                if dayIndex > calendarModel.daysInSelectedMonth.count{
                    //For when its over, append the -dayIndex value to the array
                    print("OVER DAY INDEX")
                    print("Count of days \(calendarModel.daysInSelectedMonth.count)")
                    weekForMonthComponent.append(-dayIndex)
                    
                    weekDayComponentAddCount += 1
                    
                    
                    dayIndex += 1
                    
                }else{
                    
                    
                    //Normal day, just add it to the array
                    
                    weekForMonthComponent.append(dayIndex)
                    
                    weekDayComponentAddCount += 1
                    
                    dayIndex += 1
                    
                }

                
                
                
                
                
                
            }
            
            //Bottom of the If Block
            
           
            
            
            
            
            
            
        }
        //-+————Bottom Of For Loop—————+
        
        
        
        //set the Calendar Body Arrat
        calendarModel.calendarWeeksBody = calendarMonthWeeks
    }
    
    
    
    
    //get the calandar body weeks from the model
    func getCalandarWeeksBody() -> [[Int]]{
        return calendarModel.calendarWeeksBody
    }
    
    
    
    
    
    
    
    
    
    
    
}
