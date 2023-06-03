//
//  AddBookView.swift
//  Bookworm
//
//  Created by Uriel Ortega on 31/05/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc // To save books.
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Others"
    @State private var review = ""
    @State private var date = Date.now
    
    let genres = ["Others", "Fantasy", "Horror", "Kids", "Mistery", "Poetry", "Romance", "Thiller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = date
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                }
                .disabled(title.isPureWhitespace || author.isPureWhitespace)
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
