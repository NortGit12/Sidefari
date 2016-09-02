//
//  SearchItem.swift
//  Sidefari
//
//  Created by Jeff Norton on 9/2/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class SearchItem: Equatable {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    var url: String
    var timestamp: NSDate
    
    static let urlKey = "url"
    static let timestampKey = "timestamp"
    
    //==================================================
    // MARK: - Initializers
    //==================================================
    
    init(url: String) {
        
        self.url = url
        self.timestamp = NSDate()
    }
    
    init?(dictionaryCopy: Dictionary<String, AnyObject>) {
        
        guard let url = dictionaryCopy[SearchItem.urlKey] as? String
            , timestamp = dictionaryCopy[SearchItem.timestampKey] as? NSDate
            else { return nil }
        
        self.url = url
        self.timestamp = timestamp
    }
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        
        let dictionary = [
            SearchItem.urlKey: self.url
            , SearchItem.timestampKey: self.timestamp
        ]
        
        return dictionary
    }
}

func == (lhs: SearchItem, rhs: SearchItem) -> Bool {
    
    return lhs.url == rhs.url && lhs.timestamp == rhs.timestamp
}