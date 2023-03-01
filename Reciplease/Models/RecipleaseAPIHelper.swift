//
//  RecipleaseAPIHelper.swift
//  Reciplease
//
//  Created by Wass on 19/02/2023.
//

import Foundation
import Alamofire

class RecipleaseAPIHelper {
    
    static let shared = RecipleaseAPIHelper(session: URLSession(configuration: .default))
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    let baseURL = "https://api.edamam.com/api/recipes/v2?type=public&app_id=4ae2535f&app_key=e0fd18ebb877b9ea66bd1dee0c135920"
    
    
    func getUrl(q: String) -> String? {
        let baseUrl = baseURL
        let urlString = baseUrl + q
     
        return urlString
    } 
    
    func performRequest(q: String, completion: @escaping (Bool, [Hits]?) -> Void) {
        
        if let urlString = getUrl(q: q) {
            _ = AF.request(urlString)
                .responseDecodable(of: RecipleaseAPIResult.self) { (response) in
                    guard let result = response.value else { return }
                    completion( true, result.hits)
                }
        }
    
    }
}
