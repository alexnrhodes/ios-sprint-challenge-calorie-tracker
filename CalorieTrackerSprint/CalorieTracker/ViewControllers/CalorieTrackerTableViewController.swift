//
//  CalorieTrackerTableViewController.swift
//  CalorieTracker
//
//  Created by Alex Rhodes on 10/17/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import SwiftChart
import CoreData

class CalorieTrackerTableViewController: UITableViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var AddBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var chartView: UIView!
    
    // MARK: Properties
    
    var series = [Double]()
    
    let entryControlller = EntryController()
    
    var chart = Chart() {
        didSet {
            setViews()
        }
    }
    
    lazy var fetch: NSFetchedResultsController<Entry> = {
        
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        // basically sorts everything
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: "date", cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        
        return frc
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
    }
    // MARK: Private Methods
    
    private func setViews() {
        
        
        
        let mapResult = fetch.fetchedObjects.map { (value) in
            value.map { (entry) in
                entry.calories
            }
        }
        
        if let seriesValues = mapResult {
            series = seriesValues
        }
        
        chart.add(ChartSeries(series))

        
        let rect = CGRect(x: 0, y: 0, width: 414, height: 275)
        chart.frame = rect
        chartView.addSubview(chart)
        
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetch.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetch.sections?[section].numberOfObjects ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        
        let entry = fetch.object(at: indexPath)
        cell.textLabel?.text = String(entry.calories)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.timeZone = .current
        let date = dateFormatter.string(from: entry.date!)
        cell.detailTextLabel?.text = date
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = fetch.object(at: indexPath)
            entryControlller.delete(entry: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEntry" {
            guard let destinationVC = segue.destination as? AddEntryViewController else {return}
            destinationVC.entryController = entryControlller
            let ppc = destinationVC.popoverPresentationController
            if let button = sender as? UIButton {
                ppc?.sourceView = button
                ppc?.sourceRect = button.bounds
                ppc?.backgroundColor = .black
            }
            ppc?.delegate = self as? UIPopoverPresentationControllerDelegate
        }
    }
}

extension CalorieTrackerTableViewController: NSFetchedResultsControllerDelegate {
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let newIndexPath = newIndexPath,
                let indexPath = indexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let set = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(set, with: .automatic)
        case .delete:
            tableView.deleteSections(set, with: .automatic)
        default:
            return
        }
    }
    
}



