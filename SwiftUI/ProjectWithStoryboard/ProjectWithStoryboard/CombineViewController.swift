//
//  CombineViewController.swift
//  ProjectWithStoryboard
//
//  Created by Ace Authors on 26/10/20.
//

import UIKit
import Combine

class CombineViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let eventCombine = EventCombineService()
    
    var course: Course?
    
    var cancellable: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cancellable = eventCombine.fetchData()
            .receive(on: RunLoop.main)
            .sink { (error) in
                print("Done fetch. Error: \(error)")
                self.tableView.reloadData()
            } receiveValue: { (course) in
                let sortedEvents = course.events.sorted { $0.datetime < $1.datetime }
                self.course = Course(events: sortedEvents)
            }
    }
    
}

extension CombineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let course = course {
            return course.events.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "TableCell") as UITableViewCell?)!
        
        // set the text from the data model
        if let course = course {
            cell.textLabel?.text = SimpleEventModelView(for: course.events[indexPath.row]).eventText
        }
        
        return cell
    }
}
