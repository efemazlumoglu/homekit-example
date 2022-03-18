//
//  HomeCell.swift
//  home-kit-example
//
//  Created by Efe Mazlumoğlu on 18.03.2022.
//

import Foundation
import UIKit
import HomeKit

class HomeCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    var home: HMHome? {
        didSet {
            if let home = home {
                label.text = home.name
            }
        }
    }
}
