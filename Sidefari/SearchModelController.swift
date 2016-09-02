//
//  SearchModelController.swift
//  Sidefari
//
//  Created by Jeff Norton on 9/2/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class SearchModelController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    static let sharedController = SearchModelController()
    var searches: [SearchItem]
    private let persistenceKey = "SideFariDict"
    
    //==================================================
    // MARK: - Initializer
    //==================================================
    
    init() {
        
        searches = [SearchItem]()
        
        loadFromPersistentStore()
    }
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    func addSearchItem(url: String) {
        
        if url.characters.count > 0 {
            
            let newSearchItem = SearchItem(url: url)
            searches.insert(newSearchItem, atIndex: 0)
            
            saveToPersistentStore()
        }
    }
    
    func deleteSearchItem(searchItem: SearchItem) {
        
        if let searchItemIndex = searches.indexOf(searchItem) {
            
            searches.removeAtIndex(searchItemIndex)
            
            saveToPersistentStore()
        }
    }
    
    //==================================================
    // MARK: - Persistence
    //==================================================
    
    func saveToPersistentStore() {
     
        let searchItemDictionaries = self.searches.map({ $0.dictionaryCopy() })
        
        NSUserDefaults.standardUserDefaults().setObject(searchItemDictionaries, forKey: persistenceKey)
    }
    
    func loadFromPersistentStore() {
        
        let searchItemDictionariesFromDefaults = NSUserDefaults.standardUserDefaults().objectForKey(persistenceKey) as? [Dictionary<String, AnyObject>]
        
        if let searchItemDictionaries = searchItemDictionariesFromDefaults {
            
            self.searches = searchItemDictionaries.map({ SearchItem(dictionaryCopy: $0)! })
        }
    }
}