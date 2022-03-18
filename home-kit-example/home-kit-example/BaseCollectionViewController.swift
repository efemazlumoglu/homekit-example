//
//  BaseCollectionViewController.swift
//  home-kit-example
//
//  Created by Efe Mazlumoğlu on 18.03.2022.
//

import Foundation
import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        let width = view.frame.size.width / 3
        let height = width + 21
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
    }
}
