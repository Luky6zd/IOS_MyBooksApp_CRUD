//
//  NewBookView.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 28.06.2024..


import SwiftUI

// kreiranje nove knjige
struct NewBookView: View {
    // environment varijabla, pristup contextu preko model context putanje
    @Environment(\.modelContext) private var context
    // environment varijabla za poziv dismiss akcije
    @Environment(\.dismiss) var dismiss
    
    // state propertiji
    @State private var title = ""
    @State private var author = ""
    
    var body: some View {
        // kreiranje navigacijske trake
        NavigationStack {
            // kreiranje formulara sa 2 tekstualna polja i botunom "create"
            Form {
                TextField("Book Title", text: $title)
                TextField("Author", text: $author)
                Button("Create") {
                    // dodavanje nove knjige
                    let newBook = Book(title: title, author: author)
                    // umetanje nove knjige u context modela
                    context.insert(newBook)
                    // po zavrsetku umetanja nove knjige, odbacivanje stranice
                    dismiss()
                }
                // View Modifieri za formular
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                // botun create je onemogucen ako nisu unesena oba polje
                .disabled(title.isEmpty || author.isEmpty)
                // naslov
                .navigationTitle("New Book")
                // prikaz naslova
                .navigationBarTitleDisplayMode(.inline)
                // alatna traka
                .toolbar {
                    // dodavanje itema-cancel botuna sa lijeve strane
                    ToolbarItem(placement: .topBarLeading) {
                        // kreiranje cancel botuna ako ne zelimo kreirati novu knjigu
                        Button("Cancel") {
                            // pozivanje dismiss funkcije
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewBookView()
}
