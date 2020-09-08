//
//  FCalendarView.swift
//  FancyCalendar
//
//  Created by Cihan Hasanoglu on 07.09.20.
//  Copyright © 2020 Cihan Hasanoglu. All rights reserved.
//

import UIKit
import FSCalendar

/*
 FCalendarView is a reusable Calendar class which is implementing a calendar using the Framework FSCalendar
 and customizing the view according to the requirements.
 */
class FCalendarController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    var calViewModels = [FCalendarVM]()
    let cellId = "cellId"
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    var formatter = DateFormatter()
    
    var selectedDate: String = ""
    var dueDate: String = "09/21/2020"
    
    
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var calTableView: UITableView!
    
    private var currPage: Date?
    
    private lazy var today: Date = {
        return Date()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
        setupTableView()
    }
    
    //setting up FSCalendar
    fileprivate func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.bringSubviewToFront(prevButton)
        calendar.bringSubviewToFront(nextButton)
    }
    
    // custom chevron button to go one month back
    @IBAction func previousButton(_ sender: Any) {
        self.customPageMover(moveNext: false)
    }
    
    // custom chevron button to go to the next month
    @IBAction func nextButton(_ sender: Any) {
        self.customPageMover(moveNext: true)
    }
    
    // below is the logic to detect and perform the move of pages for next and previous months
    private func customPageMover(moveNext: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveNext ? 1 : -1
        
        self.currPage = cal.date(byAdding: dateComponents, to: self.currPage ?? self.today)
        self.calendar.setCurrentPage(self.currPage!, animated: true)
    }
    
    //setting up TableView below the calendar
    fileprivate func setupTableView() {
         calTableView.register(DateCell.self, forCellReuseIdentifier: cellId)
         calTableView.delegate = self
         calTableView.dataSource = self
        self.calViewModels = 
         view.addSubview(calTableView)
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DateCell
//        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: cellId)
        let calViewModel = calViewModels[indexPath.row]
        cell.fcalVM = calViewModel
//        cell.textLabel?.numberOfLines = 2
//        cell.textLabel?.text = calViewModels
//        cell.detailTextLabel?.text = selectedDate
        return cell
    }
    
    //changing the color of the dueDate on the calendar
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        guard let selectDueDate = dateFormatter.date(from: dueDate) else { return nil}
        if date.compare(selectDueDate) == .orderedSame {
            return UIColor(red: 239, green: 197, blue: 93)
        }
        return nil
    }

    //changing the appearence of the title of duedate on the calendar for better fit
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        guard let selectDueDate = dateFormatter.date(from: dueDate) else { return nil}
        if date.compare(selectDueDate) == .orderedSame {
            return UIColor.white
        }
        return nil
    }
    
    //selecting the dueDate and formatting the date
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        formatter.dateFormat = "MM/dd/yyyy"
        guard let excludedDate = formatter.date(from: dueDate) else {return true}
        if date.compare(excludedDate) == .orderedSame {
            return true
        }
        return true
    }

    // changing the selection color according to the selection before dueDate or after and also if dueDate itself is selected
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if date < dateFormatter.date(from: dueDate)! {
            calendar.appearance.selectionColor = UIColor(red: 76, green: 134, blue: 187)
        } else if date == dateFormatter.date(from: dueDate) {
            calendar.appearance.selectionColor = UIColor(red: 239, green: 197, blue: 93)
        } else {
            calendar.appearance.selectionColor = UIColor.lightGray
        }
        selectedDate = dateFormatter.string(from: date)
        calTableView.reloadData()
    }
}

// extension to UIColor to use and reuse the RGB settings for UIColor easier and faster
extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
