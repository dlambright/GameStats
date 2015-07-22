//
//  TriangleView.swift
//  GameStats
//
//  Created by Charlie Buckets on 7/20/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

class TriangleView: UIView {

    override func drawRect(rect: CGRect) {
        var mask = CAShapeLayer()
        mask.frame = self.layer.bounds
        
        let width = self.layer.frame.size.width
        let height = self.layer.frame.size.height
        
        var path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, width, 0)
        CGPathAddLineToPoint(path, nil, width - (width - 78), height)
        CGPathAddLineToPoint(path, nil, 0, height)
        CGPathAddLineToPoint(path, nil, 0, 0)
        
        mask.path = path
        
        self.layer.mask = mask
        
    }
}
