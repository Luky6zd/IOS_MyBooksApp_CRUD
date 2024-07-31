//
//  ContentView.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024..


import SwiftUI
import SwiftData

// enum tipa string, protokoli identifiable i case iterable
enum SortOrder: String, Identifiable, CaseIterable {
    // 3 case-a za prolazak kroz
    case status, title, author
    
    // computed property kreiran radi identifiable protokola koji vraca self
    var id: Self {
        self
    }
}

struct BookListView: View {
    // state property varijabla sa defaultnom vrijednoscu false
    @State private var createNewBook = false
    // state property varijabla sa defaultnom vrijednoscu sort ordera po statusu
    @State private var sortOrder = SortOrder.status
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            
            BookList()
            
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

// preview na ekranu(canvasu)
// sample knjige spremljene u memoriji i prikazane na ekranu
#Preview {
    // instanca preview strukta-book model
    let preview = Preview(Book.self)
    // pozivanje funkcije sa argumentom book array book samples
    preview.addExamples(Book.sampleBooks)
    return BookListView()
        // model container za knjigu u memoriji, preview container property
        .modelContainer(preview.container)
}
