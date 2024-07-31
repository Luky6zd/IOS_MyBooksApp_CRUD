//
//  BookList.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 06.07.2024..
//

import SwiftUI
import SwiftData

struct BookList: View {
    // environment property sa putanjom ključa od modela knjige u bazi
    @Environment(\.modelContext) private var context
    // query property za izbor sortiranja knjiga (po naslovu, autoru, statusu)
    @Query(sort: \Book.status) private var books: [Book]
    
    var body: some View {
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
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let book = books[index]
                            context.delete(book)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    
    BookList()
}
