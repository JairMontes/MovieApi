//
//  LoginViewModel.swift
//  MovieApi
//
//  Created by Admin on 04/07/23.
//

import Foundation

class LoginViewModel{
    
    private let API_KEY = "7187630fe891b4967bb148e64cb2e390"
    
    func RequestToken(resp: @escaping(Session?, Error?)->Void){
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=\(API_KEY)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(Session.self, from: dataSource)
                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    print(jsonString)
                    resp(result, nil)
                }
            }
            
            if 400...499 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let error = try! decoder.decode(Error.self, from: dataSource)
                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    print(jsonString)
                    resp(nil, error)
                }
            }
            
        }.resume()
        
    }
    
    func LogIn(username: String, password: String, requestToken : String, resp : @escaping(Session?, Error?)-> Void){
        
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        let parameters = [
            "username": "\(username)",
            "password": "\(password)",
            "request_token": "\(requestToken)"
        ] as [String : Any]
        
        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(API_KEY)")!
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as? Data
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(Session.self, from: dataSource)
                    //                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    //                    print(jsonString)
                    resp(result, nil)
                }
            }
            
            if 400...499 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let error = try! decoder.decode(Error.self, from: dataSource)
                    //                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    //                    print(jsonString)
                    resp(nil, error)
                }
            }
            
        }.resume()
        
    }
    
    func SessionId(requestToken : String, resp : @escaping(Usuario?, Error?) -> Void){
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        let parameters = [
            "request_token": "\(requestToken)"
        ] as [String : Any]
        
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(API_KEY)")!
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as? Data
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(Usuario.self, from: dataSource)
                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    print(jsonString)
                    resp(result, nil)
                }
            }
            
            if 400...499 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let error = try! decoder.decode(Error.self, from: dataSource)
                    //                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    //                    print(jsonString)
                    resp(nil, error)
                }
            }
            
        }.resume()
        
    }
    
    func DetailUser(resp : @escaping(User?, Error?)-> Void){
        let defaults = UserDefaults.standard
        var sessionId = defaults.string(forKey: "session_id")
        let url = URL(string: "https://api.themoviedb.org/3/account?api_key=\(API_KEY)&session_id=\(sessionId ?? "")")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    print(jsonString)
                    let result = try! decoder.decode(User.self, from: dataSource)
                    resp(result, nil)
                }
            }
        }.resume()
        
    }
    
    func LogOut(resp: @escaping(Session?, Error?)->Void){
            
            let defaults = UserDefaults.standard
            let sessionId = defaults.string(forKey: "session_id")!
   
            let headers = [
                "accept": "application/json",
                "content-type": "application/json",
            ]

            let parameters = [
                "session_id": "\(sessionId)"
            ] as [String : Any]
            
            let url = URL(string: "https://api.themoviedb.org/3/authentication/session?api_key=\(API_KEY)")!
            let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as? Data
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                let httpResponse = response as! HTTPURLResponse
                if 200...299 ~= httpResponse.statusCode{
                    if let dataSource = data{
                        let decoder = JSONDecoder()
                        let result = try! decoder.decode(Session.self, from: dataSource)
                        let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
   
                        resp(result, nil)
                    }
                }
                
                if 400...499 ~= httpResponse.statusCode{
                    if let dataSource = data{
                        let decoder = JSONDecoder()
                        let error = try! decoder.decode(Error.self, from: dataSource)
                        let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)

                        resp(nil, error)
                    }
                }
                
            }.resume()

        }
    
   
}
