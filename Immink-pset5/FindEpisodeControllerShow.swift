//
//  FindEpisodeControllerShow.swift
//  Immink-pset5
//
//  Created by Emma Immink on 21-05-16.
//  Copyright © 2016 Emma Immink. All rights reserved.
//

import UIKit

class FindEpisodeControllerShow: UIViewController {

    var quoteDetails: NSDictionary?
    var quoteDetails2: NSDictionary? = TodoManager.sharedInstance.jsonEpisodeInfo
    
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showPlot: UITextView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (quoteDetails2 != nil) {
            
            var posterUrl: String = quoteDetails2!["Poster"] as! String
            posterUrl.insert("s", atIndex: posterUrl.startIndex.advancedBy(4))
            
            // set movie psoter
            if let checkedUrl = NSURL(string: posterUrl){
                downloadImage(checkedUrl)
            }
            
            showTitle.text = quoteDetails2!["Title"] as? String
            showPlot.text = quoteDetails2!["Plot"] as? String
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func downloadImage(url: NSURL){
        getDataFromUrl(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else {return}
                self.moviePoster.image = UIImage(data: data)
            }
        }
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
