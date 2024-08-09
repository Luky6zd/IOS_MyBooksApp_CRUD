//
//  Book.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024..


import SwiftUI
import SwiftData

// MARK: BOOK

// omotac, pomocu kojeg klasu prikazuje kao model s kojim mozemo raditi u Swift Data
// klasa Book
@Model class Book {
    // definiranje propertia
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    // optional int
    var rating: Int?
    // promjena statusa iz tipa Status u tip rawValue koji je ujedno i Int
    var status: Status.RawValue
    
    // inicijalizacija instanci strukture
    init(
        // parametri inicijalizatora sa defaultnim vrijednostima
        title: String,
        author: String,
        // varijabla tipa datum, vrijednosti trenutnog datuma
        dateAdded: Date = Date.now,
        // varijabla tipa datum, vrijednosti "proslog vremena "
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    )
    
    {   // dodjeljivanje vrijednosti property iz strukture sa property-ima iz inita
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        // promjena statusa u tip rawValue (int)
        self.status = status.rawValue
    }
    
    // varijabla tipa Image
    // computed property za prikaz razlicitih simbola za statuse knjiga,
    // smjesteni lijevo u prikazu liste knjiga
    var icon: Image {
        // promjena iz switcha po varijabli status u switch po Status Enumu
        switch Status(rawValue: status)! { // force unwrap
        // slucaj kad je knjiga na polici
        case .onShelf:
            // prikaz simbola
            Image(systemName: "checkmark.diamond.fill")
        // slucaj kad je knjiga u procesu citanja
        case .inProgress:
            // prikaz simbola
            Image(systemName: "book.fill")
        // slucaj kad je knjiga zavrsena
        case .completed:
            // prikaz simbola
            Image(systemName: "books.vertical.fill")
        }
    }
}

// enum tipa int za pracenje statusa knjige
// za koristenje SwiftData implementiranje protokola Codable
// za Picker implementiranje protokola Identifiable
// za koristenje petlji implementiranje protokola CaseIterable
enum Status: Int, Codable, Identifiable, CaseIterable {
    // 3 case/stanja knjige
    case onShelf, inProgress, completed
    // computed property id tipa Self koji vraća self, za zadovoljiti protokol Identifiable
    var id: Self {
        self
    }
    // varijabla tipa string, computed property
    var bookDescription: String {
        // switch kroz 3 case-a/stanja knjige, svaki case vraća tekst
        switch self {
        // knjiga na polici
        case .onShelf:
            "onShelf"
        // knjiga u procesu citanja
        case .inProgress:
            "InProgress"
        // knjiga zavrsena
        case .completed:
            "Completed"
        }
    }
}
