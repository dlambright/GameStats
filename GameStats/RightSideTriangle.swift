//
//  RightSideTriangle.swift
//  GameStats
//
//  Created by Charlie Buckets on 7/20/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

class RightSideTriangle: UIView {
    
    override func drawRect(rect: CGRect) {
        let mask = CAShapeLayer()
        mask.frame = self.layer.bounds
        
        let width = self.layer.frame.size.width
        let height = self.layer.frame.size.height
        
        let path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, 0, height)
        CGPathAddLineToPoint(path, nil, (width - 88), 0)
        CGPathAddLineToPoint(path, nil, width, 0)
        CGPathAddLineToPoint(path, nil, width, height)
        CGPathAddLineToPoint(path, nil, 0, height)
        
        mask.path = path
        
        self.layer.mask = mask
        
    }
    
    
}
