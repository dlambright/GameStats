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
        getTodaysGames()
        super.viewDidLoad()

        self.tblGames.dataSource = self
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
        
        var homeIndex = teamList[2 * indexPath.row] + ".jpg"
        var awayIndex = teamList[(2 * indexPath.row) + 1] + ".jpg"
        cell.picHomeTeam.image = UIImage(named: homeIndex)
        cell.picAwayTeam.image = UIImage(named: awayIndex)
        cell.homeTeam = teamList[2 * indexPath.row]
        cell.awayTeam = teamList[2 * indexPath.row + 1]
        cell.homeTeamBackground.backgroundColor = primaryColors[teamList[2 * indexPath.row]]
        cell.awayTeamBackground.backgroundColor = primaryColors[teamList[2 * indexPath.row + 1]]
        
        
        
        
        
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
        teamList = dataString.componentsSeparatedByString(" ") as! [String]
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
}

