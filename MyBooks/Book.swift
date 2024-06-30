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
    var rating: Int? // optional in
    var status: Status
    
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
    
    {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    
    // computed property "icon" za razlicite statuse knjiga
    var icon: Image {
        switch status {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
    
}

// enum tipa Int, za SwiftDatu mora biti Codable, za Picker mora biti Identifiable, CaseIterable ako želimo petljom prolaziti kroz case-ove
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
