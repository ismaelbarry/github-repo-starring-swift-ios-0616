//
//  ReposTableViewController.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        
        store.getRepositoriesWithCompletion {
           
            NSOperationQueue.mainQueue().addOperationWithBlock({
            
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.store.repositories.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath)

        
        let repository:GithubRepository = self.store.repositories[indexPath.row]
        
        cell.textLabel?.text = repository.fullName

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.store.toggleStarStatusForRepository(self.store.repositories[indexPath.row]) { (isItStarred) in
            
            if isItStarred == true {
                
                let searchAlert : UIAlertController = UIAlertController(title: "Repository Unstarred", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                
                searchAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(searchAlert, animated: true, completion: nil)
                
            } else {
                
                let searchAlert : UIAlertController = UIAlertController(title: "Repository Starred", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                
                searchAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(searchAlert, animated: true, completion: nil)
                
            }

            print("toggling")
        }
    }
}