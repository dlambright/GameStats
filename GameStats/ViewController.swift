//
//  ViewController.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/18/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblGames: UITableView!

    var items = ["one", "two"]
    
    var teamList : [String] = ["Nets", "Raptors", "Celtics", "Knicks", "76ers", "Hawks", "Heat", "Magic", "Hornets", "Wizards", "Bucks", "Cavaliers", "Pistons", "Bulls", "Pacers", "Kings", "Warriors", "Lakers", "Suns", "Clippers", "Jazz", "Thunder", "TrailBlazers", "Timberwolves", "Nuggets", "Spurs", "Rockets", "Grizzlies", "Pelicans", "Mavericks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.tblGames.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tblGames.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return teamList.count / 2;

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)->UITableViewCell{
        let cell : CustomCell = self.tblGames.dequeueReusableCellWithIdentifier("cell") as! CustomCell
        
        var homeIndex = teamList[2 * indexPath.row] + ".jpg"
        var awayIndex = teamList[(2 * indexPath.row) + 1] + ".jpg"
        cell.picHomeTeam.image = UIImage(named: homeIndex)
        cell.picAwayTeam.image = UIImage(named: awayIndex)
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let navBar:UINavigationController = segue.destinationViewController as! UINavigationController
        let gameStatsView:GameStatsView = navBar.viewControllers[0] as! GameStatsView
        var cell :CustomCell = sender as! CustomCell
        
        var home: UIImage! = cell.picHomeTeam.image
        var away: UIImage! = cell.picAwayTeam.image
        
        
        gameStatsView.populateGameStatsView(home, newAwayPicture:away)
        
        if (segue.identifier == "Show") {
            // pass data to next view
        }
    }

}

