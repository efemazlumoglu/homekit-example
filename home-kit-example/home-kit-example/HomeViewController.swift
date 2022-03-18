//
//  HomeViewController.swift
//  home-kit-example
//
//  Created by Efe Mazlumoğlu on 18.03.2022.
//

import Foundation
import UIKit
import HomeKit

class HomeViewController: BaseCollectionViewController {
    var homes: [HMHome] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Homes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newHome(sender:)))
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! HomeCell
        cell.home = homes[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
      
        let target = navigationController?.storyboard?.instantiateViewController(withIdentifier: "AccessoryViewController") as! AccessoryViewController
        target.home = homes[indexPath.row]
        navigationController?.pushViewController(target, animated: true)
    }
    
    @objc func newHome(sender: UIBarButtonItem) {
        showInputDialog { homeName, roomName in
        // 5. Add new Home + Room
        }
    }
    
    func showInputDialog(_ handler: @escaping ((String, String) -> Void)) {
      let alertController = UIAlertController(title: "Create new Home?",
                                              message: "Enter the name of your new home and give it a Room",
                                              preferredStyle: .alert)
      
      let confirmAction = UIAlertAction(title: "Create", style: .default) { _ in
        guard let homeName = alertController.textFields?[0].text,
              let roomName = alertController.textFields?[1].text else {
          return
        }

        handler(homeName, roomName)
      }
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
      
      alertController.addTextField { textField in
        textField.placeholder = "Enter Home name"
      }
      alertController.addTextField { textField in
        textField.placeholder = "Enter Room name"
      }
      
      alertController.addAction(confirmAction)
      alertController.addAction(cancelAction)
      
      present(alertController, animated: true)
    }
    
    func addHomes(_ homes: [HMHome]) {
      self.homes.removeAll()
      for home in homes {
        self.homes.append(home)
      }
      collectionView?.reloadData()
    }
}
