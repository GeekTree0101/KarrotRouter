//
//  DataDrainable.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/03.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import UIKit

protocol DataDrainable: class {
  
  func drain(context: DataDrainContext)
}
