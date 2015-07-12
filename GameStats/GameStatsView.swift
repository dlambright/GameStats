//
//  GameStatsView.swift
//  GameStats
//
//  Created by Charlie Buckets on 5/25/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import QuartzCore
import UIKit
import JBChart


//enum with team name, 

class GameStatsView: UIViewController, JBLineChartViewDataSource, JBLineChartViewDelegate{

    @IBOutlet var navBar: UINavigationItem!

    @IBOutlet weak var picHomeTeam: UIImageView!
    @IBOutlet weak var picAwayTeam: UIImageView!
    @IBOutlet var lblGraph: UILabel!
    
    var homeTeamImage: UIImage!
    var awayTeamImage: UIImage!
    
    var homeTeamURL: String!
    var awayTeamURL: String!
    
    var homeTeamData = [Float]()
    var awayTeamData = [Float]()
    
    var killThread: Bool = false
    
    var statsLine: String!
    
    @IBOutlet var lineChart: JBLineChartView!
    
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
    
    
    //~*~*~ JBChart Variables
    var chartLegend = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picHomeTeam.image = homeTeamImage
        picAwayTeam.image = awayTeamImage
        navBar.title = homeTeamURL + "  vs  " + awayTeamURL
        
        getHomeTeamData()
        getAwayTeamData()
    
        
        setUpGraph()

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
        let dataString : NSString! = readHTML("127.0.0.1/" + homeTeamURL)
        
        
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
        let dataString : NSString! = readHTML("127.0.0.1/" + awayTeamURL)
        
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
                    self.getDataAtColmun(0)
                }
            }
        }
    }
    
    @IBAction func buttonTapped(sender: UIButton){
        lblGraph.text = sender.titleLabel?.text
    }
    
    func setUpGraph(){
        lineChart.backgroundColor = UIColor.whiteColor()
        lineChart.delegate = self
        lineChart.dataSource = self
        lineChart.minimumValue = 0
        lineChart.maximumValue = 100
        lineChart.reloadData()
        
        getDataAtColmun(0)
        showChart()
        
    }
    
    func graphStuff(){
        
    }
    
    func hideChart(){
        lineChart.setState(.Collapsed, animated: true)
    }
    
    func showChart(){
        lineChart.setState(.Expanded, animated: true)
    }
    
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 2
    }
    
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        if (lineIndex == 0){
            return CGFloat(awayTeamData[Int(horizontalIndex)])
        }
        else if (lineIndex == 1){
            return CGFloat(homeTeamData[Int(horizontalIndex)])
        }
        return 0
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if(lineIndex == 0){
            return UIColor.redColor()
        }
        else if (lineIndex == 1){
            return UIColor.blueColor()
        }
        
        return UIColor.whiteColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.lightGrayColor()
    }

    func lineChartView(lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt) {
        if (lineIndex == 0){
            let homeData = homeTeamData[Int(horizontalIndex)]
            let awayData = awayTeamData[Int(horizontalIndex)]
            //let key = chartLegend[Int(horizontalIndex)]
        }
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0){
            return UInt(awayTeamData.count)
        }
        else if (lineIndex == 1){
            return UInt(homeTeamData.count)
        }
        return 0
    }
    
    func getDataAtColmun(index: Int){
        awayTeamData = []
        var dataString : NSString! = readHTML("127.0.0.1/" + awayTeamURL)
        
        var lines = dataString.componentsSeparatedByString("\n")
        
        for line in lines{
            let currentData = line.componentsSeparatedByString(",")
            awayTeamData.append(currentData[index].floatValue)
            
        }
        
        
        homeTeamData = []
        dataString = readHTML("127.0.0.1/" + homeTeamURL)
        
        lines = dataString.componentsSeparatedByString("\n")
        
        for line in lines{
            let currentData = line.componentsSeparatedByString(",")
            homeTeamData.append(currentData[index].floatValue)
        }
        
        lineChart.reloadData()
        
    }

}

