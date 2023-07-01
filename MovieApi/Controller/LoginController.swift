//
//  LoginController.swift
//  MovieApi
//
//  Created by Admin on 27/06/23.
//

import UIKit

class LoginController: UIViewController {

//    private var Fondo : UIImageView = {
//           let imageView = UIImageView()
//           imageView.contentMode = .scaleAspectFill
//           imageView.image = UIImage (named: "login")
//           imageView.translatesAutoresizingMaskIntoConstraints=false
//           return imageView
//       }()

    
    private let Image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "moviedb" )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true


        return imageView
    }()

    
    var txtUsuario: UITextField = {
           let txtusuario = UITextField()

//           txtusuario.layer.cornerRadius = 10
           txtusuario.backgroundColor = UIColor.white
           txtusuario.layer.borderWidth = 1
           txtusuario.placeholder = "Username"

           txtusuario.translatesAutoresizingMaskIntoConstraints = false
           return txtusuario
      }()

    
    var txtPassword: UITextField = {
        
           let txtfield = UITextField(frame: CGRect(x: 70, y: 540, width: 250, height: 50))

//        txtfield.layer.cornerRadius = 10
        txtfield.backgroundColor = UIColor.white
        txtfield.layer.borderWidth = 1
        txtfield.placeholder = "Password"

           txtfield.translatesAutoresizingMaskIntoConstraints = false
           return txtfield
      }()

    private var btnIngresar : UIButton = {
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Login"
            
            let button = UIButton(frame: CGRect(x: 70, y: 540, width: 250, height: 50))
            button.translatesAutoresizingMaskIntoConstraints = true
            button.tintColor = UIColor.gray
            button.setTitleColor(.white, for: .normal)
            button.configuration = configuration
//            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            button.tag = 1
            button.backgroundColor = UIColor.lightGray
            
            
            func action(sender:UIButton!) {
                 print("Button Clicked")
              }
            
            return button
        }()
    
    var lblError : UILabel = {
            let label = UILabel(frame: CGRect(x: 10, y: 600, width: 550, height: 30))
            label.textColor = .red
            label.text  = "Error"
            label.textAlignment = .center
            return label
        }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login")!)
        view.addSubview(Image)
//        view.addSubview(Fondo)
        view.addSubview(txtUsuario)
        view.addSubview(txtPassword)
        view.addSubview(btnIngresar)
        view.addSubview(lblError)
        
       
        NSLayoutConstraint.activate([
            
//            Fondo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                        Fondo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                        Fondo.bottomAnchor.constraint(equalTo: Image.topAnchor, constant: -30),
         
            
//            Fondo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            Fondo.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),

            Image.leftAnchor.constraint(equalTo: view.leftAnchor),
            Image.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            txtUsuario.bottomAnchor.constraint(equalTo: Image.bottomAnchor, constant: 45),
            txtUsuario.leftAnchor.constraint(equalTo: view.leftAnchor),
            txtUsuario.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            txtPassword.bottomAnchor.constraint(equalTo: txtUsuario.bottomAnchor, constant: 45),
            txtPassword.leftAnchor.constraint(equalTo: view.leftAnchor),
            txtPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnIngresar.bottomAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 80),
            btnIngresar.leftAnchor.constraint(equalTo: view.leftAnchor),
            btnIngresar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblError.bottomAnchor.constraint(equalTo: btnIngresar.bottomAnchor, constant: 80),
            lblError.leftAnchor.constraint(equalTo: view.leftAnchor),
            lblError.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                            
        ])
        
        
    }
}
