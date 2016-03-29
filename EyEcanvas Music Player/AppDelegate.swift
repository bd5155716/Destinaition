//
//  AppDelegate.swift
//  EyEcanvas Music Player
//  Playing Audio in the Background
//
//  Created by W SCHIRRA on 3/17/15.
//  Copyright (c) 2015 WERNHER SCHIRRA. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import MediaPlayer



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate {
    
    var window: UIWindow?
    var audioPlayer: AVAudioPlayer?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let dispatchQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(dispatchQueue, {[weak self] in
            
            var AVAudioSessionError: NSError?
            let AVAudioSession = AVAudioPlayer.sharedInstance()
            NSNotificationCenter.defaultCenter().addObserver(self!,
                selector: "handleInterruption:",
                name: AVAudioSessionInterruptionNotification,
                object: nil)
            
            do {
                try AVAudioSession.setActive(true)
            } catch _ {
            }
            
            do {
                try AVAudioSession.setCategory(AVAudioSessionCategoryPlayback)
                print("Successfully set the audio session")
            } catch let error as NSError {
                AVAudioSessionError = error
                print("Could not set the audio session")
            } catch {
                fatalError()
            }
            
            let filePath = NSBundle.mainBundle().pathForResource("Album_Intro",
                ofType:"mp3")
            
            let fileData = try? NSData(contentsOfFile: filePath!,
                options: .DataReadingMappedIfSafe)
            
            var error:NSError?
            
            do {
                /* Start the audio player */
                self!.audioPlayer = try AVAudioPlayer(data: fileData!)
            } catch let error1 as NSError {
                error = error1
                self!.audioPlayer = nil
            } catch {
                fatalError()
            }
            
            /* Did we get an instance of AVAudioPlayer? */
            if let theAudioPlayer = self!.audioPlayer{
                theAudioPlayer.delegate = self;
                if theAudioPlayer.prepareToPlay() &&
                    theAudioPlayer.play(){
                        print("Successfully started playing")
                } else {
                    print("Failed to play")
                }
            } else {
                /* Handle the failure of instantiating the audio player */
            }
            })
        
        return true
    }
    
    func handleInterruption(notification: NSNotification){
        /* Audio Session is interrupted. The player will be paused here */
        
        let interruptionTypeAsObject =
        notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber
        
        let interruptionType = AVAudioSessionInterruptionType(rawValue:
            interruptionTypeAsObject.unsignedLongValue)
        
        if let type = interruptionType{
            if type == .Ended{
                
                /* resume the audio if needed */
                
            }
        }
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer,
        successfully flag: Bool){
            
            print("Finished playing the song")
            
            /* The flag parameter tells us if the playback was successfully
            finished or not */
            if player == audioPlayer{
                audioPlayer = nil
            }
            
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

