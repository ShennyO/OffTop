//
//  Networking.swift
//  OffTop
//
//  Created by Sunny Ouyang on 1/12/19.
//  Copyright © 2019 Sunny Ouyang. All rights reserved.
//

import Foundation

class Network {
    
    static let instance = Network()
    let urlPath = "https://api.datamuse.com/words"
    let session = URLSession.shared
    
    func fetch(word: [String: String], completion: @escaping (Data, HTTPURLResponse) -> Void) {
        let pathURL = URL(string: urlPath)
        let fullURL = pathURL?.appendingQueryParameters(word)
        let request = URLRequest(url: fullURL!)
        
        session.dataTask(with: request) { (data, resp, err) in
            
            if let data = data, let resp = resp {
                completion(data,resp as! HTTPURLResponse)
            }
            
        }.resume()
        
    }
    
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        //
        return URL(string: URLString)!
    }
    // This is formatting the query parameters with an ascii table reference therefore we can be returned a json file
}

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
    
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

