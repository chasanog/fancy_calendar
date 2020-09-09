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
class FCalendarController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    //mapping label text with Model attributes using viewModel
    var calViewModels: FCalendarVM! {
        didSet {
            dueDateNameLabel.text = calViewModels.dueDateNameLabel
            dueDateLabel.text = calViewModels.dueDate
            
            selectedDateNameLabel.text = calViewModels.selectedDateNameLabel
            selectedDateLabel.text = calViewModels.selectedDate
            
        }
    }
    
    //simple date formatter
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
    
    // for haptic feedbacks when tap action happens
    let impact = UIImpactFeedbackGenerator()
    
    var selectedDate: String = ""
    var dueDate: String = "09/21/2020"
    
    
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectedDateNameLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var dueDateNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    
    private var currPage: Date?
    
    private lazy var today: Date = {
        return Date()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let calData = CalendarData(dueDate: dueDate, selectedDate: selectedDate)
        calViewModels = FCalendarVM(calData: calData)
        setupCalendar()
        setupLabels()
        labelTapAction(label: selectedDateLabel)
        labelTapAction(label: dueDateLabel)
    }
    
    //setting up FSCalendar and the view
    fileprivate func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.bringSubviewToFront(prevButton)
        calendar.bringSubviewToFront(nextButton)
    }
    
    //setting up the Labesl below the calendar
    fileprivate func setupLabels() {
        selectedDateNameLabel.textColor = UIColor.gray
        dueDateNameLabel.textColor = UIColor.gray
        selectedDateLabel.textColor = UIColor.blue
        dueDateLabel.textColor = UIColor.blue
        selectedDateLabel.attributedText = NSAttributedString(string: "Text", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        dueDateLabel.attributedText = NSAttributedString(string: dueDate, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        updateLabels()
    }
    
    //handles the jump to the selected date below the calendar for selected and due date
    @objc func tapAction(tapGesture: TapGestureHelper) {
        if tapGesture.label == selectedDateLabel {
            calendar.deselect(dateFormatter.date(from: selectedDate)!)
            calendar.select(dateFormatter.date(from: selectedDate))
            self.currPage = dateFormatter.date(from: selectedDate)
        } else if tapGesture.label == dueDateLabel {
            if calendar.selectedDate == dateFormatter.date(from: dueDate) {
                calendar.deselect(dateFormatter.date(from: dueDate)!)
            }
            calendar.select(dateFormatter.date(from: dueDate))
            self.currPage = dateFormatter.date(from: dueDate)
            selectedDate = dueDate
            updateLabels()
        }
        impact.impactOccurred()
        
    }
    
    //handles the tap on a label which can be given as a parameter @label
    func labelTapAction(label: UILabel) {
        let gestureRecognizer = TapGestureHelper.init(target: self, action: #selector(tapAction))
        gestureRecognizer.label = label
        gestureRecognizer.label.isUserInteractionEnabled = true
        gestureRecognizer.label.addGestureRecognizer(gestureRecognizer)
    }
    
    //updating the Label Selected Date
    func updateLabels() {
        if selectedDate == "" {
            selectedDateLabel.text = " "
        } else {
            selectedDateLabel.text = selectedDate
        }
    }
    
    // custom chevron button to go one month back
    @IBAction func previousButton(_ sender: Any) {
        self.customPageMover(moveNext: false)
        impact.impactOccurred()
    }
    
    // custom chevron button to go to the next month
    @IBAction func nextButton(_ sender: Any) {
        self.customPageMover(moveNext: true)
        impact.impactOccurred()
    }
    
    // below is the logic to detect and perform the move of pages for next and previous months
    private func customPageMover(moveNext: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveNext ? 1 : -1
        self.currPage = cal.date(byAdding: dateComponents, to: self.currPage ?? self.today)
        self.calendar.setCurrentPage(self.currPage!, animated: true)
        impact.impactOccurred()
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
        guard let excludedDate = dateFormatter.date(from: dueDate) else {return true}
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
        impact.impactOccurred()
        selectedDate = dateFormatter.string(from: date)
        updateLabels()
    }
}

// extension to UIColor to use and reuse the RGB settings for UIColor easier and faster
extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
