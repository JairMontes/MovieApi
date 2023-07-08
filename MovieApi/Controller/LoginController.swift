//
//  LoginController.swift
//  MovieApi
//
//  Created by Admin on 27/06/23.
//

import UIKit

class LoginController: UIViewController {

    let login = LoginViewModel()
    var guardarUsername : String = ""
    var guardarPassword : String = ""

    
    private let Image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "moviedb" )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true


        return imageView
    }()

    private let txtUsuario: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Username"
            textField.text = "JairMontes"
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height:textField.frame.height))
            textField.leftViewMode = .always
            textField.textAlignment = .left
            textField.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            textField.layer.cornerRadius = CGFloat(floatLiteral: 5)
            textField.backgroundColor = .init(red: 200, green: 202, blue: 206, alpha: 0.5)
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
    
    private let txtPassword: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.text = "12345"
//            textField.textColor = .lightGray
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height:textField.frame.height))
            textField.leftViewMode = .always
            textField.textAlignment = .left
            textField.font = UIFont(name: "Arial Rounded MT", size: 18)
            textField.layer.cornerRadius = CGFloat(floatLiteral: 5)
            textField.backgroundColor = .init(red: 200, green: 202, blue: 206, alpha: 0.5)
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
    
    var lblError : UILabel = {
           let label = UILabel(frame: CGRect(x: 30, y: 630, width: 400, height: 25))
            label.textColor = .orange
        label.font = UIFont(name: "Arial", size: 11.5)
            return label
        }()

    private var btnIngresar : UIButton = {
            var configuration = UIButton.Configuration.filled()
            configuration.title = "Login"
            
            let button = UIButton(frame: CGRect(x: 60, y: 560, width: 272, height: 50))
            button.translatesAutoresizingMaskIntoConstraints = true
            button.tintColor = UIColor.gray
            button.setTitleColor(.white, for: .normal)
            button.configuration = configuration
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            button.tag = 1
            button.backgroundColor = UIColor.lightGray
    
            func action(sender:UIButton!) {
                 print("Button Clicked")
              
              }
            
            return button
        }()
    
   
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            
           // dismiss(animated: true, completion: nil)
            guardarUsername = self.txtUsuario.text!
            print(guardarUsername)
            guardarPassword = self.txtPassword.text!
            print(guardarPassword)
            
            var token : String = ""
            
            login.RequestToken(resp: { [self]result, error in
                        if let resultSource = result{
                            
                            token = resultSource.request_token!
                          
                            self.login.LogIn(username: guardarUsername, password: guardarPassword, requestToken: token , resp: {result, error in
                                if let resultSource = result{
                                    self.login.SessionId(requestToken: token, resp: {result, error in
                                        if let resultSource = result{
                                            
                                            if resultSource.success == true{
                                                let defaults = UserDefaults.standard
                                                defaults.set(resultSource.session_id, forKey: "session_id")
                                                
                                                DispatchQueue.main.async {
                                                    self.performSegue(withIdentifier: "SegueLoginDetalle", sender: self)
                                                    
                                                    self.txtUsuario.text = ""
                                                    self.txtPassword.text = ""
                                                    self.lblError.text =  ""
                                                    
                                                    
                                                }
                                                
                                            }
                                        }
                                        else{
                                            if let errorSource = error{
                                                print("Error de ID Sesion: \(errorSource.status_message)")
                                            }
                                        }
                                    })
                                }
                                else{
                                    if let errorSource = error{
                                        print("Error login: \(errorSource.status_message)")
                                        DispatchQueue.main.async {
                                            self.lblError.isHidden = false
                                            self.lblError.text = errorSource.status_message
                                        }
                                    }
                                }
                            })
                        }
                        else{
                            if let errorSource = error{
                                print("Error Token: \(errorSource.status_message)")
                            }
                        }
                        
                    })
            
        }
        
    }
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login")!)
        view.addSubview(Image)
        view.addSubview(txtUsuario)
        view.addSubview(txtPassword)
        view.addSubview(btnIngresar)
        view.addSubview(lblError)
        
       
        NSLayoutConstraint.activate([
        
            Image.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 180),
                        Image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
                        Image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130),
                        Image.heightAnchor.constraint(equalToConstant: 150),
            
            txtUsuario.topAnchor.constraint(equalTo: Image.bottomAnchor, constant: 20),
                        txtUsuario.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
                        txtUsuario.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
                        txtUsuario.heightAnchor.constraint(equalToConstant: 50),
            
            txtPassword.topAnchor.constraint(equalTo: txtUsuario.bottomAnchor, constant: 20),
                        txtPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
                        txtPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
                        txtPassword.heightAnchor.constraint(equalToConstant: 50),

            btnIngresar.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 20),
                        btnIngresar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
                        btnIngresar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
                        btnIngresar.heightAnchor.constraint(equalToConstant: 50),

            lblError.bottomAnchor.constraint(equalTo: btnIngresar.bottomAnchor, constant: 50),


                            
        ])
        
        
    }
}
