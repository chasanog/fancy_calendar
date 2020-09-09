//
//  DateCell.swift
//  FancyCalendar
//
//  Created by Cihan Hasanoglu on 07.09.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import UIKit

/*
 Model to define the fields required for the Calendar according to the written Requirements
 */
class CalendarData {
    
    var dueDate: String
    var selectedDate: String
    var selectedDateNameLabel: String
    var dueDateNameLabel: String
    

    init(dueDate: String, selectedDate: String, selectedDateNameLabel: String, dueDateNameLabel: String) {
        self.dueDate = dueDate
        self.selectedDate = selectedDate
        self.selectedDateNameLabel = selectedDateNameLabel
        self.dueDateNameLabel = dueDateNameLabel
    }
}
