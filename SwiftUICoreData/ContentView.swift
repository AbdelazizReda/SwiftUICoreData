//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by Abdelaziz Reda on 27/01/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
    
    @FetchRequest(entity: Fruite.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Fruite.titleOne , ascending: true)])
    var fruites: FetchedResults<Fruite>

    
//    private var items: FetchedResults<Item>


    var body: some View {
        NavigationView {
            List {
                ForEach(fruites) { fruitee in
                    
                    Text(fruitee.titleOne ?? "")
                    
                }
                .onDelete(perform: deleteItems)
                .navigationTitle("Fruits")

            }
            .toolbar {
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

    private func addItem() {
        withAnimation {
            let newFruit = Fruite(context: viewContext)
            newFruit.titleOne = "Orange"
            saveFruits()
        }
    }
    


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //delete using index
            guard let index = offsets.first else {return}
            let fruiteEntity = fruites[index]
            viewContext.delete(fruiteEntity)
            
            saveFruits()
        }
    }
    
    //save items
    func saveFruits(){
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



private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
