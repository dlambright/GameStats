//
//  GameStatsView.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/25/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

class GameStatsView: UIViewController{

    @IBOutlet var navBar: UINavigationItem!

    @IBOutlet weak var picHomeTeam: UIImageView!
    @IBOutlet weak var picAwayTeam: UIImageView!
 
    var homeTeamImage: UIImage!
    var awayTeamImage: UIImage!
    
    var homeTeamURL: String!
    var awayTeamURL: String!
    
    var killThread: Bool = false
    
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
        
        getHomeTeamData()
        getAwayTeamData()

    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
        killThread = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        killThread = true
    }
    
    func populateGameStatsView(newHomePicture: UIImage, newAwayPicture: UIImage) ->Void{
        homeTeamImage = newHomePicture
        awayTeamImage = newAwayPicture
    }
    
    func populateHomeTeam(newScore: String, newFGMade: String, newFGAttempted: String, new3PMade: String, new3PAttempted: String, newFTMade: String, newFTAttempted: String, newDReb: String, newOReb: String, newTotalReb: String, newSteals: String, newBlocks: String, newAssists: String, newTSP: String, newWinProb: String)->Void{
        
        lblHomeScore.text = newScore
        lblHomeFG.text = newFGMade + "/" + newFGAttempted
        lblHome3pt.text = new3PMade + "/" + new3PAttempted
        lblHomeFT.text = newFTMade + "/" + newFTAttempted
        lblHomeRebounds.text = newOReb + "/" + newDReb + "/" + newTotalReb
        lblHomeSteals.text = newSteals
        lblHomeBlocks.text = newBlocks
        lblHomeAssists.text = newAssists
        lblHomeTSP.text = newTSP
        lblHomeWinProb.text = newWinProb
        
    }
    
    func populateAwayTeam(newScore: String, newFGMade: String, newFGAttempted: String, new3PMade: String, new3PAttempted: String, newFTMade: String, newFTAttempted: String, newDReb: String, newOReb: String, newTotalReb: String, newSteals: String, newBlocks: String, newAssists: String, newTSP: String, newWinProb: String)->Void{
        
        lblAwayScore.text = newScore
        lblAwayFG.text = newFGMade + "/" + newFGAttempted
        lblAway3pt.text = new3PMade + "/" + new3PAttempted
        lblAwayFT.text = newFTMade + "/" + newFTAttempted
        lblAwayRebounds.text = newOReb + "/" + newDReb + "/" + newTotalReb
        lblAwaySteals.text = newSteals
        lblAwayBlocks.text = newBlocks
        lblAwayAssists.text = newAssists
        lblAwayTSP.text = newTSP
        lblAwayWinProb.text = newWinProb
        
    }
    
    func readHTML(givenURL: String)->NSString{
        let url = NSURL(string: "http://" + givenURL)
        var error: NSError?
        let html = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: &error)
        
        if (error != nil) {
            println("whoops, something went wrong")
        } else {
            //println(html!)
            return html!
        }
        return html!
    }
    
    func getHomeTeamData()->Void{
        let dataString : NSString! = readHTML("192.168.1.81/" + homeTeamURL)
        
        
        let lines = dataString.componentsSeparatedByString("\n")
        

        let mostRecentData = lines[(lines.count-3)].componentsSeparatedByString(",")

        var TSP :Float = mostRecentData[36].floatValue
        var foulShots : Float = mostRecentData[9].floatValue * 0.44
        TSP = mostRecentData[0].floatValue / (2 * (mostRecentData[3].floatValue+(0.44 * mostRecentData[9].floatValue)))
        TSP = Float(round(1000*TSP)/10)
        
        
        populateHomeTeam(mostRecentData[0] as! String,
            newFGMade: mostRecentData[2] as! String,
            newFGAttempted: mostRecentData[3] as! String,
            new3PMade: mostRecentData[5] as! String,
            new3PAttempted: mostRecentData[6] as! String,
            newFTMade: mostRecentData[8] as! String,
            newFTAttempted: mostRecentData[9] as! String,
            newDReb: mostRecentData[12] as! String,
            newOReb: mostRecentData[11] as! String,
            newTotalReb: mostRecentData[13] as! String,
            newSteals: mostRecentData[15] as! String,
            newBlocks: mostRecentData[16] as! String,
            newAssists: mostRecentData[14] as! String,
            newTSP: TSP.description + "%",
            newWinProb: "TBD")
    }
    
    func getAwayTeamData()->Void{
        let dataString : NSString! = readHTML("192.168.1.81/" + awayTeamURL)
        
        let lines = dataString.componentsSeparatedByString("\n")
        let mostRecentData = lines[(lines.count-3)].componentsSeparatedByString(",")
        
        var TSP :Float = mostRecentData[36].floatValue
        var foulShots : Float = mostRecentData[9].floatValue * 0.44
        TSP = mostRecentData[0].floatValue / (2 * (mostRecentData[3].floatValue+(0.44 * mostRecentData[9].floatValue)))
        TSP = Float(round(1000*TSP)/10)
        
        
        populateAwayTeam(mostRecentData[0] as! String,
            newFGMade: mostRecentData[2] as! String,
            newFGAttempted: mostRecentData[3] as! String,
            new3PMade: mostRecentData[5] as! String,
            new3PAttempted: mostRecentData[6] as! String,
            newFTMade: mostRecentData[8] as! String,
            newFTAttempted: mostRecentData[9] as! String,
            newDReb: mostRecentData[12] as! String,
            newOReb: mostRecentData[11] as! String,
            newTotalReb: mostRecentData[13] as! String,
            newSteals: mostRecentData[15] as! String,
            newBlocks: mostRecentData[16] as! String,
            newAssists: mostRecentData[14] as! String,
            newTSP: TSP.description + "%",
            newWinProb: "TBD")
    }
    
    
    func refreshData(){
        let qualityOfServiceClass = Int(QOS_CLASS_BACKGROUND.value)
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(dispatch_get_global_queue(qualityOfServiceClass,0)){ () -> Void in
            
            while self.killThread == false{
                sleep(2)
                dispatch_async(dispatch_get_main_queue()){
                    self.getAwayTeamData()
                    self.getHomeTeamData()
                }
            }
        }
    }
}
