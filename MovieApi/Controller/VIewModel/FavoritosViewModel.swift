//
//  FavoritosViewModel.swift
//  MovieApi
//
//  Created by Admin on 04/07/23.
//

import Foundation
import UIKit
import CoreData

class FavoritosViewModel{
    
    private let API_KEY = "7187630fe891b4967bb148e64cb2e390"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func AddFavorito(favorite: Bool, accountId: Int, mediaId : Int, mediaType : String ,resp: @escaping(Error?, Error?)->Void){
           
           let headers = [
             "accept": "application/json",
             "content-type": "application/json",
           ]
           
           let parameters = [
             "media_type": "\(mediaType)",
             "media_id": "\(mediaId)",
             "favorite": favorite
           ] as [String : Any]
           
           let defaults = UserDefaults.standard
           let sessionId = defaults.string(forKey: "session_id")

           let url = URL(string: "https://api.themoviedb.org/3/account/\(accountId)/favorite?api_key=\(API_KEY)&session_id=\(sessionId ?? "")")!
           print(url)
           let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
   //        print(postData)
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.allHTTPHeaderFields = headers
           request.httpBody = postData! as? Data
           
           URLSession.shared.dataTask(with: request){ data, response, error in
               let httpResponse = response as! HTTPURLResponse
               if 200...299 ~= httpResponse.statusCode{
                   if let dataSource = data{
                       let decoder = JSONDecoder()
                       let result = try! decoder.decode(Error.self, from: dataSource)
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
    
    func GetAllFavoritosMovies() -> Result{
        var result = Result()
        
        do{
            let context = appDelegate.persistentContainer.viewContext
            let response = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovies")
            
            let resultFetch = try context.fetch(response)
            
            result.Objects = []
            
            for objMovie in resultFetch as! [NSManagedObject]{
                var peliculas = Detalle()
                
                peliculas.id = objMovie.value(forKey: "idMovie") as? Int
                peliculas.original_language = objMovie.value(forKey: "original_language") as? String
                //drink.strCategory = objDrink.value(forKey: "strCategory") as! String
                peliculas.original_title = objMovie.value(forKey: "original_title") as? String
                peliculas.overview = objMovie.value(forKey: "overview") as? String
                peliculas.popularity = objMovie.value(forKey: "popularity") as? Float
                peliculas.poster_path = objMovie.value(forKey: "poster_path") as? String
                peliculas.release_date = objMovie.value(forKey: "release_date") as? String
                peliculas.homepage = objMovie.value(forKey: "homepage") as? String
                
                
                //drink.strInstructions = objDrink.value(forKey: "strInstructions") as! String
                
                result.Objects!.append(peliculas)
                result.Correct = true
            }
            
            
            //            result.Correct = true
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            //result.Ex = error
        }
        
        return result
    }
    
    func GetAllFavoritos(_ idCount : Int, resp : @escaping(Root<Results>?, Error?)-> Void){
        let defaults = UserDefaults.standard
        let sessionId = defaults.string(forKey: "session_id")
        let url = URL(string: "https://api.themoviedb.org/3/account/\(idCount)/favorite/movies?api_key=\(API_KEY)&session_id=\(sessionId ?? "")")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            let httpResponse = response as! HTTPURLResponse
            if 200...299 ~= httpResponse.statusCode{
                if let dataSource = data{
                    let decoder = JSONDecoder()
                    let jsonString = String(data: dataSource, encoding: String.Encoding.utf8)
                    print(jsonString)
                    let result = try! decoder.decode(Root<Results>.self, from: dataSource)
                    resp(result, nil)
                }
            }
        }.resume()
    }
    
    
}
