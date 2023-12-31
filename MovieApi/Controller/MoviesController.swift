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
    var moviesaguardar : [Results] = []
    var idPelicula : Int? = 0
    var idSerie : Int? = 0
    var id = 0
    var nombre : String = ""
    var popularity : Float = 0.0
    var original_language : String = ""
    var release_date : String = ""
    var vote_average : Float = 0.0
    var vote_count : Float = 0.0
    var poster_path : String = ""
    var IdCompania : [Int]? = []
    var IdCompañia1 : Int? = 0
    var accountId = 0
    var overview = ""
    var titulo = ""
    var Serie = false
    var loginviewmodel = LoginViewModel()
    var movieViewModel = MovieViewModel()
    var serieviewmodel = SerieViewModel()
    var favoritosviewmodel = FavoritosViewModel()
    var favoritosdetalleviewmodel = FavoritosDetalleViewModel()
    var acccountviewmodel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                Segmento.setTitleTextAttributes(titleTextAttributes, for: .normal)
        view.backgroundColor = .black
        collectionMovies.backgroundColor = .black
        
        collectionMovies.register(UINib(nibName: "movieCell", bundle: .main), forCellWithReuseIdentifier: "movieCell")
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
        
        acccountviewmodel.GetDetails(resp: {result, error in
                    if let resultSource = result{
                        self.accountId = resultSource.id
                    }
                    else{
                        if let errorSource = error{
                            print("Error Get Details en Get Movies: \(errorSource.status_message)")
                        }
                    }
                })
        
        
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
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { (action) in
            
            self.loginviewmodel.LogOut(resp: {result, error in
                            if let resultSource = result{
                                print("LogOut: \(resultSource.success)")
                                UserDefaults.resetStandardUserDefaults()
                                DispatchQueue.main.async {
                                    self.dismiss(animated: true)
           
                                }
                            }
                            if let errorSource = error{
                                print("Error LogOut: \(errorSource.status_message)")
                            }
                        })
                    }
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                        alert.dismiss(animated: true)
                    }
        alert.addAction(logOutAction)
               alert.addAction(cancelAction)
            self.present(alert, animated: false, completion: nil)
        
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
            serieviewmodel.GetAllOnTV{ result, error in
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
            serieviewmodel.GetAllAiringToday{ result, error in
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
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}

    func load(url: URL) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.50) {[weak self] in
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
        
        cell.layer.cornerRadius = 25
        
        if Segmento.selectedSegmentIndex == 0{
            let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(movies[indexPath.row].poster_path)")!
            idPelicula = movies[indexPath.row].id
            cell.lblNombre.text = movies[indexPath.row].original_title
            cell.lblDescripcion.text = movies[indexPath.row].overview
            cell.lblFecha.text = movies[indexPath.row].release_date
            cell.lblPuntuacion.text = movies[indexPath.row].vote_average.description
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/12
//                        cell.layer.cornerRadius = 25
            
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
            
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/12
//                        cell.layer.cornerRadius = 25
            
        }
        
        if Segmento.selectedSegmentIndex == 2{
            let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(onTv[indexPath.row].poster_path)")!
            cell.lblNombre.text = onTv[indexPath.row].original_name
            
            if onTv[indexPath.row].overview == ""{
            cell.lblDescripcion.text = "No hay descripción :("
          
            }else{
            cell.lblDescripcion.text = onTv[indexPath.row].overview
            }
            
            cell.lblFecha.text = onTv[indexPath.row].first_air_date
            cell.lblPuntuacion.text = onTv[indexPath.row].vote_average.description
            
            cell.imagenPelicula.load(url: urlImg)
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/7
            
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/12
//                        cell.layer.cornerRadius = 25
            
        }
        
        if Segmento.selectedSegmentIndex == 3{
            let urlImg = URL(string: "https://image.tmdb.org/t/p/w500/\(airingToday[indexPath.row].poster_path)")!
            cell.lblNombre.text = airingToday[indexPath.row].original_name
            if airingToday[indexPath.row].overview == ""{
            cell.lblDescripcion.text = "No hay descripción :("
          
            }else{
            cell.lblDescripcion.text = airingToday[indexPath.row].overview
            }
            cell.lblFecha.text = airingToday[indexPath.row].first_air_date
            cell.lblPuntuacion.text = airingToday[indexPath.row].vote_average.description
            
            cell.imagenPelicula.load(url: urlImg)
            
            cell.imagenPelicula.layer.cornerRadius = cell.frame.height/12
//                        cell.layer.cornerRadius = 25

            
        }
        cell.btnFavoritos.tag = indexPath.row
        cell.btnFavoritos.addTarget(self, action: #selector(AddFavoritos(_:)), for: .touchUpInside)
        
        cell.layer.cornerRadius = 25
        
        return cell
    }
    
    @objc func AddFavoritos(_ sender: UIButton){
        print("Me estas presionando")
        var idMedia = 0

                if Segmento.selectedSegmentIndex == 0{
                  idMedia = movies[sender.tag].id
                    
                    favoritosviewmodel.AddFavorito(favorite: true, accountId: self.accountId, mediaId: idMedia, mediaType: "movie", resp: {result, error in
                                        if let resultSource = result{
                                            print("Pelicula agregada a favoritos correctamente: \(resultSource.status_message)")
                                        }
                                        if let errorSource = error{
                                            print("Error al agregar pelicula a favoritos: \(errorSource.status_message)")
                                        }
                                    })
                                    
                                    var movie = Movie()
                    movie.id = self.idPelicula!
                                    movie.overview = self.overview
                                    movie.release_date = self.release_date
                                    movie.title = self.titulo
                                    movie.poster_path = self.poster_path
                                    movie.vote_average = self.vote_average
                                    let resultAddMovie = favoritosdetalleviewmodel.AddMovie(movie)
                    if resultAddMovie.Correct{
                        let alert = UIAlertController(title: "Aviso", message: "Película agregada a favoritos", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                            self.dismiss(animated: true)
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        print("Pelicula agregada a CoreData")
                    }
                    else{
                        let alert = UIAlertController(title: "Aviso", message: "Error al agregar película a favoritos", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.dismiss(animated: true)
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        print("Error al agregar pelicula a CoreData \(resultAddMovie.ErrorMessage)")                    }
                }
            

                if Segmento.selectedSegmentIndex == 1{
                    idMedia = moviesTopRated[sender.tag].id
                    
                    favoritosviewmodel.AddFavorito(favorite: true, accountId: self.accountId, mediaId: idMedia, mediaType: "movie", resp: {result, error in
                                        if let resultSource = result{
                                            print("Pelicula agregada a favoritos correctamente: \(resultSource.status_message)")
                                        }
                                        if let errorSource = error{
                                            print("Error al agregar pelicula a favoritos: \(errorSource.status_message)")
                                        }
                                    })

                                    var movie = Movie()
                    movie.id = self.idPelicula!
                                    movie.overview = self.overview
                                    movie.release_date = self.release_date
                                    movie.title = self.titulo
                                    movie.poster_path = self.poster_path
                                    movie.vote_average = self.vote_average
                                    let resultAddMovie = favoritosdetalleviewmodel.AddMovie(movie)
                    if resultAddMovie.Correct{
                        let alert = UIAlertController(title: "Aviso", message: "Película agregada a favoritos", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                            self.dismiss(animated: true)
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        print("Pelicula agregada a CoreData")
                    }
                    else{
                        let alert = UIAlertController(title: "Aviso", message: "Error al agregar película a favoritos", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.dismiss(animated: true)
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        print("Error al agregar pelicula a CoreData \(resultAddMovie.ErrorMessage)")                    }
                }

                    if Segmento.selectedSegmentIndex == 2{
                    idMedia = onTv[sender.tag].id
                    
                        favoritosviewmodel.AddFavorito(favorite: true, accountId: self.accountId, mediaId: idMedia, mediaType: "tv", resp: {result, error in
                                       if let resultSource = result{
                                           print("Serie agregada a favoritos correctamente: \(resultSource.status_message)")
                                       }
                                       if let errorSource = error{
                                           print("Error al agregar serie a favoritos: \(errorSource.status_message)")
                                       }
                                   })

                        var serie = MovieApi.Serie()
                        serie.id = self.idSerie!
                                   serie.overview = self.overview
                                   serie.first_air_date = self.release_date
                                   serie.name = self.titulo
                                   serie.poster_path = self.poster_path
                                   serie.vote_average = self.vote_average
                                   let resultAddSerie = favoritosdetalleviewmodel.AddSerie(serie)
                        if resultAddSerie.Correct{
                            let alert = UIAlertController(title: "Aviso", message: "Serie agregada a favoritos", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                                self.dismiss(animated: true)
                            })
                            
                            alert.addAction(action)
                            self.present(alert, animated: true)
                            print("Serie agregada a CoreData")
                        }
                        else{
                            let alert = UIAlertController(title: "Aviso", message: "Error al agregar serie a favoritos", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                                self.dismiss(animated: true)
                            })
                            
                            alert.addAction(action)
                            self.present(alert, animated: true)
                            print("Error al agregar a CoreData \(resultAddSerie.ErrorMessage)")                 }
                    }
                if Segmento.selectedSegmentIndex == 3{
                    idMedia = airingToday[sender.tag].id
                    
                    favoritosviewmodel.AddFavorito(favorite: true, accountId: self.accountId, mediaId: idMedia, mediaType: "tv", resp: {result, error in
                                   if let resultSource = result{
                                       print("Serie agregada a favoritos correctamente: \(resultSource.status_message)")
                                   }
                                   if let errorSource = error{
                                       print("Error al agregar serie a favoritos: \(errorSource.status_message)")
                                   }
                               })

                    var serie = MovieApi.Serie()
                    serie.id = self.idSerie!
                               serie.overview = self.overview
                               serie.first_air_date = self.release_date
                               serie.name = self.titulo
                               serie.poster_path = self.poster_path
                               serie.vote_average = self.vote_average
                               let resultAddSerie = favoritosdetalleviewmodel.AddSerie(serie)
                    if resultAddSerie.Correct{
                        let alert = UIAlertController(title: "Aviso", message: "Serie agregada a favoritos", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                            self.dismiss(animated: true)
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        print("Serie agregada a CoreData")
                    }
                    else{
                        let alert = UIAlertController(title: "Aviso", message: "Error al agregar serie a favoritos", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.dismiss(animated: true)
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true)
                        print("Error al agregar a CoreData \(resultAddSerie.ErrorMessage)")                 }
                }
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
        self.titulo = movies[indexPath.row].title
        self.overview = movies[indexPath.row].overview
        print(poster_path)
        self.IdCompania = movies[indexPath.row].genre_ids
        self.IdCompañia1 = IdCompania![0]
        self.Serie = false
           
        }
        else if Segmento.selectedSegmentIndex == 1{
            
        self.idPelicula = moviesTopRated[indexPath.row].id
        self.nombre = moviesTopRated[indexPath.row].original_title
        print(nombre)
        self.popularity = moviesTopRated[indexPath.row].popularity
        self.original_language = moviesTopRated[indexPath.row].original_language
        self.release_date = moviesTopRated[indexPath.row].release_date
        self.vote_average = moviesTopRated[indexPath.row].vote_average
        self.vote_count = moviesTopRated[indexPath.row].vote_count
        self.poster_path = moviesTopRated[indexPath.row].poster_path
        self.titulo = moviesTopRated[indexPath.row].title
        self.overview = moviesTopRated[indexPath.row].overview
        self.Serie = false
        }
        else if Segmento.selectedSegmentIndex == 2{
            
        self.idSerie = onTv[indexPath.row].id
        self.nombre = onTv[indexPath.row].name
        self.popularity = onTv[indexPath.row].popularity
        self.original_language = onTv[indexPath.row].original_language
        self.release_date = onTv[indexPath.row].first_air_date
        self.vote_average = onTv[indexPath.row].vote_average
        self.poster_path = onTv[indexPath.row].poster_path
        self.Serie = true
        self.titulo = onTv[indexPath.row].name
        self.overview = onTv[indexPath.row].overview!
        }
        
        else if Segmento.selectedSegmentIndex == 3{
            
            self.idSerie = airingToday[indexPath.row].id
            print(idSerie)
        self.nombre = airingToday[indexPath.row].name
        self.popularity = airingToday[indexPath.row].popularity
        self.original_language = airingToday[indexPath.row].original_language
        self.release_date = airingToday[indexPath.row].first_air_date
        self.vote_average = airingToday[indexPath.row].vote_average
        self.poster_path = airingToday[indexPath.row].poster_path
        self.Serie = true
        self.titulo = airingToday[indexPath.row].name
        self.overview = airingToday[indexPath.row].overview!
        }
        
        
        self.performSegue(withIdentifier: "SegueDetalle", sender: self)
//        self.performSegue(withIdentifier: "SeguePerfil", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueDetalle"{
        let formControl = segue.destination as! DetalleController
        formControl.idSerie = self.idSerie!
        formControl.idPelicula = self.idPelicula!
        formControl.isSerie = self.Serie
        print(Serie)
        formControl.nombre = self.nombre
        formControl.popularity = self.popularity
        formControl.original_language = self.original_language
        formControl.release_date = self.release_date
        formControl.vote_average = self.vote_average
        formControl.vote_count = self.vote_count
        formControl.poster_path = self.poster_path
        formControl.idCompania = self.IdCompañia1
        formControl.accountId = self.accountId
        formControl.id = self.idPelicula!
//        formControl.id = self.id
        formControl.titulo = self.titulo
        formControl.overview = self.overview
    }
//        if segue.identifier == "SeguePerfil"{
//        let formControl = segue.destination as! PerfilController
//        formControl.isSerie = self.Serie
//
//        formControl.idSerie = self.idSerie!
//        print(idSerie)
//        formControl.accountId = self.accountId
//    }
   
    }
    }
    
    
   




    
    
    


