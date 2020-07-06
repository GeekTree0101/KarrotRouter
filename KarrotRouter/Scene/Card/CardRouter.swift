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
  var cardUpdatedContext: CardUpdatedDrainContext? { get }
}

class CardRouter: CardDataPassing {
  
  weak var viewController: CardViewController?
  weak var dataStore: CardDataStore?
  
  var cardUpdatedContext: CardUpdatedDrainContext? {
    guard let card = dataStore?.card else { return nil }
    return CardUpdatedDrainContext(card: card)
  }
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
  
  func drain(context: DataDrainContext) {
    switch context {
    case let ctx as CardUpdatedDrainContext:
      guard self.dataStore?.card?.id == ctx.card.id else { return }
      self.dataStore?.card = ctx.card
      self.viewController?.update()
      
    default:
      break
    }
  }
}
