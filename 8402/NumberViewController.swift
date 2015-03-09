//
//  NumberViewController.swift
//  8402
//
//  Created by Ethan Lillie on 3/2/15.
//  Copyright (c) 2015 Ethan Lillie. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController {
  
  @IBOutlet var numberLabel: UILabel!
  var newlyFormed: Bool = false
  var occupied: Bool = false
  var numberValue: Int = 0
  var row: Int = 0
  var column: Int = 0
  var origin: CGPoint = CGPointZero
  var sideLength: CGFloat = 0
  
  init(anOrigin: CGPoint, aSideLength: CGFloat, aNumber:Int, aRow: Int, aColumn: Int, occupation: Bool) {
    
    super.init(nibName: "NumberViewController", bundle: nil)
    self.view.frame = CGRectMake(anOrigin.x, anOrigin.y, aSideLength, aSideLength)
    numberLabel.text = "\(aNumber)"
    self.occupied = occupation
    self.numberValue = aNumber
    self.row = aRow
    self.column = aColumn
    self.sideLength = aSideLength
    self.origin = anOrigin
  }
  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func moveCell(origin: CGPoint) {
    self.view.frame = CGRectMake(origin.x, origin.y, self.view.frame.width, self.view.frame.height)
  }
  func incrementCellValue(){
    self.numberValue = self.numberValue*2
    numberLabel.text = "\(self.numberValue)"
    self.newlyFormed = true
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
