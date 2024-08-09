//
//  ContentView.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024.


import SwiftUI
import SwiftData

// MARK: BOOK LIST

// enum tipa string implementira protokole Identifiable i CaseIterable
enum SortOrder: String, Identifiable, CaseIterable {
    // 3 case-a kroz koje prolazimo
    case status, title, author
    
    // id computed property kreiran radi identifiable protokola koji vraca id (self)
    var id: Self {
        self
    }
}

// struktura tipa View
struct BookListView: View {
    // state property varijabla sa defaultnom vrijednoscu false
    @State private var createNewBook = false
    // state property sa defaultnom vrijednoscu sort ordera po autoru
    @State private var sortOrder = SortOrder.author
    // state property za search tipa String defaultne vrijednosti prazni string
    @State private var filter = ""
    
    // body tipa some View
    var body: some View {
        // kreiranje navigacijske trake
        NavigationStack {
            // kreiranje pickera, vrsi selekciju prema sort orderu
            Picker("", selection: $sortOrder) {
                // petlja prolazi kroz enum sort order
                ForEach(SortOrder.allCases) { sortOrder in
                    // brojac je sortOrder, pomocu kojeg kreiramo text View i prikazujemo opcije sortiranja
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            // stil botuna za picker
            .buttonStyle(.bordered)
            // umetanje komponente
            BookList(sortOrder: sortOrder, filterText: filter)
                // Searchable Modifier
                // funkcija za pretrazivanje
                .searchable(text: $filter, prompt: Text("Search"))
            // umetanje naslova
            .navigationTitle("My Books")
            // kreiranje toolbara sa botunom i simbolom
            .toolbar {
                // na klik se kreira nova knjiga
                Button {
                    return createNewBook = true
                // oznaka simbola
                } label: {
                    // ime slike
                    Image(systemName: "plus.circle.fill")
                        // View Modifier za povecavanje
                        .imageScale(.large)
                }
            }
            // kreiranje novog lista
            .sheet(isPresented: $createNewBook) {
                // vraca new book View
                return NewBookView()
                    // zauzima pola stranice
                    .presentationDetents([.medium])
            }
        }
    }
}

// preview na ekranu(canvasu)
// sample knjige spremljene u memoriji i prikazane na ekranu
#Preview {
    // preview je container book modela
    // kreiranje custom preview containera
    let preview = PreviewContainer(Book.self)
    // pozivanje funkcije za dodavanje primjera knjiga
    // u preview (container) spremamo primjere knjiga sto ih funkcija vrati
    preview.addExamples(Book.sampleBooks)
    // vraca View sa listom knjiga
    return BookListView().background(.peach)
        // pozivanje funkcije model container za preview containera knjiga
        .modelContainer(preview.container)
}
