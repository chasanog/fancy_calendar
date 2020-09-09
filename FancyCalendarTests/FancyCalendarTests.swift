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
    let calendarData = CalendarData(dueDate: "09/12/2020", selectedDate: "09/22/2020", selectedDateNameLabel: "Test Selected Date", dueDateNameLabel: "Test Due Date")
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //testing ViewModel attributes against the Model
    func testCalendarViewModel() {
        
        let calViewModel = FCalendarVM(calData: calendarData)
        
        XCTAssertEqual(calendarData.dueDateNameLabel, calViewModel.calData.dueDateNameLabel)
        XCTAssertEqual(calendarData.dueDate, calViewModel.calData.dueDate)
        XCTAssertEqual(calendarData.selectedDateNameLabel, calViewModel.calData.selectedDateNameLabel)
        XCTAssertEqual(calendarData.selectedDate, calViewModel.calData.selectedDate)
    }
    
    //testing wrong data with data in View Model
    func testViewModelFailure() {
        let calViewModel = FCalendarVM(calData: calendarData)
        
        XCTAssertNotEqual(calViewModel.calData.dueDate, "22/02/2020")
    }

}
