//
//  RandomQuoteController.swift
//  Immink-pset5
//
//  Created by Emma Immink on 20-05-16.
//  Copyright © 2016 Emma Immink. All rights reserved.
//

import UIKit

class RandomQuoteController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var myLabel: UILabel!
    var jsonQuotes: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DropDownList.dataSource = self
        DropDownList.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    
    let pickerData = ["Random","Bronn", "Brynden Tully", "Cersei", "The Hound", "Jaime Lannister", "Littlefinger", "Olena Tyrell", "Renly Baratheon", "Tyrion", "Varys"]

    @IBOutlet weak var DropDownList: UIPickerView!
    
    @IBAction func IfQuoteButtonClicked(sender: AnyObject) {
        performQuoteRequest()
    }
    
    @IBAction func IfBackButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("backButton", sender: self)
    }
    
    func performQuoteRequest() {
        // https://got-quotes.herokuapp.com/quotes
        // https://got-quotes.herokuapp.com/quotes?char=tyrion
        // https://got-quotes.herokuapp.com/quotes?char=Renly+Baratheon
        
        let webUrlQuotes = "https://got-quotes.herokuapp.com/quotes?char=" + TodoManager.sharedInstance.quoteCharacter
        
        let urlQuotes = NSURL(string: webUrlQuotes)
        
        let sessionQuotes = NSURLSession.sharedSession()
        
        sessionQuotes.dataTaskWithURL(urlQuotes!, completionHandler: { data, response, error in
            
            let responseStatusCodeQuotes = (response as! NSHTTPURLResponse).statusCode
            print(responseStatusCodeQuotes)
            // do error handling
            
            
            do {
                let jsonQuotes = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                TodoManager.sharedInstance.jsonQuotes = jsonQuotes
                print(jsonQuotes)
                print(TodoManager.sharedInstance.jsonQuotes)
                
                self.performSelectorOnMainThread("gotoRandomQuotes:", withObject: jsonQuotes, waitUntilDone: true)
            } catch {
                print(error)
                //error struct and enum
            }
        }).resume()
        
    }
    
    
    func gotoRandomQuotes(json: NSDictionary) {
        self.performSegueWithIdentifier("quoteDetails", sender: self.jsonQuotes)
   }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "quoteDetails"){
            let quoteDetailsVC = segue.destinationViewController as! RandomQuoteShowController
            quoteDetailsVC.quoteDetails = sender as? NSDictionary
        }
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerData[row] == "Random"){
            myLabel.text = "Get quote from random character"
            TodoManager.sharedInstance.quoteCharacter = ""
        }
        else{
            myLabel.text = "Get quote from " + pickerData[row]
            TodoManager.sharedInstance.quoteCharacter = pickerData[row].stringByReplacingOccurrencesOfString(" ", withString: "+")
        }
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
