//
//  ContentView.swift
//  Bookworm
//
//  Created by Uriel Ortega on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc // To delete books.
    @FetchRequest(sortDescriptors: [ // For sorting books...
        SortDescriptor(\.title), // ...by its title...
        SortDescriptor(\.author) // ...and then by its author.
    ]) var books: FetchedResults<Book> // For reading all the books we have.
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
