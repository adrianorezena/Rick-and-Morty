//
//  ServiceBase.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 23/01/21.
//

import Foundation

class ServiceBase {
    
    enum ServiceResponseType {
        case success(Data)
        case failure(Error)
    }
    
    enum ServiceHttpMethod: String {
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    typealias ServiceCompletionHandler = (ServiceResponseType) -> ()
    let queue = DispatchQueue(label: UUID().uuidString, qos: .utility, attributes: .concurrent)
    

    
    @discardableResult
    func makeRequest(url: URL, method: ServiceHttpMethod = .get, authorization: String? = nil, parameters: [String: Any]? = nil, onComplete: @escaping ServiceCompletionHandler) -> URLSessionDataTask {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = data
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                print("Failed to add parameters in the httpBody: \(error.localizedDescription)")
            }
        }
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if let error = error {
                onComplete(.failure(error))
                return
            } else {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    onComplete(.success(data))
                } else {
                    onComplete(.failure(NSError(domain: "ApiRequestError", code: 600)))
                }
            }
        })
        
        task.resume()
        return task
    }
}
