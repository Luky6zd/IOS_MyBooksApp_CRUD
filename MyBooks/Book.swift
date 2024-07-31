//
//  Book.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024..


import SwiftUI
// making model into a swift data object
import SwiftData

// macro -> kreira "model knjige" tj.pri kreiranju nove knjige postavljat cemo ime i autora, ostali propertiji ce imati defaltnu vrijednost
@Model
class Book {
    // property-ji
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int? // optional int
    // refaktoriranje statusa iz tipa Status u tip Int koji je ujedno i rawValue
    var status: Status.RawValue // ili tip Int
    
    // kada koristimo klasu trebamo inicijalizator -> konstruktor
    init( // parametri inicijalizatora
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    )
    
    { // inicijalizacija propertija
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        // refaktoriranje statusa u tip Int(rawValue)
        self.status = status.rawValue
    }
    
    // computed property "icon" za razlicite statuse knjiga
    var icon: Image {
        // refaktoriranje iz switcha po statusu u switch po Enumu
        switch Status(rawValue: status)! { // force unwrap
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
    
}

// enum  Status tipa Int, za SwiftData-u mora imati ponasanje Codable, za Picker mora biti Identifiable, CaseIterable ako želimo petljom prolaziti kroz case-ove
enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed // 3 case-a/stanja knjige
    
    var id: Self { // computed id property tipa Self koji vraća self -> za zadovoljiti protokol Identifiable
        self
    }
    
    var descript: String { // computed descript property tipa String -> za Picker
        switch self { // switch on self -> switch kroz 3 case-a/stanja knjige -> svaki case vraća text
        case .onShelf:
            "onShelf"
        case .inProgress:
            "InProgress"
        case .completed:
            "Completed"
        }
    }
}
