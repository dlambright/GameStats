//
//  Game.swift
//  GameStats
//
//  Created by Charlie Buckets on 9/15/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    var awayTeamScore: String
    var homeTeamScore: String
    var gameId: String
    var awayTeam: String
    var homeTeam: String
    var time: String
    
    // Constructor with all fields implemented
    init(newHomeTeamScore: String,
        newAwayTeamScore: String,
        newGameId: String,
        newAwayTeam: String,
        newHomeTeam: String,
        newTime: String){
            awayTeamScore = newAwayTeamScore
            homeTeamScore = newHomeTeamScore
            gameId = newGameId
            awayTeam = newAwayTeam
            homeTeam = newHomeTeam
            time = newTime
            }

}
