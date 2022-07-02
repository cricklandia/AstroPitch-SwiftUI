//
//  ContentView.swift
//  AstroPitch-SwiftUI
//
//  Created by Christopher Strickland on 6/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    var synth = Synth()
    let frases = [
        "\"Wow, such random\" - Doge",
        "\"Still a better lovestory than twilight\" - Reddit 2012",
        "\"That's... interesting\" - Bob",
        "\"What are you doing with your life...\" - My father", "\"Will it float?\" - Dave Letterman"]
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
    @State var zoDictionary: Dictionary = [ "Aries": false,
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
        
        VStack{
        Text("astroPitch()")
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(Color.white)
            //.frame(maxWidth: .infinity, maxHeight: 50.0)
            .background(Color.black)
            

            
            HStack{
                
            VStack{ //left col
              
                
                
                Toggle(isOn: $switch1) {
                    
                    Text("Aries")
                        .foregroundColor(Color.red)
                        
                }
                .padding(6.0)
                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
               
                Toggle(isOn: $switch2) {
                    Text("Taurus")
                        .foregroundColor(Color.green)
                }
                .padding(6.0)
                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $switch3) {
                    Text("Gemini")
                        .foregroundColor(Color.white)
                    
                }
                .padding(6.0)
                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
                Toggle(isOn: $switch4) {
                    Text("Cancer")
                        .foregroundColor(Color.blue)
                }
                .padding(6.0)
                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                Toggle(isOn: $switch5) {
                    Text("Leo")
                        .foregroundColor(Color.red)
                }
                .padding(6.0)
                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                Toggle(isOn: $switch6) {
                    Text("Virgo")
                        .foregroundColor(Color.green)
                }
                .padding(6.0)
                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            }//end VSTACK1
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(Color.black)
          
            
                VStack{ //right col
                    
                    Toggle(isOn: $switch7) {
                        Text("Libra")
                            .foregroundColor(Color.white)
                    }
                    .padding(6.0)
                    .border(Color.white, width: 1)
                    Toggle(isOn: $switch8) {
                        Text("Scorpio")
                            .foregroundColor(Color.blue)
                    }
                    .padding(6.0)
                    .border(Color.white, width: 1)
                    Toggle(isOn: $switch9) {
                        Text("Sagittarius")
                            .foregroundColor(Color.red)
                            .lineLimit(1)
                        
                    }
                    .padding(6.0)
                    .border(Color.white, width: 1)
                    
                    Toggle(isOn: $switch10) {
                        Text("Capricorn")
                            .lineLimit(1)
                            .foregroundColor(Color.green)
                    }
                    .padding(6.0)
                    .border(Color.white, width: 1)
                    Toggle(isOn: $switch11) {
                        Text("Aquarius")
                            .foregroundColor(Color.white)
                    }
                    .padding(6.0)
                    .border(Color.white, width: 1)
                    Toggle(isOn: $switch12) {
                        Text("Pisces")
                            .foregroundColor(Color.blue)
                    }
                    .padding(6.0)
                    .border(Color.white, width: 1)
                }//end VSTACK2
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color.black)
        }//end HSTACK
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        Spacer()
            
  
        Button(action: {
            
            zoDictionary["Aries"] = switch1
            zoDictionary["Taurus"] = switch2
            zoDictionary["Gemini"] = switch3
            zoDictionary["Cancer"] = switch4
            zoDictionary["Leo"] = switch5
            zoDictionary["Virgo"] = switch6
            zoDictionary["Libra"] = switch7
            zoDictionary["Scorpio"] = switch8
            zoDictionary["Sagittarius"] = switch9
            zoDictionary["Capricorn"] = switch10
            zoDictionary["Aquarius"] = switch11
            zoDictionary["Pisces"] = switch12
            
            self.synth.toggleEngine(signs: zoDictionary)
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
        }//end BUTTON
        //.padding(.bottom, 100.0)
        
        
        if isPlaying {
            Text(frases.randomElement()!)
            .italic()
            .foregroundColor(.gray)
        }
            Spacer()
        }//end big VSTACK
        .accentColor(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        
    }//var body: some View
    
    
       
}//end struct ContentView: View
 
/*
struct ContentView2: View {

    var synth2 = Synth()
    
    

    var body: some View {
        
        VStack{
        Text("astroPitch() Screen 2")
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(Color.white)
            //.frame(maxWidth: .infinity, maxHeight: 50.0)
            .background(Color.black)
            
        }
        .accentColor(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        
    }//var body: some View
    
    
       
}//end struct ContentView2: View
*/



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            //ContentView2()
           
        }
    }
}

