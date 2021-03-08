//
//  ConfessionViewController.swift
//  5_Confession
//
//  Created by 李世文 on 2021/3/2.
//

import UIKit
import AVFoundation

class ConfessionViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet var valueLabelCollection: [UILabel]!
    @IBOutlet var sliderCollection: [UISlider]!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var speakButton: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func speechSetting(_ sender: UISlider) {
        let value = sender.value
        switch sender {
        case sliderCollection[0]:
            var rateValueStr = String(format: "%.1f", value)
            if rateValueStr.last == "0" {
                rateValueStr.removeLast()
                rateValueStr.removeLast()
            }
            valueLabelCollection[0].text = rateValueStr
        case sliderCollection[1]:
            var pitchValueStr = String(format: "%.1f", value)
            if pitchValueStr.last == "0" {
                pitchValueStr.removeLast()
                pitchValueStr.removeLast()
            }
            valueLabelCollection[1].text = pitchValueStr
        case sliderCollection[2]:
            let volumeValue = Int(value * 100)
            valueLabelCollection[2].text = "\(volumeValue)%"
        default:
            break
        }
    }
    
    @IBAction func speak(_ sender: UIButton) {
        
        let speechUtterance = AVSpeechUtterance(string: inputTextField.text!)
        speechUtterance.rate = sliderCollection[0].value
        speechUtterance.pitchMultiplier = sliderCollection[1].value
        speechUtterance.volume = sliderCollection[2].value
        
        var language:String
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            language = "zh-HK"
        case 2:
            language = "en-US"
        default:
            language = "zh-TW"
        }
        speechUtterance.voice = AVSpeechSynthesisVoice(language: language)
        
        synthesizer.speak(speechUtterance)
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if synthesizer.isSpeaking {
            synthesizer.pauseSpeaking(at: .immediate)
        }
    }
    
    @IBAction func continueSpeaking(_ sender: UIButton) {
        if synthesizer.isPaused {
            synthesizer.continueSpeaking()
        }
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
