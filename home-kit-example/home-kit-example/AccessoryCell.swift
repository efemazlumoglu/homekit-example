//
//  AccessoryCell.swift
//  home-kit-example
//
//  Created by Efe Mazlumoğlu on 18.03.2022.
//

import Foundation
import UIKit
import HomeKit

class AccessoryCell: UICollectionViewCell {
    enum LightbulbState: String {
        case on
        case off
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    var accessory: HMAccessory? {
        didSet {
            if let accessory = accessory {
                label.text = accessory.name
                
                let state = getLightbulbState(accessory)
                imageView.image = UIImage(named: state.rawValue)
            }
        }
    }
    
    private func getLightbulbState(_ accessory: HMAccessory) -> LightbulbState {
      guard let characteristic = accessory.find(serviceType: HMServiceTypeLightbulb, characteristicType: HMCharacteristicMetadataFormatBool),
        let value = characteristic.value as? Bool else {
          return .off
      }
      
      return value ? .on : .off
    }
}
