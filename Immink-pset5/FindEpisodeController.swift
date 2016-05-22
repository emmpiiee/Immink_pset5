//
//  FindEpisodeController.swift
//  Immink-pset5
//
//  Created by Emma Immink on 20-05-16.
//  Copyright © 2016 Emma Immink. All rights reserved.
//

import UIKit

class FindEpisodeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var mySeason: UILabel!
    @IBOutlet weak var myEpisode: UILabel!
    
    @IBOutlet weak var dropDownListSeason: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownListSeason.dataSource = self
        dropDownListSeason.delegate = self

        // Do any additional setup after loading the view.
    }
    
    var pickerData = [
        ["1","2", "3", "4", "5", "6"],
        ["1","2", "3", "4", "5", "6", "7", "8", "9", "10"]
    ]
    var episode = ""
    var season = ""

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ifButtonClicked(sender: AnyObject) {
        performQuoteRequest()
    }
    
    @IBAction func ifBackButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("backButton", sender: self)
    }
    
    func performQuoteRequest() {
        // http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=1&Episode=3&Plot=full
        
        let webUrlQuotes = "https://www.omdbapi.com/?t=Game%20of%20Thrones&Season=\(TodoManager.sharedInstance.seasonString)&Episode=\(TodoManager.sharedInstance.episodeString)&Plot=full" + TodoManager.sharedInstance.quoteCharacter
        
        let urlQuotes = NSURL(string: webUrlQuotes)
        
        let sessionQuotes = NSURLSession.sharedSession()
        
        sessionQuotes.dataTaskWithURL(urlQuotes!, completionHandler: { data, response, error in
            
            let responseStatusCodeQuotes = (response as! NSHTTPURLResponse).statusCode
            print(responseStatusCodeQuotes)
            // do error handling
            
            
            do {
                let jsonEpisode = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                TodoManager.sharedInstance.jsonEpisodeInfo = jsonEpisode
                print(jsonEpisode)
                print(TodoManager.sharedInstance.jsonEpisodeInfo)
                
                self.performSelectorOnMainThread("gotoRandomQuotes:", withObject: jsonEpisode, waitUntilDone: true)
            } catch {
                print(error)
                //error struct and enum
            }
        }).resume()
        
    }
    
    
    func gotoRandomQuotes(json: NSDictionary) {
        self.performSegueWithIdentifier("showEpisode", sender: TodoManager.sharedInstance.jsonEpisodeInfo)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showEpisode"){
            let quoteDetailsVC = segue.destinationViewController as! FindEpisodeControllerShow
            quoteDetailsVC.quoteDetails = sender as? NSDictionary
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
        }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print (component)
        print(row)
        
        switch(component){
        case 0:
            season = pickerData[component][row]
            mySeason.text = "Season " + season
            TodoManager.sharedInstance.seasonString = season
            print(season)
        case 1:
            episode = pickerData[component][row]
            myEpisode.text = "Episode " + episode
            TodoManager.sharedInstance.episodeString = episode
            print(episode)
        default:break
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
