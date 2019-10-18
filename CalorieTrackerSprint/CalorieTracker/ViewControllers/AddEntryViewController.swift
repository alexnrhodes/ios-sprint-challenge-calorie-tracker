//
//  AddEntryViewController.swift
//  CalorieTracker
//
//  Created by Alex Rhodes on 10/18/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController {

    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
    }
    
    

}
