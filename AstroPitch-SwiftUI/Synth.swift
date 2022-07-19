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
    
    let pitch1: Float = 256.87//C Aries
    let pitch2: Float = 272.14//C# Cap
    let pitch3: Float = 288.33//D Aqua
    let pitch4: Float = 305.47//D# Scorp
    let pitch5: Float = 323.63//E Sag
    let pitch6: Float = 342.88//F Gem
    let pitch7: Float = 363.27//F# Virgo
    let pitch8: Float = 384.87//G Libra
    let pitch9: Float = 407.75//G# Cancer
    let pitch10: Float = 432//A Leo
    let pitch11: Float = 457.69//A# Taurus
    let pitch12: Float = 484.90//B Pisces
    
   
    
    lazy var CPentatonic: [Float] = {
        return C + D + E + FS + A
    }()
    
    lazy var CMajor: [Float] = {
        return C + D + E + F + G + A + B
    }()
    
    var frequency: Float = 432 // la 432Hz
    var amplitude: Float = 1
    var phase: Float = 0
    var phaseIncrement: Float
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
        self.outputFormat = self.engine.outputNode.outputFormat(forBus: 0)
        //self.engine2.outputNode.outputFormat(forBus: 0)
        self.inputFormat = AVAudioFormat(commonFormat: outputFormat.commonFormat,
                                    sampleRate: outputFormat.sampleRate,
                                    channels: 12,
                                    interleaved: outputFormat.isInterleaved)
        self.sampleRate = Float(outputFormat.sampleRate)
        self.phaseIncrement = (TWO_PI / sampleRate) * frequency
        print("phaseIncrement = ", phaseIncrement)
        self.signal = triangleWave
        
        setupOscillator()
        setupEngine()
//        startEngine()
    }
    
    func setupOscillator() {
        self.oscillator = AVAudioSourceNode { (_, _, frameCount, bufferPointer) -> OSStatus in
            
            let audioBufferList = UnsafeMutableAudioBufferListPointer(bufferPointer)
            
            // para cada frame do packet
            for frame in 0..<Int(frameCount) {
                let value = self.signal(self.phase) * self.amplitude // senoide por enquanto
                
                self.phase = modulus(self.phase + self.phaseIncrement, TWO_PI)
                
                // para cada canal do frame (no caso é só 1 mesmo)
                for buffer in audioBufferList {
                    let samples: UnsafeMutableBufferPointer<Float> = UnsafeMutableBufferPointer(buffer)
                    samples[frame] = value
                }
            }
            return noErr
        }
    }
    
    func setupEngine() {
        self.engine.attach(oscillator)
        self.engine.connect(oscillator, to: engine.mainMixerNode, format: inputFormat)
        self.engine.connect(engine.mainMixerNode, to: engine.outputNode, format: outputFormat)
        self.engine.mainMixerNode.outputVolume = 0.5
        
//        self.engine2.attach(oscillator)
//        self.engine2.connect(oscillator, to: engine2.mainMixerNode, format: inputFormat)
//        self.engine2.connect(engine.mainMixerNode, to: engine2.outputNode, format: outputFormat)
//        self.engine2.mainMixerNode.outputVolume = 0.5
    }
    
    func updatePhaseIncrement() {
        self.phaseIncrement = (TWO_PI / sampleRate) * frequency
    }
    
    func startEngine(signs: Dictionary<String, Bool>) {
        do {
            //try self.engine.start()
            self.isRunning = true
            print("startEngine()")//, signs)
            if (signs["Aries"] == true){
                try self.engine.start()
                self.frequency = self.pitch1//CPentatonic.randomElement()!
                
                print("Aries ((( ON )))")
                
            }
            else {
                print("Aries off")
        }
            if (signs["Taurus"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch11
                print("Taurus ((( ON )))")
               
            }
                else {
                    print("Taurus off")
            }
            if (signs["Gemini"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch6
                print("Gemini ((( ON )))")
               
            }
                else {
                    print("Gemini off")
            }
            if (signs["Cancer"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch9
                print("Cancer ((( ON )))")
               
            }
                else {
                    print("Cancer off")
            }
            if (signs["Leo"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch10
                print("Leo ((( ON )))")
               
            }
                else {
                    print("Leo off")
            }
            if (signs["Virgo"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch7
                print("Virgo ((( ON )))")
               
            }
                else {
                    print("Virgo off")
            }
            if (signs["Libra"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch8
                print("Libra ((( ON )))")
               
            }
                else {
                    print("Libra off")
            }
            if (signs["Scorpio"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch4
                print("Scorpio ((( ON )))")
               
            }
                else {
                    print("Scorpio off")
            }
            if (signs["Sagittarius"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch5
                print("Sagittarius ((( ON )))")
               
            }
                else {
                    print("Sagittarius off")
            }
            if (signs["Capricorn"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch2
                print("Capricorn ((( ON )))")
               
            }
                else {
                    print("Capricorn off")
            }
            if (signs["Aquarius"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch3
                print("Aquarius ((( ON )))")
               
            }
                else {
                    print("Aquarius off")
            }
            if (signs["Pisces"] == true){
                try self.engine.start()//engine2 breaks
                self.frequency = self.pitch12
                print("Pisces ((( ON )))")
               
            }
                else {
                    print("Pisces off")
            }
            self.updatePhaseIncrement()

            
            
            
            
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
