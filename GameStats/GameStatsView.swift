//
//  GameStatsView.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/25/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

class GameStatsView: UIViewController {

    @IBOutlet var navBar: UINavigationItem!

    @IBOutlet weak var picHomeTeam: UIImageView!
    @IBOutlet weak var picAwayTeam: UIImageView!
 
    var homeTeamImage: UIImage!
    var awayTeamImage: UIImage!
    
    var homeTeamURL: String!
    var awayTeamURL: String!
    
    var statsLine: String!
    
    @IBOutlet var lblHomeScore: UILabel!
    @IBOutlet var lblHomeFG: UILabel!
    @IBOutlet var lblHome3pt: UILabel!
    @IBOutlet var lblHomeFT: UILabel!
    @IBOutlet var lblHomeRebounds: UILabel!
    @IBOutlet var lblHomeSteals: UILabel!
    @IBOutlet var lblHomeBlocks: UILabel!
    @IBOutlet var lblHomeAssists: UILabel!
    @IBOutlet var lblHomeTSP: UILabel!
    @IBOutlet var lblHomeWinProb: UILabel!
    
    @IBOutlet var lblAwayScore: UILabel!
    @IBOutlet var lblAwayFG: UILabel!
    @IBOutlet var lblAway3pt: UILabel!
    @IBOutlet var lblAwayFT: UILabel!
    @IBOutlet var lblAwayRebounds: UILabel!
    @IBOutlet var lblAwaySteals: UILabel!
    @IBOutlet var lblAwayBlocks: UILabel!
    @IBOutlet var lblAwayAssists: UILabel!
    @IBOutlet var lblAwayTSP: UILabel!
    @IBOutlet var lblAwayWinProb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picHomeTeam.image = homeTeamImage
        picAwayTeam.image = awayTeamImage
        navBar.title = homeTeamURL + "     vs     " + awayTeamURL
        
        let url: NSURL = NSURL(string: "localhost/" + homeTeamURL)!
        //readHTML(url)
        
        
    }
    
    func populateGameStatsView(newHomePicture: UIImage, newAwayPicture: UIImage) ->Void{
        homeTeamImage = newHomePicture
        awayTeamImage = newAwayPicture
        
        
        
        
        
        
    }
    
    func readHTML(givenURL: NSURL)->Void{
        var e: NSError?
        let string = NSString(contentsOfURL: givenURL, encoding: NSUTF8StringEncoding, error: &e)
    }
}
