//
//  AdminTableViewDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 3/4/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminTableViewDetailViewController: UIViewController {
    var update: Update!
    
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var updateDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.updateLabel.text = update.updatesTitle
        self.updateDescription.text = update.updates
        
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
