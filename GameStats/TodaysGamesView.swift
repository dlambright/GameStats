//
//  ViewController.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/18/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit

enum JSONValue {
    
    case JNumber(NSNumber)
    case JString(String)
    case JBool(Bool)
    case JNull
    case JArray(Array<JSONValue>)
    case JObject(Dictionary<String,JSONValue>)
    case JInvalid(NSError)
    
}

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
        
        
//        let testUrl = NSURL(string: "http://nnba.ddns.net:11358/todaysGames")
//        var data : NSData
//            data = NSData(contentsOfURL: testUrl!)!
//
//        
//        
//        
//        
//        
//        do{
//            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
//                if let items = json["items"] as? NSArray {
//                    for item in items {
//                        print (item)
//                        // construct your model objects here
//                    }
//                }
//            }
//            
//        }catch{print(error)}
        

        
        
        
        
        
//        let endpoint = NSURL(string: "http://www.google.com") //nnba_url + "todaysGames")
////        var endpoint = NSURL(string: "http://www.espn.go.com")
//        let request:NSURLRequest = NSURLRequest(URL:endpoint!)
//        let queue:NSOperationQueue = NSOperationQueue()
//        
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(endpoint!) {(data, response, error) in
//            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
//        }
        
        //var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        // var data = NSData(contentsOfURL: endpoint!)
        
        // let yolo = readHTML("http://www.google.com")
//        let dataString : NSString! = readHTML(nnba_url + "todaysGames")
//        //teamList = dataString.componentsSeparatedByString(";") as! [String]
//        gameList = [Game(newHomeTeamScore: "100", newAwayTeamScore: "99", newGameId: "1", newAwayTeam: "ChicagoBulls", newHomeTeam: "HoustonRockets", newTime: "10:00 4Q"),
//                    Game(newHomeTeamScore: "100", newAwayTeamScore: "99", newGameId: "1", newAwayTeam: "LosAngelesLakers", newHomeTeam: "GoldenStateWarriors", newTime: "10:00 4Q")]
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










