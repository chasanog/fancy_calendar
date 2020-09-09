//
//  FancyCalendarTests.swift
//  FancyCalendarTests
//
//  Created by Cihan Hasanoglu on 07.09.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import XCTest
@testable import FancyCalendar

class FancyCalendarTests: XCTestCase {
    let calendarData = CalendarData(dueDate: "09/12/2020", selectedDate: "09/22/2020")
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //testing ViewModel attributes against the Model
    func testCalendarViewModel() {
        
        let calViewModel = FCalendarVM(calData: calendarData)
        
//        XCTAssertEqual(calendarData.dueDateNameLabel, calViewModel.dueDateNameLabel)
        XCTAssertEqual(calendarData.dueDate, calViewModel.dueDate)
//        XCTAssertEqual(calendarData.selectedDateNameLabel, calViewModel.selectedDateNameLabel)
        XCTAssertEqual(calendarData.selectedDate, calViewModel.selectedDate)
    }
    
    //testing wrong data with data in View Model
    func testViewModelFailure() {
        var calViewModel = FCalendarVM(calData: calendarData)
//        calViewModel.selectedDate = "08/20/2020"
//        calendarData.selectedDate = "09/10/2020"
        calViewModel.selectedDate = "02/22/2020"
        
        XCTAssertNotEqual(calViewModel.dueDate, "22/02/2020")
        XCTAssertNotEqual(calendarData.selectedDate, calViewModel.selectedDate)
    }

}
