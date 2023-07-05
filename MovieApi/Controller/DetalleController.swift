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
    @IBOutlet weak var collectionCompanies: UICollectionView!
    
    var companie : [Companie] = []
    var idCompania : Int? = 0
    var id = 0
    var idPelicula : Int = 0
    var idSerie : Int? = 0
    var Serie = false
    var nombre : String = ""
    var popularity : Float = 0.0
    var original_language : String = ""
    var release_date = ""
    var vote_average : Float = 0.0
    var vote_count : Float = 0.0
    var poster_path = ""
    var accountId = 0
    var overview = ""
    var titulo = ""
    let urlDefecto = "https://image.tmdb.org/t/p/w500/"
    var movieViewModel = MovieViewModel()
    var favoritosviewmodel = FavoritosViewModel()
    var favoritesCDViewModel = FavoritosDetalleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        collectionCompanies.backgroundColor = .black
        
        print(idPelicula)
        print(idSerie)
        print(Serie)
        lblNombre.text = String(nombre)
        lblPopularity.text = "Popularity: \(popularity)"
        lblOriginalLanguage.text = "Original Language: \(original_language)"
        lblReleaseDate.text = "Release Date: \(release_date)"
        lblVoteAverage.text = "Vote Average: \(vote_average)"
        lblVoteCount.text = "Vote Count: \(vote_count)"
        let urlImg = URL(string: "\(urlDefecto)\(poster_path)")!
        imageView.load(url: urlImg)
        
        collectionCompanies.register(UINib(nibName: "companieCell", bundle: .main), forCellWithReuseIdentifier: "companieCell")
        collectionCompanies.delegate = self
        collectionCompanies.dataSource = self
        
        updateUI()
        
    }
    
    @IBAction func btnFavoritos(_ sender: Any) {
        
        favoritosviewmodel.AddFavorito(favorite: true, accountId: self.accountId, mediaId: self.id, mediaType: "movie", resp: {result, error in
                            if let resultSource = result{
                                print("Pelicula agregada a favoritos correctamente: \(resultSource.status_message)")
                            }
                            if let errorSource = error{
                                print("Error al agregar pelicula a favoritos: \(errorSource.status_message)")
                            }
                        })
                        
                        var movie = Movie()
                        movie.id = self.id
                        movie.overview = self.overview
                        movie.release_date = self.release_date
                        movie.title = self.titulo
                        movie.poster_path = self.poster_path
                        movie.vote_average = self.vote_average
                        let resultAddMovie = favoritesCDViewModel.AddMovie(movie)
        if resultAddMovie.Correct!{
                            print("Pelicula agregada a CoreData")
                        }
                        else{
                            print("Error al agregar pelicula a CoreData \(resultAddMovie.ErrorMessage)")
                        }
                    }
                
    
    
    
    func updateUI(){
        
//        if Serie{
            movieViewModel.GetDetail(idPelicula, resp:  { result, error in
                if let resultSource = result{
                    for objCompany in resultSource.production_companies{
                        let _ = objCompany as Companie
                        print(objCompany)
                        self.companie.append(objCompany)
                    }
                }
                DispatchQueue.main.async {
                    self.collectionCompanies.reloadData()
                }
            }
                                           
            ) }
//        else{
//            movieViewModel.GetDetail(idPelicula, resp: {result, error in
//                if let resultSource = result{
//                    for objCompany in resultSource.production_companies{
//                        let _ = objCompany as Companie
//                        print(objCompany)
//                        self.companie.append(objCompany)
//                    }
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//                    self.collectionCompanies.reloadData()
//                }
//            })
//        }
//    }
}



extension DetalleController : UICollectionViewDelegate, UICollectionViewDataSource{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
                // #warning Incomplete implementation, return the number of sections
                return 1
            }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companieCell", for: indexPath) as! companieCell
        
        if companie[indexPath.row].logo_path == nil{
                        cell.imageCompanie.image = UIImage(named: "sinImagen")
                        cell.lblNombre.text = companie[indexPath.row].name
//                        cell.lblSede.text = companie[indexPath.row].headquarters
                        
                    }
                    else{
                        let imagen = companie[indexPath.row].logo_path!
                        cell.lblNombre.text = companie[indexPath.row].name
//                        cell.lblSede.text = companie[indexPath.row].headquarters
                        
                        let urlImgProductoras = URL(string: "https://image.tmdb.org/t/p/w500/\(imagen)")!
                        print(urlImgProductoras)
                        cell.imageCompanie.load(url: urlImgProductoras)
                    }
        
        return cell
    }
    
    
}
