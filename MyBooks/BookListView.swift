//
//  ContentView.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024..


import SwiftUI
import SwiftData

struct BookListView: View {
    // environment property sa putanjom ključa od modela knige u bazi
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @State private var createNewBook = false
    
    var body: some View {
        NavigationStack {
            Group {
                // ako je lista knjiga prazna
                if books.isEmpty {
                    ContentUnavailableView("Enter your first book", systemImage: "book.fill")
                    // ako lista nije prazna
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                EditBookView(book: book)
                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading) {
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                        // kreiranje zvjezdica - book ratinga
                                        if let rating = book.rating {
                                            HStack {
                                                ForEach(1..<rating, id: \.self) {
                                                    _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        // swipe u lijevo za obrisati knjigu
                        .onDelete{ indexSet in
                            indexSet.forEach { index in
                                let book = books[index]
                                context.delete(book)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Books")
            .toolbar {
                Button {
                    createNewBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    BookListView()
        .modelContainer(for: Book .self, inMemory: true)
}
