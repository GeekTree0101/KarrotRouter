//
//  DataDrainContext.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/06.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import Foundation

protocol DataDrainContext {
  
}

// MARK: - DataDrainContexts

struct CardUpdatedDrainContext: DataDrainContext {
  
  var card: Card
}
