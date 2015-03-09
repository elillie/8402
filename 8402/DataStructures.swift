//
//  DataStructures.swift
//  8402
//
//  Created by Ethan Lillie on 3/2/15.
//  Copyright (c) 2015 Ethan Lillie. All rights reserved.
//

import UIKit

struct GridMatrix {
  let rows: Int, columns: Int
  var grid: [NumberViewController]
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    self.grid = Array(count: rows*columns, repeatedValue: NumberViewController(anOrigin: CGPointZero, aSideLength: 0, aNumber: 0, aRow: 0, aColumn: 0, occupation: false))
  }
  func indexIsValidForRow(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }
  subscript(row: Int, column: Int) -> NumberViewController {
    get {
      assert(indexIsValidForRow(row, column: column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set(newValue) {
      println(newValue.numberValue)
      assert(indexIsValidForRow(row, column: column), "Index out of range")
      grid[(row * columns) + column] = newValue 
    }
  }
  func printVals() {
    for var i = 0; i<=3; i++ {
      
      println("Before: \(self[i,0].numberValue) \(self[i,1].numberValue) \(self[i,2].numberValue) \(self[i,3].numberValue)\n")
    }
  }
  func resetMatrix() {
    for cell:NumberViewController in grid {
      cell.newlyFormed = false
    }
  }
}

struct CellMatrix {
  let rows: Int, columns: Int
  var grid: [UIControl]
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    self.grid = Array(count: rows*columns, repeatedValue: UIControl())
  }
  func indexIsValidForRow(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }
  subscript(row: Int, column: Int) -> UIControl {
    get {
      assert(indexIsValidForRow(row, column: column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set(newValue) {
      assert(indexIsValidForRow(row, column: column), "Index out of range")
      grid[(row * columns) + column] = newValue
    }
  }
}