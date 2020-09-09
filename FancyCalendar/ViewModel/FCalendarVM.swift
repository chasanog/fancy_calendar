//
//  FCalenderVM.swift
//  FancyCalendar
//
//  Created by Cihan Hasanoglu on 07.09.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import UIKit

/*
 ViewModel for the calendar Model
 */
struct FCalendarVM {
    
    let calData: CalendarData
    
    init(calData: CalendarData) {
        self.calData = calData
    }
}
