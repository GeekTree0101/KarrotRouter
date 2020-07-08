//
//  FeedViewController.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

protocol FeedDataStore: class {
  
  var feedItems: [FeedItem] { get set }
}

class FeedViewController: UIViewController, FeedDataStore {
  
  private lazy var tableView: UITableView = {
    let v = UITableView(frame: .zero)
    v.delegate = self
    v.dataSource = self
    v.backgroundColor = .white
    v.rowHeight = 80.0
    v.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    v.tableFooterView = UIView(frame: .zero)
    return v
  }()
  
  var router: (FeedRouteLogic & FeedDataPassing & DataDrainable)!
  var feedItems: [FeedItem] = FeedItem.dummyData()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Feed"
    self.setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    let viewController = self
    let router = FeedRouter()
    
    router.viewController = viewController
    router.dataStore = self
    
    viewController.router = router
    viewController.drainable = router
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(tableView)
  }
  
  override func viewWillLayoutSubviews() {
    self.tableView.frame = self.view.frame
    super.viewWillLayoutSubviews()
  }
  
  public func reload() {
    self.tableView.reloadData()
  }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
  
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
