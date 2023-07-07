//
//  PerfilController.swift
//  MovieApi
//
//  Created by Admin on 30/06/23.
//

import UIKit

class PerfilController: UIViewController {
    
    
    @IBOutlet weak var collectionFavoritos: UICollectionView!
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    
    var favoritosviewmodel = FavoritosViewModel()
    var accountviewmodel = AccountViewModel()
    var favoritosdetalleviewmodel = FavoritosDetalleViewModel()
    
    var dataFavoriteMovies : [Movie] = []
    var idAccount = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountviewmodel.GetDetails(resp: {result, error in
            if let resultSource = result{
                DispatchQueue.main.async {
                    self.lblUsername.text = "@\(resultSource.username)"
                    self.idAccount = resultSource.id
                    print("ID ACCOUNT: \(self.idAccount)")
                    
                    if resultSource.avatar.tmdb.avatar_path == nil{
                        self.imagePerfil.image = UIImage(named: "userdefecto")
                    }
                    else{
                        
                        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(resultSource.avatar.tmdb.avatar_path ?? "")")!
                        self.imagePerfil.load(url: url)
                    }
                }
            }
            if let errorSource = error{
                print("Error Account GetDetails: \(errorSource.status_message)")
            }
        })
        
        view.backgroundColor = .black
        collectionFavoritos.backgroundColor = .black
        collectionFavoritos.register(UINib(nibName: "movieCell", bundle: .main), forCellWithReuseIdentifier: "movieCell")
        collectionFavoritos.delegate = self
        collectionFavoritos.dataSource = self
        self.UpdateUI()
        
    }
    
    func UpdateUI(){
        
        favoritosviewmodel.GetFavoriteMovies(resp: {result, error in
            if let resultSource = result{
                for objMovie in resultSource.results{
                    let movie = objMovie as Movie
                    self.dataFavoriteMovies.append(objMovie)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.collectionFavoritos.reloadData()
                }
            }
        })
    
    favoritosviewmodel.GetFavoriteTV(resp: {result, error in
                if let resultSource = result{
                    for objSerie in resultSource.results{
                        let serie = objSerie as Serie
                        var objMovie = Movie()
                        objMovie.id = objSerie.id
                        objMovie.original_title = objSerie.name
                        objMovie.overview = objSerie.overview!
                        objMovie.popularity = objSerie.vote_average
                        objMovie.poster_path = objSerie.poster_path
                        objMovie.release_date = objSerie.first_air_date!
                        objMovie.title = objSerie.name
                        objMovie.vote_average = objSerie.vote_average
                        self.dataFavoriteMovies.append(objMovie)
                    }
                }
            })
            
        }
        
        
    }
    


extension PerfilController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFavoriteMovies.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! movieCell
        
        let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(dataFavoriteMovies[indexPath.row].poster_path)")!
        
        cell.imagenPelicula.load(url: urlImg)
        
        cell.lblNombre.text = dataFavoriteMovies[indexPath.row].title
        cell.lblFecha.text = dataFavoriteMovies[indexPath.row].release_date
        cell.lblPuntuacion.text = String(dataFavoriteMovies[indexPath.row].vote_average)
        if dataFavoriteMovies[indexPath.row].overview == ""{
            cell.lblDescripcion.text = "No hay descripción :("
        }else{
            cell.lblDescripcion.text = dataFavoriteMovies[indexPath.row].overview
        }
        cell.btnFavoritos.isHidden = true
        
        cell.layer.cornerRadius = 25
        return cell
        
        
    }
}
    
    
   
        
    





