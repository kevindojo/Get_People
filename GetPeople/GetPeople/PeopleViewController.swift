//
//  ViewController.swift
//  GetPeople
//
//  Created by Kevin Pham on 11/14/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    var people = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // specify the url that we will be sending the GET request to
        let url = NSURL(string: "http://swapi.co/api/people")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run completion handler
        let task = session.dataTask(with: url! as URL, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {

                    if let results = jsonResult["results"] as? NSArray {
                        for person in results {
                            let personDict = person as! NSDictionary
                            self.people.append(personDict["name"]! as! String)
                        }

                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("=======something went wrong=======")
            }
        })
        
        // execute the task and then wait for the response
        // to run the completion handler. This is async!
        task.resume()
        print("======Happens before the response=====")
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row]
        return cell
    }
        
}

