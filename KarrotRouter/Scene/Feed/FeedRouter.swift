//
//  FeedRouter.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

protocol FeedRouteLogic: class {
  
  func pushCardViewController(feedID: Int)
}

protocol FeedDataPassing: class {
  
  var dataStore: FeedDataStore? { get set }
}

class FeedRouter: FeedDataPassing {
  
  weak var viewController: FeedViewController?
  weak var dataStore: FeedDataStore?
  
}

// MARK: - Route Logic

extension FeedRouter: FeedRouteLogic {
  
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

extension FeedRouter: DataDrainable {
  
  func drain(behavior: DataPassingBehavior, from viewController: UIViewController?) {
    switch behavior {
    case .updateCard:
      switch viewController {
      case let vc as CardViewController:
        guard let card = vc.router.dataStore?.card,
          let index = self.dataStore?.feedItems.firstIndex(where: {
            $0.card?.id == card.id
          }) else {
            return
        }
        
        self.dataStore?.feedItems[index].card = card
        self.viewController?.reload()
        
      default:
        assertionFailure("undefined \(String(describing: viewController))")
        break
      }
    }
  }
}
