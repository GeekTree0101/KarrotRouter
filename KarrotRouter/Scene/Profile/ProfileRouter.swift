//
//  ProfileRouter.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

protocol ProfileRouteLogic: class {
  
  func pushCardViewController(feedID: Int) 
}

protocol ProfileDataPassing: class {
  
  var dataStore: ProfileDataStore? { get set }
}

class ProfileRouter: ProfileDataPassing {
  
  weak var viewController: ProfileViewController?
  weak var dataStore: ProfileDataStore?
  
}

// MARK: - Route Logic

extension ProfileRouter: ProfileRouteLogic {
  
  func pushCardViewController(feedID: Int) {
    
    guard let feedItem = dataStore?.feedItems
      .first(where: { $0.id == feedID }) else {
      return
    }
    
    let cardVC = CardViewController()
    
    cardVC.router.dataStore?.card = feedItem.card
    cardVC.router.dataStore?.user = feedItem.user
    
    if Bool.random() == true {
      self.viewController?.present(
        UINavigationController(rootViewController: cardVC),
        animated: true,
        completion: nil
      )
    } else {
      self.viewController?
        .navigationController?
        .pushViewController(cardVC, animated: true)
    }
  }
}

// MARK: - DataDrain Logic

extension ProfileRouter: DataDrainable {
  
  var currentContext: DataDrainContext? {
    return nil
  }
  
  func drain(context: DataDrainContext) {
    switch context {
    case let ctx as CardUpdatedDrainContext:
      guard let items = self.dataStore?.feedItems,
        let index = items.firstIndex(where: { $0.card?.id == ctx.card.id }) else { return }
      self.dataStore?.feedItems[index].card = ctx.card
      self.viewController?.reload()
      
    default:
      break
    }
  }
}
