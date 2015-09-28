//
//  ViewController.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/18/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nnba_url: String = "http://nnba.ddns.net:11358/"
    
    
    @IBOutlet weak var tblGames: UITableView!
    
    //var teamList : [String] = ["Nets", "Raptors", "Celtics", "Knicks", "76ers", "Hawks", "Heat", "Magic", "Hornets", "Wizards", "Bucks", "Cavaliers", "Pistons", "Bulls", "Pacers", "Kings", "Warriors", "Lakers", "Suns", "Clippers", "Jazz", "Thunder", "TrailBlazers", "Timberwolves", "Nuggets", "Spurs", "Rockets", "Grizzlies", "Pelicans", "Mavericks"]
    
    var gameList: [Game] = []
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
        return gameList.count
    }
    
    // POPULATE CELLS
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)->UITableViewCell{
        let cell : CustomCell = self.tblGames.dequeueReusableCellWithIdentifier("cell") as! CustomCell
        
        let currentGame = gameList[indexPath.row]
        
        //var homeTeamData = teamList[2 * indexPath.row].componentsSeparatedByString(" ") //as? [String]
        //var awayTeamData = teamList[2 * indexPath.row + 1].componentsSeparatedByString(" ") //as? [String]
        
        let homeTeamName = currentGame.homeTeam
        let awayTeamName = currentGame.awayTeam
        let homeTeamScore = currentGame.homeTeamScore
        let awayTeamScore = currentGame.awayTeamScore
        
        
        cell.picHomeTeam.image = UIImage(named: homeTeamName + ".jpg")
        cell.picAwayTeam.image = UIImage(named: awayTeamName + ".jpg")
        cell.homeTeam = homeTeamName
        cell.awayTeam = awayTeamName
        cell.homeTeamScore.text = homeTeamScore
        cell.awayTeamScore.text = awayTeamScore
        
        cell.homeTeamBackground.backgroundColor = primaryColors[homeTeamName]
        cell.awayTeamBackground.backgroundColor = getAwayTeamColors(homeTeamName, awayTeamString: awayTeamName)
        
        
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "TableToDetailSegue"){
            let gameStatsView:GameStatsView = segue.destinationViewController as! GameStatsView
            let cell :CustomCell = sender as! CustomCell
            
            let home: UIImage! = cell.picHomeTeam.image
            let away: UIImage! = cell.picAwayTeam.image
        
            gameStatsView.homeTeamURL = cell.homeTeam
            gameStatsView.awayTeamURL = cell.awayTeam
            
            
            gameStatsView.populateGameStatsView(home, newAwayPicture:away)
        }
        

        
        if (segue.identifier == "AboutSegue") {
            // Just go to the page.  Nothing speical, yet.
        }
    }
    
    func getTodaysGames(){
        
        let urlString = "http://nnba.ddns.net:11358/todaysGames"
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let jsonData = JSON(data: data)
            
                var index = 0
                
                gameList = []
                while jsonData[index] != nil{
                    
                    //get the json data
                    let newHomeTeam = jsonData[index]["homeTeam"]
                    let newAwayTeam = jsonData[index]["awayTeam"]
                    let newHomeTeamScore = jsonData[index]["homeTeamScore"]
                    let newAwayTeamScore = jsonData[index]["awayTeamScore"]
                    let newGameId = jsonData[index]["gameId"]
                    let newTime = jsonData[index]["time"]
                    
                    // convert json data to string values
                    let newHomeTeamString : String!  = newHomeTeam.rawString()
                    let newAwayTeamString : String! = newAwayTeam.rawString()
                    let newHomeTeamScoreString : String! = newHomeTeamScore.rawString()
                    let newAwayTeamScoreString : String! = newAwayTeamScore.rawString()
                    let newGameIdString : String! = newGameId.rawString()
                    let newTimeString : String! = newTime.rawString()
                    
                    
                    let tempGame = Game(newHomeTeamScore: newHomeTeamScoreString,
                        newAwayTeamScore: newAwayTeamScoreString,
                        newGameId: newGameIdString,
                        newAwayTeam: newAwayTeamString,
                        newHomeTeam: newHomeTeamString,
                        newTime: newTimeString)
                    
                    gameList.append(tempGame)
                    index += 1
                }

            }
        }
    }

    func readHTML(givenURL: String)->NSString{
        let url = NSURL(string: givenURL)
        var error: NSError?
        let html: NSString?
        do {
            html = try NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
        } catch let error1 as NSError {
            error = error1
            html = nil
        }
        
        if (error != nil) {
            print("whoops, something went wrong")
            return ""
        } else {
            return html!
        }
    }
}










