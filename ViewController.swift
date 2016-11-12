//
//  ViewController.swift
//  OmikujiApp
//
//  Created by UCHIYAMA M on 2016/11/12.
//  Copyright © 2016年 UCHIYAMA M. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var stickLabel: UILabel!
    @IBOutlet weak var stickView: UIView!
    
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    
    
    @IBOutlet weak var overView: UIView!
    
    
    @IBOutlet weak var bigLabel: UILabel!
    
    
    
    
    let resultTextArray: [String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    
    // 加速度センサーを使うためのオブジェクトを格納します。
    let motionManager: CMMotionManager = CMMotionManager()
    
    // iPhoneを振った音を出すための再生オブジェクトを格納します。
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    
    
    // ボタンを押した時の音を出すための再生オブジェクトを格納します。
    var startAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    //大吉が出た時の音を出すための再生オブジェクトを格納します。
    var daikichiAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    //中吉が出た時の音を出すための再生オブジェクトを格納します。
    var chukichiAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    //小吉が出た時の音を出すための再生オブジェクトを格納します。
    var syokichiAudioPlayer: AVAudioPlayer = AVAudioPlayer()

    //吉が出た時の音を出すための再生オブジェクトを格納します。
    var kichiAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    //末吉が出た時の音を出すための再生オブジェクトを格納します。
    var suekichiAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    //凶が出た時の音を出すための再生オブジェクトを格納します。
    var kyoAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    //大凶が出た時の音を出すための再生オブジェクトを格納します。
    var daikyoAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    


    
    
    // アプリで使用する音の準備
    func setupSound() {
        // ボタンを押した時の音を設定します。
        if let sound = Bundle.main.path(forResource: "tearing_papers1", ofType: ".mp3") {
            startAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            startAudioPlayer.prepareToPlay()
        }
        // iPhoneを振った時の音を設定します。
        if let sound = Bundle.main.path(forResource: "swing1", ofType: ".mp3") {
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            audioPlayer.prepareToPlay()
        }
        // 大吉が出た時の音を設定します。
        if let sound = Bundle.main.path(forResource: "straight_punch", ofType: ".mp3") {
            daikichiAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            daikichiAudioPlayer.prepareToPlay()
        }
        // 中吉が出た時の音を設定します。
        if let sound = Bundle.main.path(forResource: "punch31", ofType: ".mp3") {
            chukichiAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            chukichiAudioPlayer.prepareToPlay()
        }
        // 小吉が出た時の音を設定します。
        if let sound = Bundle.main.path(forResource: "swish1", ofType: ".mp3") {
            syokichiAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            syokichiAudioPlayer.prepareToPlay()
        }
        // 吉が出た時の音を設定します。
        if let sound = Bundle.main.path(forResource: "light_saber1", ofType: ".mp3") {
            kichiAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            kichiAudioPlayer.prepareToPlay()
        }
        
        // 末吉が出た時の音を設定します。
        if let sound = Bundle.main.path(forResource: "final_attack", ofType: ".mp3") {
            suekichiAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            suekichiAudioPlayer.prepareToPlay()
        }
        // 凶が出た時の音を設定します。
        if let sound = Bundle.main.path(forResource: "damage1", ofType: ".mp3") {
            kyoAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            kyoAudioPlayer.prepareToPlay()
        }
        // 大凶が出た時の音を設定します。
        if let sound = Bundle.main.path(forResource: "flying_pan", ofType: ".mp3") {
            daikyoAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            daikyoAudioPlayer.prepareToPlay()
        }
    }
        
        
        override func viewDidLoad() {
            
            
            
            super.viewDidLoad()
            // 音の準備
            setupSound()
            
        }
        
        
        //デリゲートモーション
        override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
            if motion != UIEventSubtype.motionShake || overView.isHidden == false {
                // シェイクモーション以外では動作させない
                // 結果の表示中は動作させない
                //return
            }
            //5とか１０とかランダムに数字をとる
            let resultNum = Int( arc4random_uniform(UInt32(resultTextArray.count)) )
            switch resultNum {
            case 0:
                self.daikichiAudioPlayer.play()
            case 1:
                self.chukichiAudioPlayer.play()
            case 2:
                self.syokichiAudioPlayer.play()
            case 3:
                self.kichiAudioPlayer.play()
            case 4:
                self.suekichiAudioPlayer.play()
            case 5:
                self.kyoAudioPlayer.play()
            case 6:
                self.daikyoAudioPlayer.play()
            default:
                //print("ok")
                break
            }
            stickLabel.text = resultTextArray[resultNum]
            
            //stick~margin下からどのくらいあるか
            //棒の長さを指定して棒の長さを
            //反対にヒュッとでてくるいめーじ
            //おみくじ棒の高さのマイナス値で書き換えています
            stickBottomMargin.constant = stickHeight.constant * -1
            
            
            //
            UIView.animate(withDuration: 1, animations: {
                
                self.view.layoutIfNeeded()
                
                
            }, completion: { (finished: Bool) in
                
                self.bigLabel.text = self.stickLabel.text
                self.overView.isHidden = false
            })
        }
        
        
        @IBAction func tapRetryButton(_ sender: Any) {
            overView.isHidden = true
            stickBottomMargin.constant = 0
            startAudioPlayer.play()
            startGetAccelerometer()
            
            
        }
        
        // 加速度センサーからの値取得の開始とその処理
        func startGetAccelerometer() {
            // 加速度センサーの検出間隔を指定
            motionManager.accelerometerUpdateInterval = 1 / 100
            
            
            // 検出開始と検出後の処理
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData: CMAccelerometerData?, error: Error?) in
                
                if let acc = accelerometerData {
                    // 各角度への合計速度を取得します。
                    let x = acc.acceleration.x
                    let y = acc.acceleration.y
                    let z = acc.acceleration.z
                    let synthetic = (x * x) + (y * y) + (z * z)
                    
                    // 一定以上の速度になったら音を鳴らします。
                    if synthetic >= 8 {
                        // 音が再生中は重ねて再生できないので、再生開始位置に強制移動して最初から再生し直します。
                        self.audioPlayer.currentTime = 0
                        self.audioPlayer.play()
                    }
                }
            }
            
            
            
            
            
            func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            
        }
        
        
    }
