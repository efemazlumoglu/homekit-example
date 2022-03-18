//
//  AccessoryViewController.swift
//  home-kit-example
//
//  Created by Efe Mazlumoğlu on 18.03.2022.
//

import Foundation
import UIKit
import HomeKit

class AccessoryViewController: BaseCollectionViewController {
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var accessories: [HMAccessory] = []
    var home: HMHome?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(home?.name ?? "") Accessories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(discoverAccessories(sender:)))
        
        loadAccessories()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return accessories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let accessory = accessories[indexPath.row]
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! AccessoryCell
      cell.accessory = accessory
      
      return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      collectionView.deselectItem(at: indexPath, animated: true)
          
      // 7. Handle touches which toggle the state of the lightbulb
    }
    
    private func loadAccessories() {
      // 5. Load accessories
      
      collectionView?.reloadData()
    }
    
    @objc func discoverAccessories(sender: UIBarButtonItem) {
      activityIndicator.startAnimating()
      navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
      
      // 2. Start discovery
    }
    
    @objc private func stopDiscoveringAccessories() {
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(discoverAccessories(sender:)))
      // 4. Stop discovering
    }
    
    private func addAccessories(_ accessories: [HMAccessory]) {
      for accessory in accessories {
        home?.addAccessory(accessory) { [weak self] error in
          guard let self = self else {
            return
          }
          if let error = error {
            print("Failed to add accessory to home: \(error.localizedDescription)")
          } else {
            self.loadAccessories()
          }
        }
      }
    }
}

extension HMAccessory {
    func find(serviceType: String, characteristicType: String) -> HMCharacteristic? {
      return services.lazy
        .filter { $0.serviceType == serviceType }
        .flatMap { $0.characteristics }
        .first { $0.metadata?.format == characteristicType }
    }
}
