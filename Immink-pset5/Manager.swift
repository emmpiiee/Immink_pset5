//
//  Manager.swift
//  Immink-pset5
//
//  Created by Emma Immink on 21-05-16.
//  Copyright © 2016 Emma Immink. All rights reserved.
//

import Foundation


class TodoManager {
    static let sharedInstance = TodoManager()
    
    // make sure no one can initialize TodoManager
    private init() {}
    
    var quoteCharacter =  String()
    var infoCharacter = String ()
    var episodeString = String ()
    var seasonString = String ()

    var jsonQuotes = NSDictionary()
    var jsonCharacterInfo = NSDictionary()
    var jsonEpisodeInfo = NSDictionary()
}





