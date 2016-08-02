//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    //  The job of this function is to fetch all the repositories from the Github API, and pass that array of dictionaries on to its completion closure.
    //  How does this method get those objects back to the person who called it? It should take its own closure as an argument, which accepts the array of dictionaries as a parameter and returns nothing.
    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
        
        let urlString = "\(Secrets.githubAPIURL)/repositories?client_id=\(Secrets.githubClientID)&client_secret=\(Secrets.githubClientSecret)"
        
        let url = NSURL(string: urlString)
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
        
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray {
            
                if let responseArray = responseArray {
                
                    completion(responseArray)
                }
            }
        }
        task.resume()
    }
    
    // Method accepts a repo full name (e.g. githubUser/repoName) and checks to see if it is currently starred. The completion closure should take a boolean (true for starred, false otherwise).
    // Ask yourself: If some wants you to check if a repository is starred, then you have to provide them a YES or NO answer. Hence the Bool in the completion.
    class func checkIfRepositoryIsStarred(fullName: String,  completion: (Bool) ->()) {
        
        let urlString = "\(Secrets.githubStarRepositoryURL)\(fullName)"
        
        let url = NSURL(string: urlString)
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL for checking starred repository.") }
        
        // // Github requires that a user is Authenticated; therefore we creat an NSMutableURLRequest, so we can pass in the correct Header Fields for authorization.
        let githubRequest = NSMutableURLRequest(URL: unwrappedURL)
        
        // Allows us to set the value for a given header field. In our case, the header field name (key) is “Authorization” and the value is the token. We know this because the Github API tells us how they want the information submitted—they want us to set a value for a HTTP Header.
        githubRequest.addValue("\(Secrets.authorizationAccessToken)", forHTTPHeaderField: "Authorization")
        
        // In the github API, the HTTP verb to list starred repositories is "GET".
        githubRequest.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(githubRequest) { (data, response, error) in
   
            guard let responseValue = response as? NSHTTPURLResponse else { assertionFailure("Assignment didn't work.")
                
                return
            }
            
            // We check for a response status code of 204 because that is what the API returns if we have all parameters correct (if we hit API successfully). If we are successful, then we return true inside of the completion block as we are done.
            if responseValue.statusCode == 204 {
                
                completion(true)
            
            } else if responseValue.statusCode == 404 {
                
                completion(false)
                
            } else {
                
                print("Other status code: \(responseValue.statusCode)")
            }
        }
        task.resume()
    }
    
    // Method stars a repository given its full name.
    // Ask yourself: If some wants you to star a repository, you don't have to give them an answer...you just do it. Hence nothing in the completion.
    class func starRepository(fullName: String, completion:() -> ()) {
        
        let urlString = "\(Secrets.githubStarRepositoryURL)\(fullName)"
        
        let url = NSURL(string: urlString)
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL for starring repository.") }
        
        // Github requires that a user is Authenticated; therefore we creat an NSMutableURLRequest, so we can pass in the correct Header Fields for authorization.
        let githubRequest = NSMutableURLRequest(URL: unwrappedURL)
        
        // Allows us to set the value for a given header field. In our case, the header field name (key) is “Authorization” and the value is the token. We know this because the Github API tells us how they want the information submitted—they want us to set a value for a HTTP Header.
        githubRequest.addValue("\(Secrets.authorizationAccessToken)", forHTTPHeaderField: "Authorization")
        
        // In the github API, the HTTP verb to star a repository is "PUT".
        githubRequest.HTTPMethod = "PUT"
        
        let task = session.dataTaskWithRequest(githubRequest) { (data, response, error) in
            
            guard let responseValue = response as? NSHTTPURLResponse else { assertionFailure("Assignment in star function didin't work.")
                
                return
            }
            
            // We check for a response status code of 204 because that is what the API returns if we have all parameters correct (if we hit API successfully). If we are successful, then we run the completion block as we are done.
            if responseValue.statusCode == 204 {
                
                print("I am starring a repository.")
                
                completion()
            
            } else {
              
                print("Other status code: \(responseValue.statusCode)")
                
            }
        }
        task.resume()
    }
    
    // Method unstars a repository given its full name.
    // Ask yourself: If some wants you to un-star a repository, you don't have to give them an answer...you just do it. Hence nothing in the completion.
    class func unstarRepository(fullName: String, completion:() -> ()) {
        
        let urlString = "\(Secrets.githubStarRepositoryURL)\(fullName)"
        
        let url = NSURL(string: urlString)
        
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL for unstarring respository.") }
        
        // Github requires that a user is Authenticated; therefore we creat an NSMutableURLRequest, so we can pass in the correct Header Fields for authorization.
        let githubRequest = NSMutableURLRequest(URL: unwrappedURL)
        
        // Allows us to set the value for a given header field. In our case, the header field name (key) is “Authorization” and the value is the token. We know this because the Github API tells us how they want the information submitted—they want us to set a value for a HTTP Header.
        githubRequest.addValue("\(Secrets.authorizationAccessToken)", forHTTPHeaderField: "Authorization")
        
        // In the github API, the HTTP verb to unstar a repository is "DELETE".
        githubRequest.HTTPMethod = "DELETE"
        
        let task = session.dataTaskWithRequest(githubRequest) { (data, response, error) in
            
            guard let responseValue = response as? NSHTTPURLResponse else { assertionFailure("Assignment in unstar function didn't work.")
                
                return
            }
            
            // We check for a response status code of 204 because that is what the API returns if we have all parameters correct (if we hit API successfully). If we are successful, then we run the completion block as we are done.
            if responseValue.statusCode == 204 {
                
                print("I am unstarring a repository.")
                
                completion()
                
            } else {
                
                print("Other status code: \(responseValue.statusCode)")
                
            }
        }
        task.resume()
    }
}