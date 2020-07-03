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

private var drainableKey: String = "darainable"

protocol DataEmitable: class {
  var drainable: DataDrainable? { get set }
}

extension DataEmitable where Self: UIViewController {
  
  var drainable: DataDrainable? {
    get {
      return objc_getAssociatedObject(self, &drainableKey) as? DataDrainable
    }
    set {
      objc_setAssociatedObject(self, &drainableKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  func emit(behavior: DataPassingBehavior, from viewController: UIViewController?) {
    viewController?.parentViewControllers.forEach({ vc in
      guard let emitable = vc as? DataEmitable else { return }
      guard let drainable = emitable.drainable else {
        assertionFailure("drainable is null")
        return
      }
      drainable.drain(behavior: behavior, from: viewController)
    })
  }
}

protocol DataDrainable: class {
  
  func drain(behavior: DataPassingBehavior, from viewController: UIViewController?)
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