//
//  AccountViewModel.swift
//  MovieApi
//
//  Created by Admin on 05/07/23.
//

import Foundation

class AccountViewModel{
    private let API_KEY = "7187630fe891b4967bb148e64cb2e390"
    
    func GetDetails(resp : @escaping(Account?, Error?) -> Void){
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
                    let result = try! decoder.decode(Account.self, from: dataSource)
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
    
    
}
