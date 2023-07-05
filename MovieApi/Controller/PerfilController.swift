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
    
    var loginviewmodel = LoginViewModel()
    var LoginUsuario : [User] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        UsuarioDetalles()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        collectionFavoritos.register(UINib(nibName: "movieCell", bundle: .main), forCellWithReuseIdentifier: "movieCell")
        collectionFavoritos.delegate = self
        collectionFavoritos.dataSource = self
        
        
    }
    
    func UsuarioDetalles(){
        loginviewmodel.DetailUser(resp:  { result, error in
            if let resultSource = result{
                let usuario = resultSource as User
                print(usuario)
                self.LoginUsuario.append(usuario)
                print(resultSource)
            }
            DispatchQueue.main.async {
                self.collectionFavoritos.reloadData()
            }
        }
                                  
        ) }
}

    extension PerfilController: UICollectionViewDelegate, UICollectionViewDataSource{
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return LoginUsuario.count
           
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! movieCell
            
           
            
            if LoginUsuario[indexPath.row].username == nil{
                lblUsername.text = "Sin username"
                
            }
            else{
                lblUsername.text = LoginUsuario[indexPath.row].username
                
            }
            if LoginUsuario[indexPath.row].avatar.tmdb.avatar_path == nil {
                imagePerfil.image = UIImage(named: "userdefecto")
            }
            else{
                let imagen = LoginUsuario[indexPath.row].avatar.tmdb.avatar_path
                let imagenPer = URL(string: "https://image.tmdb.org/t/p/w500/\(imagen!)")!
                imagePerfil.load(url: imagenPer)
            }
            
            
            return cell
            
            
        }
        }
        
   


