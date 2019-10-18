//
//  CalorieTrackerTableViewController.swift
//  CalorieTracker
//
//  Created by Alex Rhodes on 10/17/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit
import SwiftChart

class CalorieTrackerTableViewController: UITableViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var AddBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var chartView: UIView!
    
    // MARK: Properties
    
    let series = [Double]()
    
    var chart = Chart() {
        didSet {
            setViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        
    }
    
    // MARK: IBActions
    @IBAction func addEntryButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    
    // MARK: Private Methods
    
    private func setViews() {
        let rect = CGRect(x: 0, y: 0, width: 414, height: 400)
        
        chart.frame = rect
        chartView.addSubview(chart)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEntry" {
            guard let destinationVC = segue.destination as? AddEntryViewController else {return}
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



