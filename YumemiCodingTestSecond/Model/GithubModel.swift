//
//  GithubModel.swift
//  YumemiCodingTest
//
//  Created by system on 2021/11/11.
//

import UIKit

class Github {
    
    static func getTableItems(with textUserInput: String, completionHandler: @escaping ([Repository.Item]) -> Void) {
        
        let task: URLSessionTask?
        var url: String?
        
        guard let textsEncodeString = textUserInput.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return
        }
        
        url = "https://api.github.com/search/repositories?q=\(textsEncodeString)"
        guard let url = url else {
            return
        }
        
        task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let jsonData = data else {
                return
            }
            do {
                let repository = try JSONDecoder().decode(Repository.self, from: jsonData)
                let items = repository.items
                completionHandler(items)
            } catch {
                print(error)
            }
        }
        task?.resume()
    }
}
