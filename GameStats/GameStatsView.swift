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
    
    //var piOrLocal: String = "192.168.1.81/"
    var piOrLocal: String = "127.0.0.1/"
    @IBOutlet var navBar: UINavigationItem!
    
    @IBOutlet weak var picHomeTeam: UIImageView!
    @IBOutlet weak var picAwayTeam: UIImageView!
    @IBOutlet var lblGraph: UILabel!
    
    var homeTeamImage: UIImage!
    var awayTeamImage: UIImage!
    
    var homeTeamURL: String!
    var awayTeamURL: String!
    
    var homeTeamDataAsFloat = [Float]()
    var awayTeamDataAsFloat = [Float]()
    
    var homeTeamDataAsString: NSString!
    var awayTeamDataAsString: NSString!
    
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
        navBar.title = getTeamNameOnly(homeTeamURL) + "    vs    " + getTeamNameOnly(awayTeamURL)
        
        gethomeTeamData()
        getawayTeamData()
        
        
        setUpGraph()
        showChart()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
        killThread = false
        
        // Make these a method
        lblHomeTeamColor.backgroundColor = primaryColors[homeTeamURL]
        lblHomeTeamColor.text = "  " + getTeamNameOnly(homeTeamURL) + "  "
        lblAwayTeamColor.backgroundColor = primaryColors[awayTeamURL]
        lblAwayTeamColor.text = "  " + getTeamNameOnly(awayTeamURL) + "  "
    }
    
    override func viewWillDisappear(animated: Bool) {
        killThread = true
    }
    
    func populateGameStatsView(newHomePicture: UIImage, newAwayPicture: UIImage) ->Void{
        homeTeamImage = newHomePicture
        awayTeamImage = newAwayPicture
    }
    
    func populateHomeTeam(newScore: String, newFGMade: String, newFGAttempted: String, new3PMade: String, new3PAttempted: String, newFTMade: String, newFTAttempted: String, newDReb: String, newOReb: String, newTotalReb: String, newSteals: String, newBlocks: String, newAssists: String, newTSP: String, newWinProb: String)->Void{
        
        lblHomeScore.text = newScore.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeFG.text = newFGMade.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newFGAttempted.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHome3pt.text = new3PMade.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + new3PAttempted.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeFT.text = newFTMade.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newFTAttempted.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeRebounds.text = newOReb.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newDReb.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newTotalReb.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeSteals.text = newSteals.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeBlocks.text = newBlocks.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeAssists.text = newAssists.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeTSP.text = newTSP.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblHomeWinProb.text = newWinProb.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
    }
    
    func populateAwayTeam(newScore: String, newFGMade: String, newFGAttempted: String, new3PMade: String, new3PAttempted: String, newFTMade: String, newFTAttempted: String, newDReb: String, newOReb: String, newTotalReb: String, newSteals: String, newBlocks: String, newAssists: String, newTSP: String, newWinProb: String)->Void{
        
        lblAwayScore.text = newScore.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAwayFG.text = newFGMade.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newFGAttempted.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAway3pt.text = new3PMade.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + new3PAttempted.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAwayFT.text = newFTMade.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newFTAttempted.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAwayRebounds.text = newOReb.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newDReb.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + newTotalReb.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAwaySteals.text = newSteals.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAwayBlocks.text = newBlocks.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAwayAssists.text = newAssists.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        lblAwayTSP.text = newTSP.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
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
    
    func gethomeTeamData()->Void{
        //let dataString = readHTML(piOrLocal + homeTeamURL)
        homeTeamDataAsString = readHTML(piOrLocal + homeTeamURL)
        
        let lines = homeTeamDataAsString.componentsSeparatedByString("\n")
        
        let mostRecentData = lines[(lines.count-3)].componentsSeparatedByString(",")
        
        
        var TSP :Float = mostRecentData[36].floatValue
        TSP = Float(round(1000*TSP)/10)
        
        var winPct = mostRecentData[37].floatValue
        winPct = Float(round(1000*winPct)/10)
        
        
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
            newWinProb: winPct.description + "%")
    }
    
    func getawayTeamData()->Void{
        //let dataString : NSString! = readHTML(piOrLocal + awayTeamURL)
        awayTeamDataAsString = readHTML(piOrLocal + awayTeamURL)
        
        let lines = awayTeamDataAsString.componentsSeparatedByString("\n")
        let mostRecentData = lines[(lines.count-3)].componentsSeparatedByString(",")
        
        var TSP :Float = mostRecentData[36].floatValue
        TSP = Float(round(1000*TSP)/10)
        
        var winPct = mostRecentData[37].floatValue
        winPct = Float(round(1000*winPct)/10)
        
        
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
            newWinProb: winPct.description + "%")
    }
    
    
    func refreshData(){
        let qualityOfServiceClass = Int(QOS_CLASS_BACKGROUND.value)
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(dispatch_get_global_queue(qualityOfServiceClass,0)){ () -> Void in
            
            while self.killThread == false{
                sleep(2)
                dispatch_async(dispatch_get_main_queue()){
                    self.getawayTeamData()
                    self.gethomeTeamData()
                    self.getDataAtColmun(self.getColumnFromStringField(self.lblGraph.text!))
                }
            }
        }
    }
    func getColumnFromStringField(text: String) -> Int{
        if(text == "SCORE"){
            return 0
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
        if(text == "TRUE SHOOTING %"){
            return 36
        }
        if(text == "WIN PROBABILITY"){
            return 37
        }
        
        
        
        
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
            return CGFloat(awayTeamDataAsFloat[Int(horizontalIndex)])
        }
        else if (lineIndex == 1){
            return CGFloat(homeTeamDataAsFloat[Int(horizontalIndex)])
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
            let homeData = homeTeamDataAsFloat[Int(horizontalIndex)]
            let awayData = awayTeamDataAsFloat[Int(horizontalIndex)]
            //let key = chartLegend[Int(horizontalIndex)]
        }
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0){
            return UInt(awayTeamDataAsFloat.count)
        }
        else if (lineIndex == 1){
            return UInt(homeTeamDataAsFloat.count)
        }
        return 0
    }
    func lineChartView(lineChartView: JBLineChartView!, lineStyleForLineAtLineIndex lineIndex: UInt) -> JBLineChartViewLineStyle{
        if(lineIndex == 0){
            return JBLineChartViewLineStyle.Solid
        }
        else if (lineIndex == 1){
            return JBLineChartViewLineStyle.Solid
        }
        
        return JBLineChartViewLineStyle.Solid
    }
    
    func getDataAtColmun(index: Int){
        awayTeamDataAsFloat = []
        //var dataString : NSString! = readHTML(piOrLocal + awayTeamURL)
        
        var lines = awayTeamDataAsString.componentsSeparatedByString("\n")
        
        for line in lines{
            let currentData = line.componentsSeparatedByString(",")
            if (currentData.count >= 36){
                awayTeamDataAsFloat.append(currentData[index].floatValue)
            }
            
        }
        if(awayTeamDataAsFloat.count > 1){
            awayTeamDataAsFloat.removeLast()
        }
        
        
        homeTeamDataAsFloat = []
        //dataString = readHTML(piOrLocal + homeTeamURL)
        
        lines = homeTeamDataAsString.componentsSeparatedByString("\n")
        
        for line in lines{
            let currentData = line.componentsSeparatedByString(",")
            if(currentData.count >= 37){
                homeTeamDataAsFloat.append(currentData[index].floatValue)
            }
        }
        if(homeTeamDataAsFloat.count > 1){
            homeTeamDataAsFloat.removeLast()
        }
        
        if(index == 36 || index == 37){
            lineChart.maximumValue = 1
        }
        else{
            lineChart.maximumValue = CGFloat(maxElement([maxElement(homeTeamDataAsFloat), maxElement(awayTeamDataAsFloat)])+5)

        }
        
        //lineChart.maximumValue = CGFloat(maxElement([maxElement(homeTeamDataAsFloat), maxElement(awayTeamDataAsFloat)])+5)
        lineChart.reloadData()
        
    }
    
}

