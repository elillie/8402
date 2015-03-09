//
//  TwoOrFourViewController.swift
//  8402
//
//  Created by Ethan Lillie on 3/2/15.
//  Copyright (c) 2015 Ethan Lillie. All rights reserved.
//

import UIKit

class TwoOrFourViewController: UIViewController {
  
  var sendingControl = UIControl()
  @IBOutlet var twoControl: UIControl!
  @IBOutlet var fourControl: UIControl!
  
  init(height: CGFloat, width: CGFloat, origin:CGPoint, control: UIControl){
    super.init(nibName: "TwoOrFourViewController", bundle: nil)
    self.view.frame = CGRectMake(origin.x, origin.y, width, height)
    sendingControl = control
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  @IBAction func twoPressed() {
    var parent:PlayViewController = parentViewController as PlayViewController
    parent.twoOrFour(2, control: sendingControl)
    self.view.removeFromSuperview()
    self.removeFromParentViewController()
  }
  @IBAction func fourPressed(sender: AnyObject) {
    var parent:PlayViewController = parentViewController as PlayViewController
    parent.twoOrFour(4, control: sendingControl)
    self.view.removeFromSuperview()
    self.removeFromParentViewController()
  }
  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
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
