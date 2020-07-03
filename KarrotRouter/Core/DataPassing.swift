//
//  DataPassing.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/02.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

enum DataPassingBehavior {
  
  case updateCard
}

protocol DataDrainDataSource: class {
  
  func getDataDrainableRouter() -> DataDrainable?
}

protocol DataDrainable: class {
  
  func drain(behavior: DataPassingBehavior, from viewController: UIViewController?)
}

extension DataDrainable {
  func emit(behavior: DataPassingBehavior, from viewController: UIViewController?) {
    viewController?.parentViewControllers.forEach({ vc in
      (vc as? DataDrainDataSource)?
        .getDataDrainableRouter()?
        .drain(behavior: behavior, from: viewController)
    })
  }
}

extension UIViewController {
  
  fileprivate var parentViewControllers: [UIViewController] {
    return relatedViewControllers(from: self, child: []).filter({ $0 != self })
  }
  
  private func relatedViewControllers(from viewController: UIViewController?, child: [UIViewController]) -> [UIViewController] {
    
    if let nav = viewController?.navigationController {
      return self.relatedViewControllers(
        from: nav.presentingViewController,
        child: Array(nav.children.reversed()) + Array(child.reversed())
      )
    } else if let nav = viewController as? UINavigationController {
      return self.relatedViewControllers(
        from: nav.presentingViewController,
        child: Array(nav.children.reversed()) + Array(child.reversed())
      )
    } else {
      return child
    }
  }
}
