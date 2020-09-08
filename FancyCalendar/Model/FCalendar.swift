//
//  FCalendar.swift
//  FancyCalendar
//
//  Created by Cihan Hasanoglu on 07.09.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import Foundation

struct FCalendar: Decodable {
    
    let dateName: [String] = ["Due Date", "Selected Date"]
    let selectedDate: String
}
