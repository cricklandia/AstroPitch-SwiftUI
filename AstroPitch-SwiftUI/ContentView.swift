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

    var body: some View {
        
     
        VStack{
            
            NavigationView {
               
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            Text(item.timestamp!, formatter: itemFormatter)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("astroPitch()")
                            .font(.title)
                            .foregroundColor(Color.purple)
                    }
                    
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                        
                    }
                   
                }
                Text("Select an item")
            }
        }
        
        //
        
        Text("Totally Random Synth")
            .font(.largeTitle)
            .fontWeight(.medium)
        Button(action: {
            self.synth.toggleEngine()
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
        
            
        
        

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}





private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
           
        }
    }
}
