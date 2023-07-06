//
//  MovieViewModel.swift
//  MovieApi
//
//  Created by Admin on 27/06/23.
//

import Foundation

private let API_KEY = "7187630fe891b4967bb148e64cb2e390"

class MovieViewModel{
    
    func GetAllPopular( resp : @escaping(Root<Results>?, Error?)-> Void){
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDU0MjNmZTgzMmYyNjYwYTQ5NjU5Y2NkNmFlYzcxOSIsInN1YiI6IjY0OTIyMGNhMGYyYWUxMDEyNTA3ZTkwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IO5c8HkGv9OzsOZ3XLyIK91B8tbKqfYsGj3wJKzKWrs"
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(Root<Results>.self, from: dataSource)
                    resp(result, nil)
                }
            }
        }.resume()
    }
    
    func GetAllTopRated( resp : @escaping(Root<Results>?, Error?)-> Void){
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZDU0MjNmZTgzMmYyNjYwYTQ5NjU5Y2NkNmFlYzcxOSIsInN1YiI6IjY0OTIyMGNhMGYyYWUxMDEyNTA3ZTkwMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IO5c8HkGv9OzsOZ3XLyIK91B8tbKqfYsGj3wJKzKWrs"
        ]
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(Root<Results>.self, from: dataSource)
                    //                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    //                    print(jsonString)
                    resp(result, nil)
                }
            }
        }.resume()
    }
    
   
    
    func GetDetail(_ idPelicula : Int, resp : @escaping(DetailCompanies<Companie>?, Error?)-> Void){
           let headers = [
               "accept": "application/json",
           ]
           
           let url = URL(string: "https://api.themoviedb.org/3/movie/\(idPelicula)?api_key=\(API_KEY)")!
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           request.allHTTPHeaderFields = headers
           
           URLSession.shared.dataTask(with: request){ data, response, error in
               let httpResponse = response as! HTTPURLResponse
               if 200...299 ~= httpResponse.statusCode{
                   if let dataSource = data{
                       let decoder = JSONDecoder()
                       let result = try! decoder.decode(DetailCompanies<Companie>.self, from: dataSource)
                       
                       resp(result, nil)
                   }
               }
           }.resume()
       }
    
    
    
    }
