//
//  Lab Objectives.swift
//  github-repo-starring-swift
//
//  Created by Ismael Barry on 7/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

// https://github.com/learn-co-students/github-repo-starring-swift-ios-0616

// Lab Objective:
// Bring in the code you've already written for your Github Repo List lab. You've already gotten the table view to display a list of repositories, so it's time to add some additional functionality to this app. We want to be able to tap on repos in the table view and have it star or unstar the repository appropriately, using Github's API. You can see the overview of the relevant API calls here.

// Link To Starring Repositories: https://developer.github.com/v3/activity/starring/

// Link to User Authentication: https://developer.github.com/v3/#authentication

// Link to Listing Repositories: https://developer.github.com/v3/repos/

// Instructions:

// 1. Create the method in GithubAPIClient called checkIfRepositoryIsStarred(fullName: completion:) that accepts a repo full name (e.g. githubUser/repoName) and checks to see if it is currently starred. The completion closure should take a boolean (true for starred, false otherwise). Checkout the Github Documentation on how this works on the API side.
// 2. Keep in mind that since this action needs to know which user is doing the starring, it will have to be passed the access token. You can do that by adding an access_token parameter in the query string of the URL. The same is true for all the remaining API calls in this lab.
// 3. Make a method in GithubAPIClient called starRepository(fullName: completion:) that stars a repository given its full name. Checkout the Github Documentation. The completion closure shouldn't return anything and shouldn't accept any parameters.
// 4. Make a method in GithubAPIClient called unstarRepository(fullName: completion:) that unstars a repository given its full name. Checkout the Github Documentation.
// 5. Create a method in ReposDataStore called toggleStarStatusForRepository(repository: completion:) that, given a GithubRepository object, checks to see if it's starred or not and then either stars or unstars the repo. That is, it should toggle the star on a given repository. In the completion closure, there should be a Bool parameter called starred that is true if the repo was just starred, and false if it was just unstarred.
// 6. Finally, when a cell in the table view is selected, it should call your ReposDataStore method to toggle the starred status and display a UIAlertController saying either "You just starred REPO NAME" or "You just unstarred REPO NAME". You should also set the accessibilityLabel of the presented alert controller to either "You just starred REPO NAME" or "You just unstarred REPO NAME" (depending on the action that just occurred).
// 7. Verify that the starring worked. You should go to the Github page for any repository that you tap and see its star status. For example, if you tapped on mojombo/grit, go to http://www.github.com/mojombo/grit and check if it's starred or not. Tap the cell for that repo again and refresh the page for the repository in your browser. You should see the star status of the repository change!