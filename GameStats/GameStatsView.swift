//
//  GameStatsView.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/25/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

class GameStatsView: UIViewController {


    @IBOutlet weak var picHomeTeam: UIImageView!
    @IBOutlet weak var picAwayTeam: UIImageView!
 
    var homeTeamImage: UIImage!
    var awayTeamImage: UIImage!
    
    var statsLine: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picHomeTeam.image = homeTeamImage
        picAwayTeam.image = awayTeamImage
        
    }
    
    func populateGameStatsView(newHomePicture: UIImage, newAwayPicture: UIImage) ->Void{
        homeTeamImage = newHomePicture
        awayTeamImage = newAwayPicture
    }
}
