//
//  RecipleaseAPIHelper.swift
//  Reciplease
//
//  Created by Wass on 19/02/2023.
//

import Foundation
import Alamofire

protocol APIHelper {
    func performRequest(q: String, completion: @escaping (Bool, [Hits]?) -> Void)
}



class RecipleaseAPIHelper: APIHelper {
    
    static let shared = RecipleaseAPIHelper()
    
    
    
    private var session = URLSession(configuration: .default)
    
    
    let baseURL = "https://api.edamam.com/api/recipes/v2?type=public&app_id=4ae2535f&app_key=e0fd18ebb877b9ea66bd1dee0c135920"
    
    // Make the string url
    func getUrl(q: String) -> String? {
        let baseUrl = baseURL
        let urlString = baseUrl + q
        
        return urlString
    }
    
    // Perform request then call the completion block with the results
    func performRequest(q: String, completion: @escaping (Bool, [Hits]?) -> Void) {
        if let urlString = getUrl(q: q) {
            _ = AF.request(urlString)
                .responseDecodable(of: RecipleaseAPIResult.self) { response in
                    switch response.result {
                    case .success(_):
                        guard let result = response.value else { return }
                        completion( true, result.hits)
                        
                    case .failure(let error):
                        print(error)
                        
                    }
                }
        }
        
    }
}

class MockRecipleaseAPIHelper: APIHelper {
    
    // Perform request then call the completion block with a mock
    func performRequest(q: String, completion: @escaping (Bool, [Hits]?) -> Void) {
        let response = [
            Reciplease.Hits(recipe: Reciplease.Recipes(label: "Strong Cheese", image: "https://edamam-product-images.s3.amazonaws.com/web-img/53c/53ca837dcd939671920e6ab70ad723a6.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEOL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIHyr54%2BGL1JRTrH3SY65IqcZABLcYXXUoqJHDir9soNfAiBScomqTxI9Gtbj9cWrMeDns%2BZKf0LCti7shtuwoY0bIiq4BQhaEAAaDDE4NzAxNzE1MDk4NiIMM19AZFfkx2w1p0ZNKpUFfcfbGtXP43mvH9j%2F8kAEAGXykyfNrb%2FZeGHl1gMpxtEbpBSlKLeUIC9NZkiluz3%2B98ucRvjLpqIiQ3AgcA%2FRxCT6l658GGSAnI466hRqGP8KAYPVVEduyAlnUC8nhUKAXG%2Bd06L0NIpt0Ub4K8a%2Fnsl%2FTKOhHjs3GQQ56EBx%2BjG8Z7iej9zsfNmigHOw0wHfvf0TyhpA02eM%2BXvd6RwDklWGf3CvZ8yDLLsXTdAAN1c4jMq0Xi%2Bhpt7X5Jk8jhrdcsRfrRLU9ZkBxP1yEV9owF9%2FKKukPcOaxEKv8NliijyvV%2BRbQmfUW9YAwDXa2dBh0SWWa%2FEl7AISdKmNXVVn2l%2FWJ1ha%2BiSG5RKwTIcKl6QZ14diGhnthrqn6xTqrtgobgtEltU0wb5qsKAQJGffEJPqki32vOCb0LeqTi6LTiYRlN9dGgREgECVTt4syBKPsWxsqdcD1weUtGP5YGiVMxphoLJ41nwBi2gBRg31YNJoBeMAsNTW8gp4Aof0Lf9rkzQJhigYnzJpuuNp8OEcafeZqgcrdf2WvLa84EGqAXk1oNV9Y7rayW0F1cQWbV2rJS%2BjKf1vrD%2F%2F6cux%2FCjeRfKf2jvGnOgxv%2BfiKyP5KuYTmJYK8UcKLr1%2FmPXDei7opQEsGKLiApdtFA3rn7CTcFulXBG56%2F50mG8MAigNVxcCTI3LZe03kzEN2xXCFiAejoH1IQFDhxbUIURsBzrt2CJ1y%2BhvpAyITVsBRsmgWRLteIh98PkN%2Bvh%2BWL3i%2BBVH%2FwUCGqkQyciQ%2BT2Ci63sTEz%2BKcLFe9Z%2ByzV4rxN0yvVzWuM8Ww5nmHXl7m9UsDilGg84HoltFyJz6h5GTmmVU06kiEpi1dRHgDFiK%2FJYheJxkumRVTCvq5%2BlBjqyAUTJakNYpsXTN%2Ff44uuRzFkPhwzLxxHh%2F0wEl%2BUefyxDfPF1LnZQDOVBPfAx9CbaBAAkMufObNgjPiu9QJ5mp3UD13Ts41fVcHNrfEsLj02bK9upUb5TMtA30sXmeFVaEp8CnPSEM2WRHj5G1dmsDECy5gpQVWj3osr2qiKbJ4HvBMB0xyUV7FUaRVm2O5V8A0ALaj%2F3cbEG%2Biit%2FVZCgAspPqN%2BlarRC5zZLD9XFw37DL0%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230707T094040Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFCZTF6L7V%2F20230707%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=497d3486d29314f4c11a185ea7b5b5f10a64424f44bf52d5713968bf0d9beff8", ingredientLines: ["1 lb left-over cheese, at room temperature", "1/4 cup dry white wine", "3 tbsp unsalted butter, softened", "2 tbsp fresh parsley leaves", "1 small clove garlic"], ingredients: [Reciplease.Ingredients(food: "cheese"), Reciplease.Ingredients(food: "dry white wine"), Reciplease.Ingredients(food: "unsalted butter"), Reciplease.Ingredients(food: "parsley"), Reciplease.Ingredients(food: "garlic")])),
            Reciplease.Hits(recipe: Reciplease.Recipes(label: "Goat Cheese Soufflé", image: "https://edamam-product-images.s3.amazonaws.com/web-img/49a/49ae4bc0011fa988af9c0dfa167764a1.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEOL%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIHyr54%2BGL1JRTrH3SY65IqcZABLcYXXUoqJHDir9soNfAiBScomqTxI9Gtbj9cWrMeDns%2BZKf0LCti7shtuwoY0bIiq4BQhaEAAaDDE4NzAxNzE1MDk4NiIMM19AZFfkx2w1p0ZNKpUFfcfbGtXP43mvH9j%2F8kAEAGXykyfNrb%2FZeGHl1gMpxtEbpBSlKLeUIC9NZkiluz3%2B98ucRvjLpqIiQ3AgcA%2FRxCT6l658GGSAnI466hRqGP8KAYPVVEduyAlnUC8nhUKAXG%2Bd06L0NIpt0Ub4K8a%2Fnsl%2FTKOhHjs3GQQ56EBx%2BjG8Z7iej9zsfNmigHOw0wHfvf0TyhpA02eM%2BXvd6RwDklWGf3CvZ8yDLLsXTdAAN1c4jMq0Xi%2Bhpt7X5Jk8jhrdcsRfrRLU9ZkBxP1yEV9owF9%2FKKukPcOaxEKv8NliijyvV%2BRbQmfUW9YAwDXa2dBh0SWWa%2FEl7AISdKmNXVVn2l%2FWJ1ha%2BiSG5RKwTIcKl6QZ14diGhnthrqn6xTqrtgobgtEltU0wb5qsKAQJGffEJPqki32vOCb0LeqTi6LTiYRlN9dGgREgECVTt4syBKPsWxsqdcD1weUtGP5YGiVMxphoLJ41nwBi2gBRg31YNJoBeMAsNTW8gp4Aof0Lf9rkzQJhigYnzJpuuNp8OEcafeZqgcrdf2WvLa84EGqAXk1oNV9Y7rayW0F1cQWbV2rJS%2BjKf1vrD%2F%2F6cux%2FCjeRfKf2jvGnOgxv%2BfiKyP5KuYTmJYK8UcKLr1%2FmPXDei7opQEsGKLiApdtFA3rn7CTcFulXBG56%2F50mG8MAigNVxcCTI3LZe03kzEN2xXCFiAejoH1IQFDhxbUIURsBzrt2CJ1y%2BhvpAyITVsBRsmgWRLteIh98PkN%2Bvh%2BWL3i%2BBVH%2FwUCGqkQyciQ%2BT2Ci63sTEz%2BKcLFe9Z%2ByzV4rxN0yvVzWuM8Ww5nmHXl7m9UsDilGg84HoltFyJz6h5GTmmVU06kiEpi1dRHgDFiK%2FJYheJxkumRVTCvq5%2BlBjqyAUTJakNYpsXTN%2Ff44uuRzFkPhwzLxxHh%2F0wEl%2BUefyxDfPF1LnZQDOVBPfAx9CbaBAAkMufObNgjPiu9QJ5mp3UD13Ts41fVcHNrfEsLj02bK9upUb5TMtA30sXmeFVaEp8CnPSEM2WRHj5G1dmsDECy5gpQVWj3osr2qiKbJ4HvBMB0xyUV7FUaRVm2O5V8A0ALaj%2F3cbEG%2Biit%2FVZCgAspPqN%2BlarRC5zZLD9XFw37DL0%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230707T094040Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFCZTF6L7V%2F20230707%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=9d2174f197398f28641f72b454fcdc79ccd7aaf0848e5950851aeb392941bf32", ingredientLines: ["¼ cup (60g) full-fat cream cheese", "4 large eggs, separated, at room temperature", "4 ounces (115g) fresh goat cheese", "grated zest of 1 lemon", "4 tablespoons (50g) sugar", "pinch of salt"], ingredients: [Reciplease.Ingredients(food: "cream cheese"), Reciplease.Ingredients(food: "eggs"), Reciplease.Ingredients(food: "goat cheese"), Reciplease.Ingredients(food: "lemon"), Reciplease.Ingredients(food: "sugar"), Reciplease.Ingredients(food: "salt")]))
        ]
        completion(true, response)
    }
    
    
}
