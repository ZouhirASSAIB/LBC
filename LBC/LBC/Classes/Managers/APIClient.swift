//
//  APIClient.swift
//  LBC
//
//  Created by Zouhair ASSAIB on 05/03/2021.
//

import Foundation

// MARK: - APIClient
class APIClient {
    
    var baseURL: URL?
    
    static let shared = { APIClient(baseUrl: APIManager.shared.baseURL) }()
    
    required init(baseUrl: String){
        self.baseURL = URL(string: baseUrl)
    }
    
    func getArray<T>(urlString: String,
                     success: @escaping (T) -> (),
                     failure: @escaping (Error) -> ()) where T: Decodable {
        
        guard let url = URL(string: urlString , relativeTo: self.baseURL as URL?) else {
            return
        }
        
        // Create the HTTP request
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                // Handle HTTP request error
                failure(error)
            } else if let data = data {
                // Handle HTTP request response
                
                if let resultValue = try? JSONDecoder().decode(T.self, from: data) {
                    success(resultValue)
                } else {
                    // Handle invalid response
                    failure(HttpRequestError.invalidResponse)
                }
            } else {
                // Handle unexpected error
                failure(HttpRequestError.unexpected)
            }
        }
        
        task.resume()
    }
}
