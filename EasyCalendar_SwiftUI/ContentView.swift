//
//  ContentView.swift
//  EasyCalendar_SwiftUI
//
//  Created by Devin Grischow on 3/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{ geometry in
            
            VStack{
                Spacer()
                
                
                Text("Plain Text")
                Text("Plain Text")
                
                Spacer()
                
                EasyCalendarView().frame(height: geometry.size.height / 2)
                
                Spacer()
                
                Text("Plain Text")
                
                
                Spacer()
                //Bottom Of Vstack
            }
         
            
            
            //Bottom Of Geometry Reader
        }
    }
}

#Preview {
    ContentView()
}
