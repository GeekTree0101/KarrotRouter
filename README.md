# KarrotRouter
Effective Bi-direation dataPassing example for CleanSwift

<img src="https://github.com/GeekTree0101/KarrotRouter/blob/master/res/example.gif" />

# How to use it?

1. Router inherit DataDrainable
```swift

protocol CardRouteLogic: class {
  
  func pushCardViewController(feedID: Int) 
}

protocol CardDataPassing: class {
  
  var dataStore: CardDataStore? { get set }
}

class CardRouter: CardDataPassing { ... }

// MARK: - Route Logic

extension CardRouter: CardRouteLogic { ... }

// MARK: - DataDrain Logic

extension CardRouter: DataDrainable {
  
  func drain(behavior: DataPassingBehavior, from viewController: UIViewController?) {
    switch behavior {                     // <-------------- select behavior kind
    case .updateCard:
      switch viewController {
      case let vc as CardViewController:  // <-------------- data-passing
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
```

2. UIViewController inherit Emitable & inject drainable
```swift
class CardViewController: UIViewController, DataEmitable {
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    let viewController = self
    let router = CardRouter()
    
    router.viewController = viewController
    router.dataStore = viewController
    
    viewController.router = router
    viewController.drainable = router       // <---------- inject router to drainable
  }
}

```

3. emit with behavior from UIViewController

```swift

class CardViewController: UIViewController, CardDataStore, DataEmitable {


  @objc func didTapDoneBarButtonItem() {
    self.textView.isEditable = false
    self.card?.content = self.textView.text
    self.textView.resignFirstResponder()
    self.emit(behavior: .updateCard, from: self)  // <--------- emit
    self.update()
  }


}


```
