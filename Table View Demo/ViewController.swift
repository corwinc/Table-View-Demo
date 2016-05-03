//
//  ViewController.swift
//  Table View Demo
//
//  Created by Corwin Crownover on 3/8/16.
//  Copyright © 2016 Corwin Crownover. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // OUTLETS & VARIABLES
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary] = []
    
    
    
//    var names = ["Corwin", "Jan", "Sara", "Tony", "Megan", "Peanut", "Cody", "Andi", "Becky", "Colin", "Tim", "Seth", "Ryan"]
//    
//    var homes = ["Texas", "Germany", "Minnesota", "Nevada", "California", "Oregon", "Oregon", "Texas", "Englad", "Oregon", "Ohio", "Nebraska", "Texas"]
    
    

    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us")!
        let request = NSURLRequest(URL: url)

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            do {
            
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            
                self.movies = json["movies"] as! [NSDictionary]
            
                print(self.movies)
            
                self.tableView.reloadData()
            }
            
            // Handle errors
            catch {
                print("Failed")
            }
        }
    }
        

        
        

        
        // Do any additional setup after loading the view, typically from a nib.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    // FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
        
//        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("Row: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        let posterUrlString = movie.valueForKeyPath("posters.thumbnail") as? String
        let posterUrl = NSURL(string: posterUrlString!)!
        print(posterUrl)
        

        cell.posterView.setImageWithURL(posterUrl)
        
//        cell.nameLabel.text = names[indexPath.row]
//        cell.homeLabel.text = homes[indexPath.row]
        
        
        return cell
    }
    
    
    
    
    
}

