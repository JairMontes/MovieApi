//
//  SerieViewModel.swift
//  MovieApi
//
//  Created by Admin on 05/07/23.
//

import Foundation

class SerieViewModel {
    
    private let API_KEY = "7187630fe891b4967bb148e64cb2e390"
    
    func GetAllOnTV( resp : @escaping(Root<Results1>?, Error?)-> Void){
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDU0MjNmZTgzMmYyNjYwYTQ5NjU5Y2NkNmFlYzcxOSIsInN1YiI6IjY0OTIyMGNhMGYyYWUxMDEyNTA3ZTkwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IO5c8HkGv9OzsOZ3XLyIK91B8tbKqfYsGj3wJKzKWrs"
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/tv/on_the_air")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(Root<Results1>.self, from: dataSource)
                    resp(result, nil)
                }
            }
        }.resume()
    }
    
    func GetAllAiringToday( resp : @escaping(Root<Results1>?, Error?)-> Void){
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDU0MjNmZTgzMmYyNjYwYTQ5NjU5Y2NkNmFlYzcxOSIsInN1YiI6IjY0OTIyMGNhMGYyYWUxMDEyNTA3ZTkwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IO5c8HkGv9OzsOZ3XLyIK91B8tbKqfYsGj3wJKzKWrs"
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(Root<Results1>.self, from: dataSource)
                    resp(result, nil)
                }
            }
        }.resume()
    }
    
    func GetDetail(idSerie : Int, resp : @escaping(DetailResponse<Companie>?, Error?)-> Void){
            let headers = [
                "accept": "application/json",
            ]
            
            let url = URL(string: "https://api.themoviedb.org/3/tv/\(idSerie)?api_key=\(API_KEY)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                let httpResponse = response as! HTTPURLResponse
                if 200...299 ~= httpResponse.statusCode{
                    if let dataSource = data{
                        let decoder = JSONDecoder()
                        let result = try! decoder.decode(DetailResponse<Companie>.self, from: dataSource)
                        //                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                        //                    print(jsonString)
                        resp(result, nil)
                    }
                }
            }.resume()
        }
    
}
