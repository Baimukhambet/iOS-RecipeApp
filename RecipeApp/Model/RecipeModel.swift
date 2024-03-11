import Foundation


class Meal: NSObject, Decodable {
    let idMeal, strMeal: String?
    let strDrinkAlternate: String?
    let strCategory, strArea, strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    @objc dynamic var strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    @objc dynamic var strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    @objc dynamic var strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
    @objc dynamic var strIngredient13, strIngredient14, strIngredient15, strIngredient16: String?
    @objc dynamic var strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
    @objc dynamic var strMeasure1, strMeasure2, strMeasure3: String?
    @objc dynamic var strMeasure4: String?
    @objc dynamic var strMeasure5: String?
    @objc dynamic var strMeasure6: String?
    @objc dynamic var strMeasure7: String?
    @objc dynamic var strMeasure8: String?
    @objc dynamic var strMeasure9: String?
    @objc dynamic var strMeasure10: String?
    @objc dynamic var strMeasure11: String?
    @objc dynamic var strMeasure12: String?
    @objc dynamic var strMeasure13: String?
    @objc dynamic var strMeasure14: String?
    @objc dynamic var strMeasure15: String?
    @objc dynamic var strMeasure16: String?
    @objc dynamic var strMeasure17: String?
    @objc dynamic var strMeasure18: String?
    @objc dynamic var strMeasure19: String?
    @objc dynamic var strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: Bool?
    let dateModified: String?
    
}

struct MealsResponse: Decodable {
    let meals: [Meal]
}

struct MiniMeal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}


