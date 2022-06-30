//
//  ContentView.swift
//  AstroPitch-SwiftUI
//
//  Created by Christopher Strickland on 6/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var synth = Synth()
    let frases = [
        "\"Wow, such random\" - Doge",
        "\"Still a better lovestory than twilight\" - Reddit 2012",
        "\"That's... interesting\" - Bob",
        "\"What are you doing with your life...\" - My father"]
    @State var isPlaying = false
    @State var switch1 = false
    @State var switch2 = false
    @State var switch3 = false
    @State var switch4 = false
    @State var switch5 = false
    @State var switch6 = false
    @State var switch7 = false
    @State var switch8 = false
    @State var switch9 = false
    @State var switch10 = false
    @State var switch11 = false
    @State var switch12 = false
    
    //dictionary
    @State var zodiac = [ "Aries": false,
                          "Taurus": false,
                          "Gemini": false,
                          "Cancer": false,
                          "Leo": false,
                          "Virgo": false,
                          "Libra": false,
                          "Scorpio": false,
                          "Sagittarius": false,
                          "Capricorn": false,
                          "Aquarius": false,
                          "Pisces": false]

    var body: some View {
        
        Text("Astropitch")

        HStack{
            
        VStack{
            Toggle(isOn: $switch1) {
                Text("Aries")
            }
            Toggle(isOn: $switch2) {
                Text("Taurus")
            }
            Toggle(isOn: $switch3) {
                Text("Gemini")
            }
            Toggle(isOn: $switch4) {
                Text("Cancer")
            }
            Toggle(isOn: $switch5) {
                Text("Leo")
            }
            Toggle(isOn: $switch6) {
                Text("Virgo")
            }
        }
            VStack{
        
            Toggle(isOn: $switch7) {
                Text("Libra")
            }
            Toggle(isOn: $switch8) {
                Text("Scorpio")
            }
            Toggle(isOn: $switch9) {
                Text("Sagittarius")
            }
            Toggle(isOn: $switch10) {
                Text("Capricorn")
            }
            Toggle(isOn: $switch11) {
                Text("Aquarius")
            }
                Toggle(isOn: $switch12) {
                    Text("Pisces")
                }
          
            }
            
        }        
     
        Button(action: {
            zodiac["Aries"] = switch1
            zodiac["Taurus"] = switch2
            zodiac["Gemini"] = switch3
            zodiac["Cancer"] = switch4
            zodiac["Leo"] = switch5
            zodiac["Virgo"] = switch6
            zodiac["Libra"] = switch7
            zodiac["Scorpio"] = switch8
            zodiac["Sagittarius"] = switch9
            zodiac["Capricorn"] = switch10
            zodiac["Aquarius"] = switch11
            zodiac["Pisces"] = switch12
            
            self.synth.toggleEngine(signs: zodiac)
            self.isPlaying.toggle()
            
            
        }) {
            if isPlaying {
                HStack {
                    Image(systemName: "stop.fill")
                    Text("Stop")
                        .fontWeight(.medium)
                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing))
                .font(.largeTitle)
                .cornerRadius(20)
            } else {
                HStack{
                    Image(systemName: "play.fill")
                    Text("Play")
                        .fontWeight(.medium)
                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                .font(.largeTitle)
                .cornerRadius(20)
                
            }
        }
        if isPlaying {
            Text(frases.randomElement()!)
            .italic()
            .foregroundColor(.gray)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
           
        }
    }
}
