//
//  PhotosViewController.swift
//  Table View Demo
//
//  Created by Corwin Crownover on 3/8/16.
//  Copyright © 2016 Corwin Crownover. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // OUTLETS & VARIABLES
    @IBOutlet weak var tableView: UITableView!
    
//    var names: [NSDictionary]!
    var data: [NSDictionary]!
    
    
    // VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        data = []
        
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=e05c462ebd86446ea48a5af73769b602")!

        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                
//                print(json)
                
                self.data = json["data"] as! [NSDictionary]
                self.tableView.reloadData()
            }
            
            catch {
                print("Failed")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell")! as! PhotoCell
        
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        let photo = data[indexPath.row]
        let username = photo.valueForKeyPath("user.username") as! String
        let urlString = photo.valueForKeyPath("images.low_resolution.url") as! String
        let profilePhotoUrlString = photo.valueForKeyPath("user.profile_picture") as! String
        
        print(urlString)
        
        cell.usernameLabel.text = username        
        // Other way to declare and initialize username: cell.usernameLabel.text = user["username"] as! String
        
        cell.photoView.setImageWithURL(NSURL(string: urlString)!)
        cell.profileView.setImageWithURL(NSURL(string: profilePhotoUrlString)!)
        
        return cell
    }

}
