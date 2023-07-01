//
//  MoviesController.swift
//  MovieApi
//
//  Created by Admin on 27/06/23.
//

import UIKit

class MoviesController: UIViewController {
    
    @IBOutlet weak var Segmento: UISegmentedControl!
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    var movies : [Results] = []
    var moviesTopRated : [Results] = []
    var onTv : [Results1] = []
    var airingToday : [Results1] = []
    var idPelicula : Int? = 0
    var nombre : String = ""
    var popularity : Float = 0.0
    var original_language : String = ""
    var release_date : String = ""
    var vote_average : Float = 0.0
    var vote_count : Float = 0.0
    var poster_path : String = ""
    var movieViewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionMovies.register(UINib(nibName: "movieCell", bundle: .main), forCellWithReuseIdentifier: "movieCell")
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
        updateUI()
        
        Segmento.addTarget(self, action: #selector(seleccion(_:)), for: .valueChanged)
        
    }
        func updateUI(){
            movieViewModel.GetAllPopular{ result, error in
                if let resultSource = result{
                    for objMovie in resultSource.results{
                        let movie = objMovie as Results
                        print(objMovie)
                        self.movies.append(objMovie)
                        print(resultSource)
                    }
                    DispatchQueue.main.async {
                        self.collectionMovies.reloadData()
                    }
                }

            }

        }
    
//    }
    
    @IBAction func btnNavigationbar(_ sender: Any) {
        
        let alert = UIAlertController(title: "What do you want do?", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "View Profile", style: .default){_ in self.performSegue(withIdentifier: "SeguePerfil", sender: nil)})
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive){_ in self.performSegue(withIdentifier: "SegueLogin", sender: nil)})
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    @objc func seleccion(_ sender : UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            self.updateUI()
        }
        if sender.selectedSegmentIndex == 1{
            movieViewModel.GetAllTopRated{ result, error in
                if let resultSource = result{
                    for objMovie in resultSource.results{
                        let movie = objMovie as Results
                        print(objMovie)
                        self.moviesTopRated.append(objMovie)
                        print(resultSource)
                    }
                    DispatchQueue.main.async {
                        self.collectionMovies.reloadData()
                    }
                }
                
            }
        }
        if sender.selectedSegmentIndex == 2{
            movieViewModel.GetAllOnTV{ result, error in
                if let resultSource = result{
                    for objMovie in resultSource.results{
                        let movie = objMovie as Results1
                        print(objMovie)
                        self.onTv.append(objMovie)
                        print(resultSource)
                    }
                    DispatchQueue.main.async {
                        self.collectionMovies.reloadData()
                    }
                }
                
            }
        }
        if sender.selectedSegmentIndex == 3{
            movieViewModel.GetAllAiringToday{ result, error in
                if let resultSource = result{
                    for objMovie in resultSource.results{
                        let movie = objMovie as Results1
                        print(objMovie)
                        self.airingToday.append(objMovie)
                        print(resultSource)
                    }
                    DispatchQueue.main.async {
                        self.collectionMovies.reloadData()
                    }
                }
            }
        }
    }
}



extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension MoviesController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if Segmento.selectedSegmentIndex == 0{
            return movies.count
        }else if Segmento.selectedSegmentIndex == 1{
            return moviesTopRated.count
        }else if Segmento.selectedSegmentIndex == 2{
            return onTv.count
        }else if Segmento.selectedSegmentIndex == 3{
            return airingToday.count
        }
    else{
        return 1
    }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! movieCell
        
      
        
        if Segmento.selectedSegmentIndex == 0{
            let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(movies[indexPath.row].poster_path)")!
            idPelicula = movies[indexPath.row].id
            cell.lblNombre.text = movies[indexPath.row].original_title
            cell.lblDescripcion.text = movies[indexPath.row].overview
            cell.lblFecha.text = movies[indexPath.row].release_date
            cell.lblPuntuacion.text = movies[indexPath.row].vote_average.description
            
            
            cell.imagenPelicula.load(url: urlImg)
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/8
            
        }
        
        if Segmento.selectedSegmentIndex == 1{
            let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(moviesTopRated[indexPath.row].poster_path)")!
            cell.lblNombre.text = moviesTopRated[indexPath.row].original_title
            cell.lblDescripcion.text = moviesTopRated[indexPath.row].overview
            cell.lblFecha.text = moviesTopRated[indexPath.row].release_date
            cell.lblPuntuacion.text = moviesTopRated[indexPath.row].vote_average.description
            
            cell.imagenPelicula.load(url: urlImg)
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/7
            
        }
        
        if Segmento.selectedSegmentIndex == 2{
            let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(onTv[indexPath.row].poster_path)")!
            cell.lblNombre.text = onTv[indexPath.row].original_name
            cell.lblDescripcion.text = onTv[indexPath.row].overview
            cell.lblFecha.text = onTv[indexPath.row].first_air_date
            cell.lblPuntuacion.text = onTv[indexPath.row].vote_average.description
            
            cell.imagenPelicula.load(url: urlImg)
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/7
            
        }
        
        if Segmento.selectedSegmentIndex == 3{
            let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(airingToday[indexPath.row].poster_path)")!
            cell.lblNombre.text = airingToday[indexPath.row].original_name
            cell.lblDescripcion.text = "No hay descripción"
            cell.lblDescripcion.text = airingToday[indexPath.row].overview
            cell.lblFecha.text = airingToday[indexPath.row].first_air_date
            cell.lblPuntuacion.text = airingToday[indexPath.row].vote_average.description
            
            cell.imagenPelicula.load(url: urlImg)
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/7
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Segmento.selectedSegmentIndex == 0{
        self.idPelicula = movies[indexPath.row].id
        self.nombre = movies[indexPath.row].original_title
        self.popularity = movies[indexPath.row].popularity
        self.original_language = movies[indexPath.row].original_language
        self.release_date = movies[indexPath.row].release_date
        self.vote_average = movies[indexPath.row].vote_average
        self.vote_count = movies[indexPath.row].vote_count
        self.poster_path = movies[indexPath.row].poster_path
        print(poster_path)
           
        }
        else if Segmento.selectedSegmentIndex == 1{
            
        self.idPelicula = movies[indexPath.row].id
           
        self.nombre = movies[indexPath.row].original_title
            print(nombre)
        self.popularity = movies[indexPath.row].popularity
        self.original_language = movies[indexPath.row].original_language
        self.release_date = movies[indexPath.row].release_date
        self.vote_average = movies[indexPath.row].vote_average
        self.vote_count = movies[indexPath.row].vote_count
        self.poster_path = movies[indexPath.row].poster_path
        }
        
        self.performSegue(withIdentifier: "SegueDetalle", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let formControl = segue.destination as! DetalleController
//        formControl.idPelicula = self.idPelicula!
        formControl.nombre = self.nombre
        formControl.popularity = self.popularity
        formControl.original_language = self.original_language
        formControl.release_date = self.release_date
        formControl.vote_average = self.vote_average
        formControl.vote_count = self.vote_count
        formControl.poster_path = self.poster_path
    }
}
    
    
   




    
    
    


