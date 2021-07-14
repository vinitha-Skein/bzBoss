//
//  DonutView.swift
//  JustACircle
//
//  Created by Anne on 23/3/20.
//  Copyright © 2020 Anne Hanw. All rights reserved.
//

import UIKit

@IBDesignable
class DonutView: UIView {
var selectedColor = UIColor(red: 29/255, green: 138/255, blue: 254/255, alpha: 1)

	@IBInspectable var goal: Int = 4{
	  didSet {
		  //the view needs to be refreshed, this trigger draw
		  setNeedsDisplay()
		}
	}
	
	@IBInspectable var progress: Int = 1 {
	  didSet {
		if progress <=  goal {
		  //the view needs to be refreshed, this trigger draw
		  setNeedsDisplay()
		}
	  }
	}
    @IBInspectable var progressColor: UIColor = .red {
      didSet {

          //the view needs to be refreshed, this trigger draw
          setNeedsDisplay()
      }
    }


    override func draw(_ rect: CGRect)
    {
		//center is half diameter (width or height of rect)
		let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
		
		//radius is half diameter
		let radius: CGFloat = bounds.width / 2
		
		//the width of donut line or how thick the donut should be
		let arcWidth: CGFloat = radius / 4

        let donut = UIBezierPath(arcCenter: center,
								//line width (arcWidth) occupy space half in and half out of circumference line
								//we divide that by 2 to move half the line into the circle area (donut hole)
								radius: radius - arcWidth/2,
								
								//start at the right of circle or 0 radians
								startAngle: 0,
								
								//end where it starts, or 2 pi radian
								endAngle: 2 * .pi,
								clockwise: true)
		
		//don't forget to set the donut width
		donut.lineWidth = arcWidth
		UIColor.lightGray.setStroke()
		
		//actually perform drawing stroke
		donut.stroke()
		
		//show progress of donut (in red color)
		
		//whole donut is 2 pi radian
		let angleDifference: CGFloat = 2 * .pi
		
		//whole donut devided eqully by goal
		let pathPerGoal: CGFloat = angleDifference / CGFloat(goal)
		
		//end is calculated by progress part + starting point
		//I want starting point to be at the bottom which is pi/2 radian
        let endAngle = pathPerGoal * CGFloat(progress) + .pi/2

		
		let progressDonut = UIBezierPath(arcCenter: center,
										 //line width (arcWidth) occupy space half in and half out of circumference line
										 radius: radius - arcWidth/2,
										 //I want starting point to be at the bottom which is pi/2 radian
                                         startAngle: .pi/2,
										 endAngle: endAngle,
										 clockwise: true)
		
		progressDonut.lineWidth = arcWidth
		progressColor.setStroke()
		progressDonut.stroke()
		

    }
	

}
