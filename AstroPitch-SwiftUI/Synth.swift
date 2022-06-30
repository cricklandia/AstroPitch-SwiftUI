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
    let outputFormat: AVAudioFormat
    let inputFormat: AVAudioFormat?
    let sampleRate: Float
    var isRunning: Bool = false
    
     // de c3 a c6
    let C: [Float] = [130.81, 261.62, 523.24, 1046.5]
    let CS: [Float] = [138.59, 277.18, 554.37]
    let D: [Float] = [146.83, 293.66, 587.32]
    let DS: [Float] = [155.56, 311.13, 622.25]
    let E: [Float] = [164.81, 329.62, 659.24]
    let F: [Float] = [174.61, 349.23, 523.25]
    let FS: [Float] = [185, 370, 740]
    let G: [Float] = [196, 392, 784]
    let GS: [Float] = [207.18, 415.30, 830.61]
    let A: [Float] = [220, 440, 880]
    let AS: [Float] = [233.08, 466.16, 932.33]
    let B: [Float] = [246.94, 493.88, 987.77]
    
    let pitch1: Float = 130.81//, 261.62, 523.24, 1046.5]
    let pitch2: Float = 138.59//, 277.18, 554.37]
    let pitch3: Float = 146.83//, 293.66, 587.32]
    let pitch4: Float = 155.56//, 311.13, 622.25]
    let pitch5: Float = 164.81//, 329.62, 659.24]
    let pitch6: Float = 174.61//, 349.23, 523.25]
    let pitch7: Float = 185//, 370, 740]
    let pitch8: Float = 196//, 392, 784]
    let pitch9: Float = 207.18//, 415.30, 830.61]
    let pitch10: Float = 220//, 440, 880]
    let pitch11: Float = 233.08//, 466.16, 932.33]
    let pitch12: Float = 246.94//, 493.88, 987.77]
    
   
    
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
        self.inputFormat = AVAudioFormat(commonFormat: outputFormat.commonFormat,
                                    sampleRate: outputFormat.sampleRate,
                                    channels: 1,
                                    interleaved: outputFormat.isInterleaved)
        self.sampleRate = Float(outputFormat.sampleRate)
        self.phaseIncrement = (TWO_PI / sampleRate) * frequency
        print(phaseIncrement)
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
    }
    
    func updatePhaseIncrement() {
        self.phaseIncrement = (TWO_PI / sampleRate) * frequency
    }
    
    func startEngine(signs: Dictionary<String, Bool>) {
        do {
            try self.engine.start()
            self.isRunning = true
            print(signs)
//            if (signs["Aries"] == true){
//            self.frequency = self.pitch1
//            }
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
        self.isRunning = false
    }
    
    func toggleEngine(signs: Dictionary<String, Bool>) {
        print("We made it to toggleEngine with our variable as ", signs)
        
        if isRunning {
            stopEngine()
        } else {
            //startEngine(sign: true)
            startEngine(signs: signs)
            print("else start the engine", signs)
        }
    }
}
