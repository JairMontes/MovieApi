//
//  FavoritosDetalleViewModel.swift
//  MovieApi
//
//  Created by Admin on 05/07/23.
//

import Foundation
import CoreData
import UIKit

class FavoritosDetalleViewModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func AddMovie(_ movie : Movie) -> Result {
            
        var result = Result()
       
        do{
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "FavMovies", in: context)
            let movieObj = NSManagedObject(entity: entity!, insertInto: context)
            
            // Primero: Que se inserta. Segundo: En donde (columna/llave)
            movieObj.setValue(movie.id, forKey: "id")
            movieObj.setValue(movie.overview, forKey: "overview")
            movieObj.setValue(movie.original_title, forKey: "original_title")
            movieObj.setValue(movie.poster_path, forKey: "poster_path")
            movieObj.setValue(movie.title, forKey: "title")
            movieObj.setValue(movie.popularity, forKey: "popularity")
            movieObj.setValue(movie.release_date, forKey: "release_date")
            movieObj.setValue(movie.vote_average, forKey: "vote_average")
            
            // Guardar
            try context.save()
            
            result.Correct = true
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
//                result.Ex = error
            
        }
        
        return result
    }
    
    
    func AddSerie(_ serie : Serie) -> Result {
           
           var result = Result()
          
           do{
               let context = appDelegate.persistentContainer.viewContext
               let entity = NSEntityDescription.entity(forEntityName: "FavSeries", in: context)
               let serieObj = NSManagedObject(entity: entity!, insertInto: context)
               
               // Primero: Que se inserta. Segundo: En donde (columna/llave)
               serieObj.setValue(serie.id, forKey: "id")
               serieObj.setValue(serie.overview, forKey: "overview")
               serieObj.setValue(serie.poster_path, forKey: "poster_path")
               serieObj.setValue(serie.name, forKey: "name")
               
               serieObj.setValue(serie.vote_average, forKey: "vote_average")
               serieObj.setValue(serie.first_air_date, forKey: "first_air_date")
               // Guardar
               try context.save()
               
               result.Correct = true
           }
           catch let error{
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               
           }
           
           return result
       }
}

