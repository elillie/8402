//
//  OuterTouchPreservingView.swift
//  8402
//
//  Created by Ethan Lillie on 3/2/15.
//  Copyright (c) 2015 Ethan Lillie. All rights reserved.
//

import UIKit

class OuterTouchPreservingView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    
      var lastViewAdded:UIView = self.subviews.last as UIView
      var pointForTargetView = lastViewAdded.convertPoint(point, fromView: self)
      if CGRectContainsPoint(lastViewAdded.bounds, pointForTargetView) {
        return lastViewAdded.hitTest(pointForTargetView, withEvent: event)
      }
    return super.hitTest(point, withEvent: event)
  }
}
