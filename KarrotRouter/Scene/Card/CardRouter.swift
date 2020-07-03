//
//  CardRouter.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

protocol CardRouteLogic: class {
  
  func pushProfileViewController()
}

protocol CardDataPassing: class {
  
  var dataStore: CardDataStore? { get set }
}

class CardRouter: CardDataPassing {
  
  weak var viewController: CardViewController?
  weak var dataStore: CardDataStore?
  
}

// MARK: - Route Logic

extension CardRouter: CardRouteLogic {
  
  func pushProfileViewController() {
    let profileVC = ProfileViewController()
    profileVC.router.dataStore?.user = dataStore?.user
    
    if Bool.random() == true {
      self.viewController?
        .present(
          UINavigationController(rootViewController: profileVC),
          animated: true,
          completion: nil
      )
    } else {
      self.viewController?
        .navigationController?
        .pushViewController(profileVC, animated: true)
    }
  }
}

// MARK: - DataDrain Logic

extension CardRouter: DataDrainable {
  
  func drain(behavior: DataPassingBehavior, from viewController: UIViewController?) {
    switch behavior {
    case .updateCard:
      switch viewController {
      case let vc as CardViewController:
        guard let card = vc.router.dataStore?.card,
          self.dataStore?.card?.id == card.id else {
            return
        }
        
        self.dataStore?.card = card
        self.viewController?.update()
        
      default:
        assertionFailure("undefined \(String(describing: viewController))")
        break
      }
    }
  }
}
