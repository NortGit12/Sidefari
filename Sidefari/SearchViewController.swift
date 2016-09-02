//
//  SearchViewController.swift
//  Sidefari
//
//  Created by Jeff Norton on 9/2/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var pastSearchesTableView: UITableView!
    
    //==================================================
    // MARK: - General
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        urlTextField.delegate = self
        urlTextField.becomeFirstResponder()
        
        pastSearchesTableView.rowHeight = UITableViewAutomaticDimension
        pastSearchesTableView.estimatedRowHeight = 50
    }
    
    //==================================================
    // MARK: - UITableViewDataSource
    //==================================================
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SearchModelController.sharedController.searches.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("pastSearchCell", forIndexPath: indexPath) as? PastSearchesTableViewCell else { return UITableViewCell() }
        
        let searchItem = SearchModelController.sharedController.searches[indexPath.row]
        
        cell.updateWithSearchItem(searchItem)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            let searchItem = SearchModelController.sharedController.searches[indexPath.row]
            
            SearchModelController.sharedController.deleteSearchItem(searchItem)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //==================================================
    // MARK: - TextFieldDelegate
    //==================================================
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let urlText = textField.text where urlText.characters.count > 0 {
            
            SearchModelController.sharedController.addSearchItem(urlText)
            self.urlTextField.text = ""
            
            self.pastSearchesTableView.reloadData()
            
            return true
        } else {
        
            return false
        }
    }
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
    @IBAction func pasteUrlButtonTapped(sender: UIButton) {
        
        let generalPasteboard: UIPasteboard = UIPasteboard.generalPasteboard()
        
        guard let pasteText = generalPasteboard.string else { return }
        urlTextField.text = pasteText
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
