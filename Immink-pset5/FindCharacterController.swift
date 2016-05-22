//
//  FindCharacterController.swift
//  Immink-pset5
//
//  Created by Emma Immink on 20-05-16.
//  Copyright © 2016 Emma Immink. All rights reserved.
//

import UIKit

class FindCharacterController: UIViewController {

    var jsonCharacters: NSDictionary?
    
    @IBOutlet weak var moreInfoLabel: UILabel!
    @IBOutlet weak var characterName: UITextField!
    
    @IBAction func showInfoButton(sender: AnyObject) {
        performInfoRequest()
    }
    
    let warningMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func performInfoRequest(){
        //http://www.anapioficeandfire.com/api/characters?name=Jon+Snow
        //https://www.anapioficeandfire.com/api/characters?name=Jon+Snow
        
        
        let webUrlQuotes = "https://www.anapioficeandfire.com/api/characters?name=" + characterName.text!.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        let urlQuotes = NSURL(string: webUrlQuotes)
        
        let sessionQuotes = NSURLSession.sharedSession()
        
        sessionQuotes.dataTaskWithURL(urlQuotes!, completionHandler: { data, response, error in
            
            let responseStatusCodeQuotes = (response as! NSHTTPURLResponse).statusCode
            print(responseStatusCodeQuotes)
            // do error handling
            
            do {
                let jsonCharactersString = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray

                let count = jsonCharactersString.count
                
                if (count == 0 || self.characterName.text! == " "){
                    let warningMessage = "Use correct spelling"
                    return self.viewDidLoad()
                }
//                let count = jsonCharactersString.count
//                
//                if (count == 0) {
//                    return self.viewDidLoad()
//                }
//                
                TodoManager.sharedInstance.jsonCharacterInfo = jsonCharactersString[0] as! NSDictionary
                
                print("DICT", TodoManager.sharedInstance.jsonCharacterInfo["name"]!)
                
                self.performSelectorOnMainThread(#selector(FindCharacterController.goToCharacterInfo(_:)), withObject: self.jsonCharacters, waitUntilDone: false)
                
            } catch {
                
                print(error)
                //error struct and enum
            }
        }).resume()
        
    }

    func goToCharacterInfo(json: NSDictionary) {
        self.performSegueWithIdentifier("showDetails", sender: self.jsonCharacters)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showDetails"){
            let showDetailsVC = segue.destinationViewController as! FindCharacterControllerShow
            showDetailsVC.characterDetails = sender as? NSDictionary
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
