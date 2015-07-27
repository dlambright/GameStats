//
//  GameCard.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/23/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {


    @IBOutlet weak var picHomeTeam: UIImageView!
    @IBOutlet weak var picAwayTeam: UIImageView!
    
    var homeTeam : String!
    var awayTeam : String!

    @IBOutlet var awayTeamBackground: RightSideTriangle!
    @IBOutlet var homeTeamBackground: TriangleView!

    @IBOutlet var homeTeamScore: UILabel!
    @IBOutlet var awayTeamScore: UILabel!
    

    
    
}
