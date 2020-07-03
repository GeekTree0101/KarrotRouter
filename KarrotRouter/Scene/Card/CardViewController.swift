//
//  CardViewController.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

protocol CardDataStore: class {
  
  var card: Card? { get set }
  var user: User? { get set }
}

extension CardViewController: DataDrainDataSource {
  
  func getDataDrainableRouter() -> DataDrainable? {
    return self.router
  }
}

class CardViewController: UIViewController, CardDataStore {
  
  private lazy var editButton = UIBarButtonItem(
    barButtonSystemItem: .edit,
    target: self,
    action: #selector(didTapEditBarButtonItem)
  )
  
  private lazy var doneButton = UIBarButtonItem(
    barButtonSystemItem: .done,
    target: self,
    action: #selector(didTapDoneBarButtonItem)
  )
  
  
  @IBOutlet weak var usernameButton: UIButton!
  
  @IBOutlet weak var titleView: UILabel!
  @IBOutlet weak var textView: UITextView! {
    didSet {
      textView.isEditable = false
      textView.font = UIFont.systemFont(ofSize: 20.0)
    }
  }
  
  var router: (CardRouteLogic & CardDataPassing & DataDrainable)!
  
  var card: Card?
  var user: User?
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func setup() {
    let viewController = self
    let router = CardRouter()
    
    router.viewController = viewController
    router.dataStore = viewController
    
    viewController.router = router
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.update()
  }
  
  func update() {
    self.titleView.text = card?.title
    self.textView.text = card?.content
    
    usernameButton.setTitle(
      "\(user?.username ?? "???")님에 대해서 더 자세히 알아보기",
      for: .normal
    )
    
    if self.textView.isEditable {
      self.navigationItem.rightBarButtonItem = doneButton
    } else {
      self.navigationItem.rightBarButtonItem = editButton
    }
  }
  
  @IBAction func didTapGoToProfile(_ sender: Any) {
    self.router?.pushProfileViewController()
  }
}

// MARK: - Action

extension CardViewController {
  
  @objc func didTapEditBarButtonItem() {
    self.textView.isEditable = true
    self.textView.becomeFirstResponder()
    self.update()
  }
  
  @objc func didTapDoneBarButtonItem() {
    self.textView.isEditable = false
    self.card?.content = self.textView.text
    self.textView.resignFirstResponder()
    self.router.emit(behavior: .updateCard, from: self)
    self.update()
  }
  
}
