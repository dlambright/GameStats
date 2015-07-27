//
//  ViewController.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/18/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var piOrLocal: String = "192.168.1.81/"
    var piOrLocal: String = "127.0.0.1/"
    
    
    @IBOutlet weak var tblGames: UITableView!
    
    //var teamList : [String] = ["Nets", "Raptors", "Celtics", "Knicks", "76ers", "Hawks", "Heat", "Magic", "Hornets", "Wizards", "Bucks", "Cavaliers", "Pistons", "Bulls", "Pacers", "Kings", "Warriors", "Lakers", "Suns", "Clippers", "Jazz", "Thunder", "TrailBlazers", "Timberwolves", "Nuggets", "Spurs", "Rockets", "Grizzlies", "Pelicans", "Mavericks"]
    var teamList: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblGames.dataSource = self

    }
    
    override func viewDidAppear(animated: Bool) {
        getTodaysGames()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tblGames.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // CELLS IN TABLE VIEW COUNT
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return teamList.count / 2;
    }
    
    // POPULATE CELLS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)->UITableViewCell{
        let cell : CustomCell = self.tblGames.dequeueReusableCellWithIdentifier("cell") as! CustomCell
        
        var homeTeamData = teamList[2 * indexPath.row].componentsSeparatedByString(" ") //as? [String]
        var awayTeamData = teamList[2 * indexPath.row + 1].componentsSeparatedByString(" ") //as? [String]
        
        var homeTeamName = homeTeamData[0]
        let awayTeamName = awayTeamData[0]
        let homeTeamScore = homeTeamData[1]
        let awayTeamScore = awayTeamData[1]
        
        cell.picHomeTeam.image = UIImage(named: homeTeamName + ".jpg")
        cell.picAwayTeam.image = UIImage(named: awayTeamName + ".jpg")
        cell.homeTeam = homeTeamName
        cell.awayTeam = awayTeamName
        cell.homeTeamBackground.backgroundColor = primaryColors[homeTeamName]
        cell.awayTeamBackground.backgroundColor = primaryColors[awayTeamName]
        cell.homeTeamScore.text = homeTeamScore
        cell.awayTeamScore.text = awayTeamScore
        
        
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "TableToDetailSegue"){
            let gameStatsView:GameStatsView = segue.destinationViewController as! GameStatsView
            var cell :CustomCell = sender as! CustomCell
            
            var home: UIImage! = cell.picHomeTeam.image
            var away: UIImage! = cell.picAwayTeam.image
        
            gameStatsView.homeTeamURL = cell.homeTeam
            gameStatsView.awayTeamURL = cell.awayTeam
            
            
            gameStatsView.populateGameStatsView(home, newAwayPicture:away)
        }
        

        
        if (segue.identifier == "AboutSegue") {
            // Just go to the page.  Nothing speical, yet.
        }
    }
    
    func getTodaysGames(){
        let dataString : NSString! = readHTML(piOrLocal + "todaysGames")
        teamList = dataString.componentsSeparatedByString(";") as! [String]
    }

    func readHTML(givenURL: String)->NSString{
        let url = NSURL(string: "http://" + givenURL)
        var error: NSError?
        let html = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: &error)
        
        if (error != nil) {
            println("whoops, something went wrong")
            return ""
        } else {
            return html!
        }
    }
}

