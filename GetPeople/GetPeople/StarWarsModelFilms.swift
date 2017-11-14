//
//  StarWarsModelFilms.swift
//  GetPeople
//
//  Created by Kevin Pham on 11/14/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import Foundation

import Foundation
class StarWarsModelFilms {

    static func getAllFilms(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://swapi.co/api/films/")
        let session = URLSession.shared

        let task = session.dataTask(with: url!, completionHandler: completionHandler)

        task.resume()
    }
}

