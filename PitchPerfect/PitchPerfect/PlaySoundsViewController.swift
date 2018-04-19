//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Maria Carolina Santos on 17/04/2018.
//  Copyright © 2018 Maria Carolina Marinho Séves Santos. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
   
    
    enum ButtonType: Int{
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    
    func adjustButtonsImages(){
        let buttons: [UIButton] = [slowButton, fastButton, highPitchButton, lowPitchButton, echoButton, reverbButton, stopButton]
        for button in buttons {
            button.imageView?.contentMode = .scaleAspectFit
        }
       
    }
    
    // MARK: - Buttons Functions
    @IBAction func playSoundForButton(_ sender: UIButton) {
        
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highPitch:
            playSound(pitch: 1000)
        case .lowPitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopSound(_ sender: Any) {
        stopAudio()
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        configureUI(.notPlaying)
        adjustButtonsImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
