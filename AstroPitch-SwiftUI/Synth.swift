//
//  Synth.swift
//  Useless_Synth
//
//  Created by Alex Nascimento on 15/04/20.
//  Copyright © 2020 Alex Nascimento. All rights reserved.
//
import AVFoundation


let TWO_PI = Float.pi * 2
let PI = Float.pi

class Synth {
    
    let engine = AVAudioEngine()
    let engine2 = AVAudioEngine()
    var mainMixer: AVAudioMixerNode
    let outputFormat: AVAudioFormat
    let inputFormat: AVAudioFormat?
    let sampleRate: Float
    var isRunning: Bool = false
    
     // de c3 a c6
//    let C: [Float] = [130.81, 261.62, 523.24, 1046.5]
//    let CS: [Float] = [138.59, 277.18, 554.37]
//    let D: [Float] = [146.83, 293.66, 587.32]
//    let DS: [Float] = [155.56, 311.13, 622.25]
//    let E: [Float] = [164.81, 329.62, 659.24]
//    let F: [Float] = [174.61, 349.23, 523.25]
//    let FS: [Float] = [185, 370, 740]
//    let G: [Float] = [196, 392, 784]
//    let GS: [Float] = [207.18, 415.30, 830.61]
//    let A: [Float] = [220, 440, 880]
//    let AS: [Float] = [233.08, 466.16, 932.33]
//    let B: [Float] = [246.94, 493.88, 987.77]
    
    let pitch1: Float = 128.43//256.87//C Aries
    let pitch2: Float = 136.07//C# Cap
    let pitch3: Float = 144.16//D Aqua
    let pitch4: Float = 152.74//D# Scorp
    let pitch5: Float = 161.82//E Sag
    let pitch6: Float =  171.44//F Gem
    let pitch7: Float = 181.63//F# Virgo
    let pitch8: Float = 192.43//384.87//G Libra
    let pitch9: Float = 203.88//G# Cancer
    let pitch10: Float = 216.00//A Leo
    let pitch11: Float = 228.84//A# Taurus
    let pitch12: Float = 242.45//B Pisces
    
   
    
//    lazy var CPentatonic: [Float] = {
//        return C + D + E + FS + A
//    }()
//
//    lazy var CMajor: [Float] = {
//        return C + D + E + F + G + A + B
//    }()
    
    var frequency: Float = 432 // la 432Hz
    var amplitude: Float = 1
    var ariesPhase: Float = 0
    var taurusPhase: Float = 0
    var libraPhase: Float = 0
    var ariesIncrement: Float
    var taurusIncrement: Float
        var geminiIncrement: Float
        var cancerIncrement: Float
        var leoIncrement: Float
        var virgoIncrement: Float
        var libraIncrement: Float
        var scorpioIncrement: Float
        var sagIncrement: Float
        var capIncrement: Float
        var aquaIncrement: Float
        var piscesIncrement: Float
        var ariesNode: AVAudioSourceNode!
        var taurusNode: AVAudioSourceNode!
        var geminiNode: AVAudioSourceNode!
        var cancerNode: AVAudioSourceNode!
        var leoNode: AVAudioSourceNode!
        var virgoNode: AVAudioSourceNode!
        var libraNode: AVAudioSourceNode!
        var scorpioNode: AVAudioSourceNode!
        var sagNode: AVAudioSourceNode!
        var capNode: AVAudioSourceNode!
        var aquaNode: AVAudioSourceNode!
        var piscesNode: AVAudioSourceNode!
    var randomInterval: Double {
        Double.random(in: Double.random(in: 0.1...0.5)...Double.random(in: 0.6...2))
    }
    
    var oscillator: AVAudioSourceNode!
    
    // Signal waves... phase is supposed to be a radian value. The returns are on a range [-1...1]
    var sineWave = { (phase: Float) -> Float in
        return sin(phase)
    }
    
    var triangleWave = { (phase: Float) -> Float in
        return (phase/TWO_PI)
    }
    
    var squareWave = { (phase: Float) -> Float in
        return step(phase, edge: PI) * 2.0 - 1.0
    }
    
    var randomSignal: (Float) -> Float {
        return [sineWave, squareWave, triangleWave].randomElement()!
    }
    
    
    var signal: (Float) -> Float
    
    init() {
        self.mainMixer = self.engine.mainMixerNode
        self.outputFormat = self.engine.outputNode.outputFormat(forBus: 0)
        //self.engine2.outputNode.outputFormat(forBus: 0)
        self.inputFormat = AVAudioFormat(commonFormat: outputFormat.commonFormat,
                                    sampleRate: outputFormat.sampleRate,
                                    channels: 2,
                                    interleaved: outputFormat.isInterleaved)
        self.sampleRate = Float(outputFormat.sampleRate)
                self.ariesIncrement = (TWO_PI / sampleRate) * pitch1
                self.taurusIncrement = (TWO_PI / sampleRate) * pitch11
                self.geminiIncrement = (TWO_PI / sampleRate) * pitch6
                self.cancerIncrement = (TWO_PI / sampleRate) * pitch9
                self.leoIncrement = (TWO_PI / sampleRate) * pitch10
                self.virgoIncrement = (TWO_PI / sampleRate) * pitch7
                self.libraIncrement = (TWO_PI / sampleRate) * pitch8
                self.scorpioIncrement = (TWO_PI / sampleRate) * pitch4
                self.sagIncrement = (TWO_PI / sampleRate) * pitch5
                self.capIncrement = (TWO_PI / sampleRate) * pitch2
                self.aquaIncrement = (TWO_PI / sampleRate) * pitch3
                self.piscesIncrement = (TWO_PI / sampleRate) * pitch12
        print("phaseIncrement = ", ariesIncrement)
        self.signal = sineWave
        
//        setupOscillator()
        self.ariesNode = setupAriesOscillator(phaseIncrement: self.ariesIncrement, signPhase: self.ariesPhase)
        self.taurusNode = setupTaurusOscillator(phaseIncrement: self.taurusIncrement, signPhase: self.taurusPhase)
                //self.taurusNode = setupOscillator(phaseIncrement: self.taurusIncrement)
//                self.geminiNode = setupOscillator(phaseIncrement: self.geminiIncrement)
//                self.cancerNode = setupOscillator(phaseIncrement: self.cancerIncrement)
//                self.leoNode = setupOscillator(phaseIncrement: self.leoIncrement)
//                self.virgoNode = setupOscillator(phaseIncrement: self.virgoIncrement)
        self.libraNode = setupLibraOscillator(phaseIncrement: self.libraIncrement, signPhase: self.libraPhase)
//                self.scorpioNode = setupOscillator(phaseIncrement: self.scorpioIncrement)
//                self.sagNode = setupOscillator(phaseIncrement: self.sagIncrement)
//                self.capNode = setupOscillator(phaseIncrement: self.capIncrement)
//                self.aquaNode = setupOscillator(phaseIncrement: self.aquaIncrement)
//                self.piscesNode = setupOscillator(phaseIncrement: self.piscesIncrement)
        setupEngine(mainMixer: self.mainMixer)
//        startEngine()
    }
    
    func setupAriesOscillator(phaseIncrement: Float, signPhase: Float) -> AVAudioSourceNode {
        return AVAudioSourceNode { (_, _, frameCount, bufferPointer) -> OSStatus in
            
            let audioBufferList = UnsafeMutableAudioBufferListPointer(bufferPointer)
            
            // para cada frame do packet
            for frame in 0..<Int(frameCount) {
                let value = self.signal(self.ariesPhase) * self.amplitude // senoide por enquanto
                
                self.ariesPhase = modulus(self.ariesPhase + phaseIncrement, TWO_PI)
                
                // para cada canal do frame (no caso é só 1 mesmo)
                for buffer in audioBufferList {
                    let samples: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    samples[frame] = value
                }
            }
            return noErr
        }
    }
    
    func setupTaurusOscillator(phaseIncrement: Float, signPhase: Float) -> AVAudioSourceNode {
        return AVAudioSourceNode { (_, _, frameCount, bufferPointer) -> OSStatus in
            
            let audioBufferList = UnsafeMutableAudioBufferListPointer(bufferPointer)
            
            // para cada frame do packet
            for frame in 0..<Int(frameCount) {
                let value = self.signal(self.taurusPhase) * self.amplitude // senoide por enquanto
                
                self.taurusPhase = modulus(self.taurusPhase + phaseIncrement, TWO_PI)
                
                // para cada canal do frame (no caso é só 1 mesmo)
                for buffer in audioBufferList {
                    let samples: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    samples[frame] = value
                }
            }
            return noErr
        }
    }
    
    func setupLibraOscillator(phaseIncrement: Float, signPhase: Float) -> AVAudioSourceNode {
        return AVAudioSourceNode { (_, _, frameCount, bufferPointer) -> OSStatus in
            
            let audioBufferList = UnsafeMutableAudioBufferListPointer(bufferPointer)
            
            // para cada frame do packet
            for frame in 0..<Int(frameCount) {
                let value = self.signal(self.libraPhase) * self.amplitude // senoide por enquanto
                
                self.libraPhase = modulus(self.libraPhase + phaseIncrement, TWO_PI)
                
                // para cada canal do frame (no caso é só 1 mesmo)
                for buffer in audioBufferList {
                    let samples: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    samples[frame] = value
                }
            }
            return noErr
        }
    }
    
    func setupEngine(mainMixer: AVAudioMixerNode) {
//        self.engine.attach(oscillator)
//        self.engine.connect(oscillator, to: engine.mainMixerNode, format: inputFormat)
        self.engine.connect(mainMixer, to: engine.outputNode, format: outputFormat)
        self.engine.mainMixerNode.outputVolume = 0.5
        
//        self.engine2.attach(oscillator)
//        self.engine2.connect(oscillator, to: engine2.mainMixerNode, format: inputFormat)
//        self.engine2.connect(engine.mainMixerNode, to: engine2.outputNode, format: outputFormat)
//        self.engine2.mainMixerNode.outputVolume = 0.5
    }
    
//    func updatePhaseIncrement() {
//        self.phaseIncrement = (TWO_PI / sampleRate) * frequency
//    }
    
    func startEngine(signs: Dictionary<String, Bool>) {
        do {
            //try self.engine.start()
            self.isRunning = true
            print("startEngine()")//, signs)
            if (signs["Aries"] == true){
                
                self.engine.attach(self.ariesNode)
                self.engine.connect(self.ariesNode, to: engine.mainMixerNode, format: inputFormat)
                self.frequency = self.pitch1
                print("Aries ((((((((((((( ON )))))))))))))")
                self.ariesIncrement = (TWO_PI / sampleRate) * pitch1
            }
            else {
                self.engine.detach(self.ariesNode)
                //print("Aries off")
        }
            if (signs["Taurus"] == true){

                self.engine.attach(self.taurusNode)
                self.engine.connect(self.taurusNode, to: engine.mainMixerNode, format: inputFormat)
                self.frequency = self.pitch11
                print("Taurus ((((((((((((( ON )))))))))))))")
                self.taurusIncrement = (TWO_PI / sampleRate) * pitch11
            }
            else {
                self.engine.detach(self.taurusNode)
                //print("Taurus off")
        }
//            if (signs["Gemini"] == true){
//
//                self.engine.attach(self.geminiNode)
//                self.engine.connect(self.geminiNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch6
//                print("Gemini ((((((((((((( ON )))))))))))))")
//                self.geminiIncrement = (TWO_PI / sampleRate) * pitch6
//            }
//            else {
//                self.engine.detach(self.geminiNode)
//                //print("Gemini off")
//        }
//            if (signs["Cancer"] == true){
//
//                self.engine.attach(self.cancerNode)
//                self.engine.connect(self.cancerNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch9
//                print("Cancer ((((((((((((( ON )))))))))))))")
//                self.cancerIncrement = (TWO_PI / sampleRate) * pitch9
//            }
//            else {
//                self.engine.detach(self.cancerNode)
                //print("Cancer off")
//        }
//            if (signs["Leo"] == true){
//
//                self.engine.attach(self.leoNode)
//                self.engine.connect(self.leoNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch10
//                print("Leo ((((((((((((( ON )))))))))))))")
//                self.leoIncrement = (TWO_PI / sampleRate) * pitch10
//            }
//            else {
//                self.engine.detach(self.leoNode)
//                //print("Leo off")
//        }
//            if (signs["Virgo"] == true){
//
//                self.engine.attach(self.virgoNode)
//                self.engine.connect(self.virgoNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch7
//                print("Virgo ((((((((((((( ON )))))))))))))")
//                self.virgoIncrement = (TWO_PI / sampleRate) * pitch7
//            }
//            else {
//                self.engine.detach(self.virgoNode)
//                //print("Virgo off")
//        }
            if (signs["Libra"] == true){

                self.engine.attach(self.libraNode)
                self.engine.connect(self.libraNode, to: engine.mainMixerNode, format: inputFormat)
                self.frequency = self.pitch8
                print("Libra ((((((((((((( ON )))))))))))))")
                self.libraIncrement = (TWO_PI / sampleRate) * pitch8
            }
            else {
                self.engine.detach(self.libraNode)
                //print("Libra off")
        }
//            if (signs["Scorpio"] == true){
//
//                self.engine.attach(self.scorpioNode)
//                self.engine.connect(self.scorpioNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch4
//                print("Scorpio ((((((((((((( ON )))))))))))))")
//                self.scorpioIncrement = (TWO_PI / sampleRate) * pitch4
//            }
//            else {
//                self.engine.detach(self.scorpioNode)
//                //print("Scorpio off")
//        }
//            if (signs["Sagittarius"] == true){
//
//                self.engine.attach(self.sagNode)
//                self.engine.connect(self.sagNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch5
//                print("Sagittarius ((((((((((((( ON )))))))))))))")
//                self.sagIncrement = (TWO_PI / sampleRate) * pitch5
//            }
//            else {
//                self.engine.detach(self.sagNode)
//                //print("Sagittarius off")
//        }
//            if (signs["Capricorn"] == true){
//
//                self.engine.attach(self.capNode)
//                self.engine.connect(self.capNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch2
//                print("Capricorn ((((((((((((( ON )))))))))))))")
//                self.capIncrement = (TWO_PI / sampleRate) * pitch2
//            }
//            else {
//                self.engine.detach(self.capNode)
//                //print("Capricorn off")
//        }
//            if (signs["Aquarius"] == true){
//
//                self.engine.attach(self.aquaNode)
//                self.engine.connect(self.aquaNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch3
//                print("Aquarius ((((((((((((( ON )))))))))))))")
//                self.aquaIncrement = (TWO_PI / sampleRate) * pitch3
//            }
//            else {
//                self.engine.detach(self.aquaNode)
//                //print("Aquarius off")
//        }
//            if (signs["Pisces"] == true){
//
//                self.engine.attach(self.piscesNode)
//                self.engine.connect(self.piscesNode, to: engine.mainMixerNode, format: inputFormat)
//                self.frequency = self.pitch12
//                print("Pisces ((((((((((((( ON )))))))))))))")
//                self.piscesIncrement = (TWO_PI / sampleRate) * pitch12
//            }
//            else {
//                self.engine.detach(self.piscesNode)
//                //print("Pisces off")
//        }
            
            //self.updatePhaseIncrement()
            //self.engine.connect(engine.mainMixerNode, to: engine.outputNode, format: outputFormat)
            try self.engine.start()

            
            
            
            
//            Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: true) { (timer) in
//                if !self.isRunning { timer.invalidate(); return }
//                if sign {
//                    self.frequency = self.pitch1//self.CPentatonic.randomElement()!
//                } else {
//                    self.frequency = 1046.5
//                }
//                //self.frequency = self.pitch1//self.CPentatonic.randomElement()!
//                self.signal =  self.randomSignal
//                self.updatePhaseIncrement()
//            }
        } catch {
            self.isRunning = false
            print("Unable to start engine due to error: \(error)")
        }
    }
    
    func stopEngine() {
        self.engine.stop()
        //self.engine2.stop()
        self.isRunning = false
    }
    
    func toggleEngine(signs: Dictionary<String, Bool>) {
        //print("We made it to toggleEngine with our dictionary as ", signs)
        
        if isRunning {
            print("toggleEngine OFF\n")
            stopEngine()
        } else {
            print("toggleEngine ON")
            startEngine(signs: signs)
            
        }
    }
}
