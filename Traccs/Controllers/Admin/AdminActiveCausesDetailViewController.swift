//
//  AdminActiveCausesDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminActiveCausesDetailViewController: UIViewController {

    public var create: Create!
    var causes = DataPersistenceModel.get()
    var causeInfo: Create?
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        


        //self.detailImageView.image = image 
        self.detailLabel.text = causeInfo?.title
        self.detailTextView.text = causeInfo?.causeDescription
    }

    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
