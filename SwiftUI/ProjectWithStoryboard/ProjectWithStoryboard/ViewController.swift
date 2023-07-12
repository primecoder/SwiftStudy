//
//  ViewController.swift
//  ProjectWithStoryboard
//
//  Created by Ace Authors on 26/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let eventService = EventService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        eventService.delegate = self
    }


}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventService.course.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "TableCell") as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = SimpleEventModelView(for: eventService.course.events[indexPath.row]).eventText
        
        return cell
    }
}

extension ViewController: EventServerDelegate {
    func eventsDidLoad() {
        print("Update screen now")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

