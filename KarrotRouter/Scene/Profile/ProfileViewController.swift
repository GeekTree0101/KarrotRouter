//
//  ProfileViewController.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

protocol ProfileDataStore: class {
  
  var user: User? { get set }
  var feedItems: [FeedItem] { get set }
}

extension ProfileViewController: DataDrainDataSource {
  
  func getDataDrainableRouter() -> DataDrainable? {
    return self.router
  }
}

class ProfileViewController: UIViewController, ProfileDataStore {
  
  private lazy var tableView: UITableView = {
    let v = UITableView(frame: .zero)
    v.delegate = self
    v.dataSource = self
    v.backgroundColor = .white
    v.rowHeight = 80.0
    v.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return v
  }()
  
  var router: (ProfileRouteLogic & ProfileDataPassing & DataDrainable)!
  
  var user: User?
  var feedItems: [FeedItem] = []
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    let viewController = self
    let router = ProfileRouter()
    
    router.viewController = viewController
    router.dataStore = viewController
    
    viewController.router = router
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.feedItems = FeedItem.dummyData(userID: user?.id ?? -1)
    self.view.addSubview(tableView)
    self.update()
  }
  
  func update() {
    self.title = "\(user?.username ?? "???")님의 프로필"
  }
  
  public func reload() {
    self.tableView.reloadData()
  }
  
  override func viewWillLayoutSubviews() {
    self.tableView.frame = self.view.frame
    super.viewWillLayoutSubviews()
  }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return feedItems.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    
    cell.accessoryType = .disclosureIndicator
    cell.textLabel?.text = feedItems[indexPath.row].card?.title
    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
    cell.textLabel?.textColor = .black
    
    cell.detailTextLabel?.text = feedItems[indexPath.row].card?.content
    cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14.0)
    cell.detailTextLabel?.textColor = .gray
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.isSelected = false
    self.router.pushCardViewController(
      feedID: feedItems[indexPath.row].id
    )
  }
}
