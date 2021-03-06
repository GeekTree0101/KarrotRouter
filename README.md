# KarrotRouter
Effective Bi-direation dataPassing example for CleanSwift

<img src="https://github.com/GeekTree0101/KarrotRouter/blob/master/res/example.gif" />

# Concept

<img src="https://github.com/GeekTree0101/KarrotRouter/blob/master/res/preview1.png" width=480pt />

- Data-Drain & emit operates on low level boundaries with abstracted context(DataDrainContext)
- Low level boundaries are UIViewController & Router

<img src="https://github.com/GeekTree0101/KarrotRouter/blob/master/res/preview2.png" width=480pt />

- You don't needs callback handler & delegate for update to behind(parent) view controllers
- Data-Emitter flattens the top view controllers except itself.
- Abstracted context(DataDrainContext) is passed to the object that inherits Datadrainable.

# How to use it?

1. Router inherit DataDrainable
```swift

protocol CardRouteLogic: class {
  
  func pushCardViewController(feedID: Int) 
}

protocol CardDataPassing: class {
  
  var dataStore: CardDataStore? { get set }
  var cardUpdatedContext: CardUpdatedDrainContext? { get } // <---- DataDrainContext
}

class CardRouter: CardDataPassing { 

  var cardUpdatedContext: CardUpdatedDrainContext? {
    guard let card = dataStore?.card else { return nil }
    return CardUpdatedDrainContext(card: card)
  }
 }

// MARK: - Route Logic

extension CardRouter: CardRouteLogic { ... }

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
```

2. UIViewController inject drainable
```swift
class CardViewController: UIViewController {
  
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

class CardViewController: UIViewController, CardDataStore {


  @objc func didTapDoneBarButtonItem() {
    self.textView.isEditable = false
    self.card?.content = self.textView.text
    self.textView.resignFirstResponder()
    self.emit(context: router.cardUpdatedContext)  // <--------- emit
    self.update()
  }


}


```
