//
//  FirstViewController.swift
//  EyEcanvasMusicPlayer
//  Playing Audio in the Background
//
//  Created by W SCHIRRA on 4/15/15.
//  Copyright (c) 2015 WERNHER SCHIRRA. All rights reserved.
//

import UIKit

import AVFoundation

import MediaPlayer


class ViewController: UIViewController, UIApplicationDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet var PausePlay: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    
    
    var audioPlayer = AVAudioPlayer()
    
    var meditationSound = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("Album_Intro", ofType: "mp3")!)
    
    var isPlaying: Int = 0
    var soundSelected: Int = 0
    
    var soundfiles : [String] = ["Album_Intro","Kings","black_EyE","Balance","Salad_Dressing","notyet","She_is_There","2allmyxs_part2","Motion","startrek","waves"]
    var imagethumbs : [String] = ["thumbdaddio.jpg","thumbWaves.jpg","thumbblack_EyE.jpg","thumbshaulinfunk.jpg","thumb2allmyxs.jpg","thumbNotYet.jpg","thumbshe's_there.jpg","thumbSlide.jpg","thumbmotion.jpg","thumbStarTrek.jpg","thumbfast_life.jpg"]
    var soundTitles : [String] = ["Intro","Kings","Black EyE","Balance","Salad_Dressing","Not Yet","She's There","2allmyxs_part2","Motion","Star Trek","Waves"]
    var subTitles : [String] = ["WooL / Interviewer: Deviant","WooL","WooL and L's","WooL","WooL","WooL","WooL","WooL","WooL","WooL","WooL"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.alpha = 0.7
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section:Int)->Int{
        
        return imagethumbs.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!)->
        UITableViewCell{
            
            let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle,
                reuseIdentifier: "MyTestCell")
            
            cell.textLabel?.text = soundTitles[indexPath.row]
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.detailTextLabel?.text = subTitles[indexPath.row]
            cell.detailTextLabel?.textColor = UIColor.whiteColor()
            cell.imageView?.image = UIImage(named:imagethumbs[indexPath.row])
            cell.backgroundColor = UIColor.clearColor()
            
            return cell
    }
    
    func tableView(tableView: UITableView!,didSelectRowAtIndexPath indexPath:NSIndexPath!){
        
        print("EyEcanvas Music Player #\(indexPath.row)!")
        soundSelected = indexPath.row
        
    }
    
    
    @IBAction func playSound(){
        
        
        meditationSound = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(soundfiles[soundSelected], ofType: "mp3")!)
        
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: meditationSound, fileTypeHint: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        isPlaying = 1
        audioPlayer.play()
        
    }
    
    @IBAction func PauseSound(){
        
        audioPlayer.pause()
        isPlaying = 0
        
    }
    
    @IBAction func PausePlay(sender: AnyObject) {
        
        if (audioPlayer.playing == true){
            audioPlayer.stop()
            
            
        }
        else{
            
            audioPlayer.play()
            
            
        }
        
        
        func enableRemoteControl() {
            let cc = MPRemoteCommandCenter.sharedCommandCenter()
            cc.playCommand.addTarget(self, action: "play")
            cc.pauseCommand.addTarget(self, action: "pause")
            cc.stopCommand.addTarget(self, action: "stop")
            cc.togglePlayPauseCommand.addTarget(self, action: "togglePlayPause")
            cc.nextTrackCommand.addTarget(self, action: "next")
            cc.previousTrackCommand.addTarget(self, action: "previous")
        }
        
    }
    
    
}





