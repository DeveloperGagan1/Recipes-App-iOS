//
//  Helpers.swift
//  RecipesApp
//
//  Created by Gagan Pareek on 16/05/23.
//

import Foundation

extension Bundle {
    
    //Decodes JSON
    func decode<T: Decodable>(file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Couldn't find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
    
    //Fatches data and decodes JSON files
    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: url) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            failure(error)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                failure(error!)
                return
            }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let mealsArray = jsonObject["meals"] as? [[String: Any]],
                      let mealData = mealsArray.first,
                      let jsonData = try? JSONSerialization.data(withJSONObject: mealData, options: [])
                else {
                    let error = NSError(domain: "Invalid JSON response", code: 0, userInfo: nil)
                    failure(error)
                    return
                }
                
                let decoder = JSONDecoder()
                let serverData = try decoder.decode(T.self, from: jsonData)
                completion(serverData)
            } catch let error {
                failure(error)
            }
        }.resume()

    }

}
