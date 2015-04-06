//
//  PlaySoundsViewController.swift
//  PitchPerfect2
//
//  Created by Sachin Sapte on 05/04/15.
//  Copyright (c) 2015 Sach Kas. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType:"mp3"){
            
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
 //           audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
 //           audioPlayer.enableRate = true
   //     }else {
  //          println("Path for audio file not found")
  //      }
        // Do any additional setup after loading the view.
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine ()
        audioFile = AVAudioFile (forReading: receivedAudio.filePathUrl, error:nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlaySlow(sender: UIButton) {
        
        println("is playing slow")
        
        audioPlayer.rate = 0.5
        audioPlayer.play()

        
   
    }

    @IBAction func playFast(sender: UIButton) {
        println("is playing fast")
        
        audioPlayer.rate = 2.0
        audioPlayer.play()
    }
    
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch (1000)
        
    }
    
    @IBAction func playDarthAudio(sender: UIButton) {
        playAudioWithVariablePitch (-1000)
    }
    
    
    //New Function
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
