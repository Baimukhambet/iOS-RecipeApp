import Foundation
import UIKit

final class APIModel {
    static let shared = APIModel()
    private init() { }
    
    let BASE_URL = URL(string: "https://themealdb.com/api/json/v1/1/search.php")!
    let FILTER_URL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php")!
    let FULL_URL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php")!
    
    func getMealByName(mealName: String, completion: @escaping ([Meal]) -> ()) {
        var component = URLComponents(string: BASE_URL.absoluteString)
        component?.queryItems = [
            URLQueryItem(name: "s", value: mealName)
        ]
        var request = URLRequest(url: (component?.url)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(MealsResponse.self, from: data)
                    let meals = decodedData.meals
                    completion(meals)
                } catch let error {
                    print("Failed to decode: \(error.localizedDescription)")
                    return
                }
 
            } else if let error = error {
                print("error: \(error)")
            }
        }.resume()
        
    }
    
    func getMealsByLetter(letter: String, completion: @escaping ([Meal]) -> ()) {
        var component = URLComponents(string: BASE_URL.absoluteString)
        component?.queryItems = [URLQueryItem(name: "f", value: letter)]
        var request = URLRequest(url: component!.url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([String: [Meal]].self, from: data)
                    let meals = decodedData["meals"] ?? []
                    completion(meals)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getMealById(id: String, completion: @escaping (Meal?) -> ()) {
        var comp = URLComponents(string: FULL_URL.absoluteString)
        comp?.queryItems = [URLQueryItem(name: "i", value: id)]
        var request = URLRequest(url: comp!.url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([String: [Meal]].self, from: data)
                    let meals = decodedData["meals"] ?? []
                    let meal = meals.first
                    completion(meal)
                } catch let error {
                    print(error.localizedDescription)
                }
            } else {
                print("\(error?.localizedDescription ?? "Errror")")
            }
        }.resume()
    }
    
    func getMealsByArea(area: String, completion: @escaping ([Meal]) -> ()) {
        var component = URLComponents(string: FILTER_URL.absoluteString)
        component?.queryItems = [
            URLQueryItem(name: "a", value: area)
        ]
        var request = URLRequest(url: component!.url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error Fetching by Area: \(error.localizedDescription)")
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([String: [Meal]].self, from: data)
                    let meals = decodedData["meals"]!
                    completion(meals)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                completion(image ?? UIImage())
            } else {
                print("Failed to load Image.")
            }
        }.resume()
    }
}

