//
//  PlayViewController.swift
//  8402
//
//  Created by Ethan Lillie on 3/2/15.
//  Copyright (c) 2015 Ethan Lillie. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
  
  var cellSelected = false
  var gridMatrix = GridMatrix(rows: 4, columns: 4)
  var controlMatrix = CellMatrix(rows: 4, columns: 4)
  
  @IBOutlet var gridBackgroundView: UIView!
  
  @IBOutlet var cellA1: UIControl!
  @IBOutlet var cellA2: UIControl!
  @IBOutlet var cellA3: UIControl!
  @IBOutlet var cellA4: UIControl!
  @IBOutlet var cellB1: UIControl!
  @IBOutlet var cellB2: UIControl!
  @IBOutlet var cellB3: UIControl!
  @IBOutlet var cellB4: UIControl!
  @IBOutlet var cellC1: UIControl!
  @IBOutlet var cellC2: UIControl!
  @IBOutlet var cellC3: UIControl!
  @IBOutlet var cellC4: UIControl!
  @IBOutlet var cellD1: UIControl!
  @IBOutlet var cellD2: UIControl!
  @IBOutlet var cellD3: UIControl!
  @IBOutlet var cellD4: UIControl!
  
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
      gridBackgroundView.clipsToBounds = false
      
      controlMatrix[0,0] = cellA1
      controlMatrix[0,1] = cellA2
      controlMatrix[0,2] = cellA3
      controlMatrix[0,3] = cellA4
      controlMatrix[1,0] = cellB1
      controlMatrix[1,1] = cellB2
      controlMatrix[1,2] = cellB3
      controlMatrix[1,3] = cellB4
      controlMatrix[2,0] = cellC1
      controlMatrix[2,1] = cellC2
      controlMatrix[2,2] = cellC3
      controlMatrix[2,3] = cellC4
      controlMatrix[3,0] = cellD1
      controlMatrix[3,1] = cellD2
      controlMatrix[3,2] = cellD3
      controlMatrix[3,3] = cellD4
      
      for var i = 0; i<=3; i++ {
        for var j = 0; j<=3; j++ {
          controlMatrix[i,j].addTarget(self, action: "cellHeldDown:", forControlEvents: UIControlEvents.TouchDown)
          controlMatrix[i,j].tag = i*4+j
        }
      }
  
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func cellHeldDown(sender: UIControl!) {
    if cellSelected==false {
      cellSelected = true
      println("\(sender.frame.origin.x)")
      var origin = CGPointZero
      if sender.frame.origin.x >= (80+3*sender.frame.width)/(100+4*sender.frame.width)*self.gridBackgroundView.frame.width*0.9 {
        origin = CGPointMake(sender.frame.origin.x-40-sender.frame.width, sender.frame.origin.y-40-sender.frame.height)
      } else {
        origin = CGPointMake(sender.frame.origin.x-20, sender.frame.origin.y-40-sender.frame.height)
      }
      var twoFour = TwoOrFourViewController(height:40+sender.frame.height, width:60+sender.frame.width*2, origin: origin, control: sender)
      self.gridBackgroundView.addSubview(twoFour.view)
      self.addChildViewController(twoFour)
    }
  }
  
  func twoOrFour(number: Int, control: UIControl) {
    cellSelected = false
    println(control.frame.origin)
    self.addCellatRowAndColumnWithValue(control.tag/4, column: control.tag%4, value: number)
    self.executeMove()
  }
  
  func executeMove() {
    
    var rowOcc = 0
    var columnOcc = 0
    
    var valMatrix = ValMatrix(rows: 4, columns: 4)
    
    for (var i = 0; i<4; i++) {
      for (var j = 0; j<4; j++) {
        valMatrix[i,j] = gridMatrix[i,j].numberValue
        if gridMatrix[i,j].occupied {
          rowOcc+=i+1
          columnOcc+=j+1
        }
      }
    }
    
    gridMatrix.printVals()
    
    if rowOcc-columnOcc > 0{
      if gridMatrix.moveIsValid(1) {
        swipe(1)
      } else if gridMatrix.moveIsValid(4) {
        swipe(4)
      } else if gridMatrix.moveIsValid(3) {
        swipe(3)
      } else if gridMatrix.moveIsValid(2) {
        swipe(2)
      } else {println("game over")}
    } else if rowOcc/columnOcc == 1{
      var random = rand()%2
      if random == 0{
        if gridMatrix.moveIsValid(1) {
          swipe(1)
        } else if gridMatrix.moveIsValid(4) {
          swipe(4)
        } else if gridMatrix.moveIsValid(3) {
          swipe(3)
        } else if gridMatrix.moveIsValid(2) {
          swipe(2)
        } else {println("game over")}
      } else {
        if gridMatrix.moveIsValid(4) {
          swipe(4)
        } else if gridMatrix.moveIsValid(1) {
          swipe(1)
        } else if gridMatrix.moveIsValid(3) {
          swipe(3)
        } else if gridMatrix.moveIsValid(2) {
          swipe(2)
        } else {println("game over")}
      }
    } else {
      if gridMatrix.moveIsValid(4) {
        swipe(4)
      } else if gridMatrix.moveIsValid(1) {
        swipe(1)
      } else if gridMatrix.moveIsValid(3) {
        swipe(3)
      } else if gridMatrix.moveIsValid(2) {
        swipe(2)
      } else {println("game over")}
    }

//    println("current:")
//    gridMatrix.printVals()
//    println("previous:")
//    valMatrix.printVals()
    
  }
  
  func swipe(direction: Int) {
    
    gridMatrix.printVals()
    gridMatrix.resetMatrix()
    
    switch direction {
    case 1:
      println("up")
      for var i = 0; i <= 3; i++ {
        for var j = 1; j <= 3; j++ {
          if gridMatrix[j,i].occupied == true{
            var finalPositionFound = false
            var k = j-1
            while finalPositionFound == false {
              if gridMatrix[k,i].occupied == true {
                if gridMatrix[k,i].numberValue == gridMatrix[j,i].numberValue && gridMatrix[k,i].newlyFormed != true {
                  //merge
                  self.deleteCell(gridMatrix[j,i])
                  gridMatrix[k,i].incrementCellValue()
                  finalPositionFound = true
                } else {
                  if k+1 != j{
                    self.addCellatRowAndColumnWithValue(k+1, column: i, value: gridMatrix[j,i].numberValue)
                    self.deleteCell(gridMatrix[j,i])
                  }
                  finalPositionFound = true
                }
              } else if k == 0 {
                self.addCellatRowAndColumnWithValue(0, column: i, value: gridMatrix[j,i].numberValue)
                self.deleteCell(gridMatrix[j,i])
                finalPositionFound = true
              }
              k--
            }
          }
        }
      }
    case 2:
      println("down")
      
      for var i = 0; i <= 3; i++ {
        for var j = 2; j >= 0; j-- {
          if gridMatrix[j,i].occupied == true{
            var finalPositionFound = false
            var k = j+1
            while finalPositionFound == false {
              if gridMatrix[k,i].occupied == true {
                if gridMatrix[k,i].numberValue == gridMatrix[j,i].numberValue && gridMatrix[k,i].newlyFormed != true {
                  //merge
                  self.deleteCell(gridMatrix[j,i])
                  gridMatrix[k,i].incrementCellValue()
                  finalPositionFound = true
                } else {
                  if k-1 != j{
                    self.addCellatRowAndColumnWithValue(k-1, column: i, value: gridMatrix[j,i].numberValue)
                    self.deleteCell(gridMatrix[j,i])
                  }
                  finalPositionFound = true
                }
              } else if k == 3 {
                self.addCellatRowAndColumnWithValue(3, column: i, value: gridMatrix[j,i].numberValue)
                self.deleteCell(gridMatrix[j,i])
                finalPositionFound = true
              }
              k++
            }
          }
        }
      }
    case 3:
      println("right")
  
      for var i = 0; i <= 3; i++ {
        for var j = 2; j >= 0; j-- {
          if gridMatrix[i,j].occupied == true{
            var finalPositionFound = false
            var k = j+1
            while finalPositionFound == false {
              if gridMatrix[i,k].occupied == true {
                if gridMatrix[i,k].numberValue == gridMatrix[i,j].numberValue && gridMatrix[i,k].newlyFormed != true {
                  //merge
                  self.deleteCell(gridMatrix[i,j])
                  gridMatrix[i,k].incrementCellValue()
                  finalPositionFound = true
                } else {
                  if k-1 != j{
                    self.addCellatRowAndColumnWithValue(i, column: k-1, value: gridMatrix[i,j].numberValue)
                    self.deleteCell(gridMatrix[i,j])
                  }
                  finalPositionFound = true
                }
              } else if k == 3 {
                  self.addCellatRowAndColumnWithValue(i, column: 3, value: gridMatrix[i,j].numberValue)
                self.deleteCell(gridMatrix[i,j])
                finalPositionFound = true
              }
              k++
            }
          }
        }
      }
    case 4:
      println("left")
      for var i = 0; i <= 3; i++ {
        for var j = 1; j <= 3; j++ {
          if gridMatrix[i,j].occupied == true{
            var finalPositionFound = false
            var k = j-1
            while finalPositionFound == false {
              if gridMatrix[i,k].occupied == true {
                if gridMatrix[i,k].numberValue == gridMatrix[i,j].numberValue && gridMatrix[i,k].newlyFormed != true {
                  //merge
                  self.deleteCell(gridMatrix[i,j])
                  gridMatrix[i,k].incrementCellValue()
                  finalPositionFound = true
                } else {
                  if k+1 != j{
                    self.addCellatRowAndColumnWithValue(i, column: k+1, value: gridMatrix[i,j].numberValue)
                    self.deleteCell(gridMatrix[i,j])
                  }
                  finalPositionFound = true
                }
              } else if k == 0 {
                self.addCellatRowAndColumnWithValue(i, column: 0, value: gridMatrix[i,j].numberValue)
                self.deleteCell(gridMatrix[i,j])
                finalPositionFound = true
              }
              k--
            }
          }
        }
      }
    default:
      println("error")
    }
  
    gridMatrix.printVals()
    
  }
  func deleteCell(nvc:NumberViewController) {
    nvc.occupied = false
    nvc.numberValue = 0
    nvc.view.removeFromSuperview()
    nvc.removeFromParentViewController()
  }
  func addCellatRowAndColumnWithValue(row: Int, column: Int, value: Int) {
    var numberCell = NumberViewController(anOrigin: controlMatrix[row,column].frame.origin, aSideLength: controlMatrix[row,column].frame.width, aNumber: value, aRow: row, aColumn: column, occupation: true)
    gridMatrix[row, column] = numberCell
    self.gridBackgroundView.addSubview(numberCell.view)
    self.addChildViewController(numberCell)
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
