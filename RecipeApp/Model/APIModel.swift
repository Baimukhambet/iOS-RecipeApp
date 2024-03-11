import Foundation
import UIKit

final class APIModel {
    static let shared = APIModel()
    private init() { }
    
    let BASE_URL = URL(string: "https://themealdb.com/api/json/v1/1/search.php")!
    
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
                } catch {
                    print("Failed to decode.")
                    return
                }
 
            } else if let error = error {
                print("error: \(error)")
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

