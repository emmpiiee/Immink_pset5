//
//  RandomQuoteShowController.swift
//  Immink-pset5
//
//  Created by Emma Immink on 20-05-16.
//  Copyright © 2016 Emma Immink. All rights reserved.
//

import UIKit

class RandomQuoteShowController: UIViewController {

    var quoteDetails: NSDictionary?
    var quoteDetails2: NSDictionary? = TodoManager.sharedInstance.jsonQuotes
    
  
    @IBOutlet weak var showQuote: UITextView!
    @IBOutlet weak var showCharacter: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (quoteDetails2 != nil) {
            showQuote.text = quoteDetails2!["quote"] as? String
            showCharacter.text = quoteDetails2!["character"] as? String
        }
        // set outlets
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromUrl(url: NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)){
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
        }.resume()
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
