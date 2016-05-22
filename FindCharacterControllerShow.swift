//
//  FindCharacterControllerShow.swift
//  Immink-pset5
//
//  Created by Emma Immink on 21-05-16.
//  Copyright © 2016 Emma Immink. All rights reserved.
//

import UIKit

class FindCharacterControllerShow: UIViewController {

    var characterDetails: NSDictionary?
    var characterDetails2: NSDictionary? = TodoManager.sharedInstance.jsonCharacterInfo
    
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showCulture: UILabel!
    @IBOutlet weak var showBorn: UILabel!
    @IBOutlet weak var showAliases: UILabel!
    @IBOutlet weak var showPlayedBy: UILabel!
    
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (characterDetails2 != nil) {
            showName.text = "Name: \((characterDetails2!["name"] as? String)!)"
            showCulture.text = "Culture: \((characterDetails2!["culture"] as? String)!)"
            showBorn.text = "Born in: \((characterDetails2!["born"] as? String)!)"
            showAliases.text = "Aliases: \((characterDetails2!["aliases"]![0] as? String)!)"
            showPlayedBy.text = "Actor: \((characterDetails2!["playedBy"]![0] as? String)!)"   
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // AIzaSyASSQKmOwpN9KpbpGmdD1il8kkF2yN9HZE

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
