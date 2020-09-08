//
//  DateCell.swift
//  FancyCalendar
//
//  Created by Cihan Hasanoglu on 07.09.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    var fcalVM: FCalendarVM! {
        didSet {
            textLabel?.text = fcalVM.dateName
            detailTextLabel?.text = fcalVM.selectedDate
            accessoryType = fcalVM.accessoryType
        }
    }
    
    
    
}
