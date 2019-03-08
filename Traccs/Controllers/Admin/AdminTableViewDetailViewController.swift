//
//  AdminTableViewDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 3/4/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminTableViewDetailViewController: UIViewController {
    var update:(String , String)!
    
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var updateDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.updateLabel.text = update.0
        self.updateDescription.text = update.1
        
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
