//
//  DetalleController.swift
//  MovieApi
//
//  Created by Admin on 30/06/23.
//

import UIKit

class DetalleController: UIViewController {

    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblPopularity: UILabel!
   
    @IBOutlet weak var lblOriginalLanguage: UILabel!
    
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    @IBOutlet weak var lblVoteAverage: UILabel!
    
    @IBOutlet weak var lblVoteCount: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var idPelicula : Int = 0
    var nombre : String = ""
    var popularity : Float = 0.0
    var original_language : String = ""
    var release_date : String = ""
    var vote_average : Float = 0.0
    var vote_count : Float = 0.0
    var poster_path : String = ""
    let urlDefecto = "https://image.tmdb.org/t/p/w500/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        lblNombre.text = String(nombre)
        lblPopularity.text = "Popularity: \(popularity)"
        lblOriginalLanguage.text = "Original Language: \(original_language)"
        lblReleaseDate.text = "Release Date: \(release_date)"
        lblVoteAverage.text = "Vote Average: \(vote_average)"
        lblVoteCount.text = "Vote Count: \(vote_count)"
        let urlImg = URL(string: "\(urlDefecto)\(poster_path)")!
        imageView.load(url: urlImg)
        print(urlImg)
        
    }
    

}
