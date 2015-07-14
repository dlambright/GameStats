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

// To do:
//dictionary of secondary colors
//max/ min from data max/min
// dynamically set graph bounds from max/min


class GameStatsView: UIViewController, JBLineChartViewDataSource, JBLineChartViewDelegate{
    
    var primaryColors:[String:UIColor] = ["AtlantaHawks": UIColor(red: 225/255 , green: 58/255 , blue: 62/255 , alpha: 1),
        "BostonCeltics": UIColor(red: 0/255 , green: 131/255 , blue: 72/255 , alpha: 1),
        "BrooklynNets": UIColor(red: 6/255 , green: 25/255 , blue: 34/255 , alpha: 1),
        "CharlotteHornets": UIColor(red: 29/255 , green: 17/255 , blue: 96/255 , alpha: 1),
        "ChicagoBulls": UIColor(red: 206/255 , green: 17/255 , blue: 65/255 , alpha: 1),
        "ClevelandCavaliers": UIColor(red: 134/255 , green: 0/255 , blue: 56/255 , alpha: 1),
        "DallasMavericks": UIColor(red: 0/255 , green: 125/255 , blue: 197/255 , alpha: 1),
        "DenverNuggets": UIColor(red: 77/255 , green: 144/255 , blue: 205/255 , alpha: 1),
        "DetroitPistons": UIColor(red: 237/255 , green: 23/255 , blue: 76/255 , alpha: 1),
        "GoldenStateWarriors": UIColor(red: 253/255 , green: 185/255 , blue: 39/255 , alpha: 1),
        "HoustonRockets": UIColor(red: 206/255 , green: 17/255 , blue: 65/255 , alpha: 1),
        "IndianaPacers": UIColor(red: 255/255 , green: 198/255 , blue: 51/255 , alpha: 1),
        "LosAngelesClippers": UIColor(red: 237/255 , green: 23/255 , blue: 76/255 , alpha: 1),
        "LosAngelesLakers": UIColor(red: 253/255 , green: 185/255 , blue: 39/255 , alpha: 1),
        "MemphisGrizzlies": UIColor(red: 15/255 , green: 88/255 , blue: 108/255 , alpha: 1),
        "MiamiHeat": UIColor(red: 152/255 , green: 0/255 , blue: 46/255 , alpha: 1),
        "MilwaukeeBucks": UIColor(red: 0/255 , green: 71/255 , blue: 27/255 , alpha: 1),
        "MinnesotaTimberwolves": UIColor(red: 0/255 , green: 80/255 , blue: 131/255 , alpha: 1),
        "NewOrleansPelicans": UIColor(red: 0/255 , green: 43/255 , blue: 92/255 , alpha: 1),
        "NewYorkKnicks": UIColor(red: 245/255 , green: 132/255 , blue: 38/255 , alpha: 1),
        "OklahomaCityThunder": UIColor(red: 0/255 , green: 125/255 , blue: 197/255 , alpha: 1),
        "OrlandoMagic": UIColor(red: 0/255 , green: 125/255 , blue: 197/255 , alpha: 1),
        "Philadelphia76ers": UIColor(red: 237/255 , green: 23/255 , blue: 76/255 , alpha: 1),
        "PhoenixSuns": UIColor(red: 229/255 , green: 96/255 , blue: 32/255 , alpha: 1),
        "PortlandTrailblazers": UIColor(red: 225/255 , green: 58/255 , blue: 62/255 , alpha: 1),
        "SacramentoKings": UIColor(red: 114/255 , green: 76/255 , blue: 159/255 , alpha: 1),
        "SanAntonioSpurs": UIColor(red: 186/255 , green: 195/255 , blue: 201/255 , alpha: 1),
        "TorontoRaptors": UIColor(red: 206/255 , green: 17/255 , blue: 65/255 , alpha: 1),
        "UtahJazz": UIColor(red: 0/255 , green: 43/255 , blue: 92/255 , alpha: 1),
        "WashingtonWizards": UIColor(red: 0/255 , green: 43/255 , blue: 92/255 , alpha: 1)]
    var secondaryColors:[String:UIColor] = ["AtlantaHawks": UIColor(red: 0, green: 43/255, blue: 92/255, alpha: 1),
        "ChicagoBulls": UIColor(red: 6/255, green: 25/255, blue: 34/255, alpha: 1),
        "DallasMavericks": UIColor(red: 196/255, green: 206/255, blue: 211/255, alpha: 1),
        "DetriotPistons": UIColor(red: 237/255, green: 23/255, blue: 76/255, alpha: 1),
        "GoldenStateWarriors": UIColor(red: 253/255, green: 185/255, blue: 39/255, alpha: 1),
        "HoustonRockets": UIColor(red: 206/255, green: 17/255, blue: 65/255, alpha: 1),
        "LosAngelesClippers": UIColor(red: 237/255, green: 23/255, blue: 76/255, alpha: 1),
        "LosAngelesLakers": UIColor(red: 85/255, green: 37/255, blue: 130/255, alpha: 1),
        "NewOrleansPelicans": UIColor(red: 227/255, green: 24/255, blue: 55/255, alpha: 1),
        "OklahomaCityThunder": UIColor(red: 240/255, green: 81/255, blue: 51/255, alpha: 1),
        "OrlandoMagic": UIColor(red: 196/255, green: 206/255 , blue: 211/255, alpha: 1),
        "Philadelphia76ers": UIColor(red: 0, green: 107/255, blue: 182/255, alpha: 1),
        "PortlandTrailblazers": UIColor(red: 186/255, green: 195/255, blue: 201/255, alpha: 1),
        "TorontoRaptors": UIColor(red: 6/255, green: 25/255, blue: 34/255, alpha: 1),
        "UtahJazz": UIColor(red: 249/255, green: 160/255, blue: 27/255, alpha: 1),
        "WashingtonWizards": UIColor(red: 227/255, green: 24/255, blue: 55/255, alpha: 1)]
    
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
    
    @IBOutlet var lblHomeTeamColor: UILabel!
    @IBOutlet var lblAwayTeamColor: UILabel!
    
    
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
        
        // Make these a method
        lblHomeTeamColor.backgroundColor = primaryColors[homeTeamURL]
        lblHomeTeamColor.text = "  " + homeTeamURL + "  "
        lblAwayTeamColor.backgroundColor = primaryColors[awayTeamURL]
        lblAwayTeamColor.text = "  " + awayTeamURL + "  "
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
                    self.getDataAtColmun(self.getColumnFromStringField(self.lblGraph.text!))
                }
            }
        }
    }
    func getColumnFromStringField(text: String) -> Int{
        if(text == "SCORE"){
            return 0
            //GetMinValue
            //GetMaxValue
        }
        if(text == "FIELD GOALS"){
            return 2
        }
        if(text == "3-PT FIELD GOALS"){
            return 5
        }
        if(text == "FREE THROWS"){
            return 8
        }
        if(text == "REBOUNDS O/D/T"){
            return 13
        }
        if(text == "STEALS"){
            return 15
        }
        if(text == "BLOCKS"){
            return 16
        }
        if(text == "ASSISTS"){
            return 14
        }
        //TO DO: TRUE SHOOTING PERCENTAGE
        
        
        
        
        return 0
    }
    @IBAction func buttonTapped(sender: UIButton){
        lblGraph.text = sender.titleLabel?.text
        var index = getColumnFromStringField(sender.titleLabel!.text!)
        getDataAtColmun(index)
        showChart()
        
    }
    
    func setUpGraph(){
        lineChart.backgroundColor = UIColor.whiteColor()
        lineChart.delegate = self
        lineChart.dataSource = self
        lineChart.minimumValue = 0
        lineChart.maximumValue = 100
        lineChart.reloadData()
        
        
        
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
            return primaryColors[awayTeamURL]
            
        }
        else if (lineIndex == 1){
            return primaryColors[homeTeamURL]
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
            if (currentData.count >= 36){
                awayTeamData.append(currentData[index].floatValue)
            }
            
        }
        if(awayTeamData.count > 1){
            awayTeamData.removeLast()
        }
        
        
        
        
        
        homeTeamData = []
        dataString = readHTML("127.0.0.1/" + homeTeamURL)
        
        lines = dataString.componentsSeparatedByString("\n")
        
        for line in lines{
            let currentData = line.componentsSeparatedByString(",")
            if(currentData.count >= 36){
                homeTeamData.append(currentData[index].floatValue)
            }
        }
        if(homeTeamData.count > 1){
            homeTeamData.removeLast()
        }
        
        
        lineChart.maximumValue = CGFloat(maxElement([maxElement(homeTeamData), maxElement(awayTeamData)])+5)
        lineChart.reloadData()
        
    }
    
}

