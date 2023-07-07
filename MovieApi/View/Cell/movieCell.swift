//
//  movieCell.swift
//  MovieApi
//
//  Created by Admin on 27/06/23.
//

import UIKit

class movieCell: UICollectionViewCell {

   
    @IBOutlet weak var imagenPelicula: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblPuntuacion: UILabel!
    @IBOutlet weak var btnFavoritos: UIButton!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    
}
