//
//  FCalenderVM.swift
//  FancyCalendar
//
//  Created by Cihan Hasanoglu on 07.09.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import UIKit

struct FCalendarVM {
    
    var dateName: String = ""
    var selectedDate: String = ""
    let accessoryType: UITableViewCell.AccessoryType
    
    init(fcal: FCalendar) {
        for name in fcal.dateName {
            self.dateName = name
        }
//        self.dateName = fcal.dateName
        self.selectedDate = fcal.selectedDate
        accessoryType = .none
    }
}
