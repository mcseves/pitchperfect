//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Maria Carolina Santos on 17/04/2018.
//  Copyright © 2018 Maria Carolina Marinho Séves Santos. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // Declaring view componens
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    //Declaring audio recorder
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isRecording(state: false)
        recordButton.imageView?.contentMode = .scaleAspectFit
        
    }
    
    // MARK: set UI
    func isRecording (state: Bool){
        recordingLabel.text = state ? "Recording in progress" : "Tap to record!"
        recordButton.isEnabled = !state
        stopRecordButton.isEnabled = state
   
    }

    // MARK: - Button Functions
    @IBAction func recordAudio(_ sender: Any) {
        
        isRecording(state: true)
        
        // Setting record functionality
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath ?? "filePath not found")
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecordAudio(_ sender: Any) {

        isRecording(state: false)
        
        // Stop recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    // MARK: - Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished recording")
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            print("record not successful D:")
        }
    }
    
    // MARK: - Prepare for Segue PlaySoundsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

