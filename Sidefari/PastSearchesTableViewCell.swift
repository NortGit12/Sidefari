//
//  PastSearchesTableViewCell.swift
//  Sidefari
//
//  Created by Jeff Norton on 9/2/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class PastSearchesTableViewCell: UITableViewCell {

    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    func updateWithSearchItem(searchItem: SearchItem) {
        
        urlLabel.text = searchItem.url
        timestampLabel.text = "\(searchItem.timestampString)"
    }

}
