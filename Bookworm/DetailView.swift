//
//  DetailView.swift
//  Bookworm
//
//  Created by Uriel Ortega on 02/06/23.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStackLayout(alignment: .bottomTrailing) {
                Image(book.genre ?? "Others")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "Others")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(x: -5, y: -5)
            }
            
            Text("By \(book.author ?? "Unknown Author")")
                .font(.title3.italic())
                .foregroundColor(.secondary)
                .padding()
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
                        
            VStack {
                Text("Registered on")
                Text(book.date ?? Date.now, format: .dateTime.day().month().year())
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.vertical)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {  }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        
        dismiss()
    }
}
