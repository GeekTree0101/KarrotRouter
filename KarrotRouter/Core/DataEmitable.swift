//
//  DataEmitable.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/03.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

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
    viewController?.behindViewControllers.forEach({ vc in
      guard let emitable = vc as? DataEmitable else { return }
      guard let drainable = emitable.drainable else {
        assertionFailure("drainable is null")
        return
      }
      drainable.drain(behavior: behavior, from: viewController)
    })
  }
}

extension UIViewController {
  
  fileprivate var behindViewControllers: [UIViewController] {
    return findBehindViewControllers(from: self, child: []).filter({ $0 != self })
  }
  
  private func findBehindViewControllers(from viewController: UIViewController?, child: [UIViewController]) -> [UIViewController] {
    
    if let nav = viewController?.navigationController {
      return self.findBehindViewControllers(
        from: nav.presentingViewController,
        child: Array(nav.children.reversed()) + Array(child.reversed())
      )
    } else if let nav = viewController as? UINavigationController {
      return self.findBehindViewControllers(
        from: nav.presentingViewController,
        child: Array(nav.children.reversed()) + Array(child.reversed())
      )
    } else {
      return child
    }
  }
}
