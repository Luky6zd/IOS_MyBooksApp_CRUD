//
//  EditBookView.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 29.06.2024..


import SwiftUI

// MARK: EDIT BOOK

// struktura za editiranje knjiga
struct EditBookView: View {
    // funkcija za izaci iz Viewa
    @Environment(\.dismiss) private var dismiss
    // konstanta tipa Book
    let book: Book
    // privatni state propertiji za svih 8 book propertija iz book modela koje mozemo mijenjati po potrebi
    // defaultne vrijednosti su zadane za sve varijable osim za rating knjige
    @State private var status = Status.onShelf
    // rating je tipa optional int
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    // bit ce mjenjeni kako korisnik bude mijenjao status knjige
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    // u onAppear-u kada zelimo da se ucita first view sa propertijima (a ne nakon svakog refresha)
    @State private var firstView = true
    
    // body tipa some View
    var body: some View {
        // horizontalni stack View za kreiranje izbora knjiga po statusu
        HStack {
            // kreiran tekst status
            Text("Status")
            // kreiran picker status koji vrsi selekciju prema vrijednosti statusa, vezan je za status state varijable
            Picker("Status", selection: $status) {
                // status je tipa enum i iterabilan je
                // statusom prolazimo petljom kroz "sve slucajeve"
                ForEach(Status.allCases) { status in
                    // koristimo status iterator za ispisivanje teksta i statusa na ekranu
                    // tag na status koji pri odabiru updata izbornik status
                    Text(status.bookDescription).tag(status)
                }
            }
            // kreiranje stila botuna
            .buttonStyle(.bordered)
        }
        // vertikalni stack pozicioniran s live strane
        VStack(alignment: .leading) {
            // View grupiranje u box po datumu
            GroupBox {
                // View koji prikazuje/vezuje ime oznake sa njenom vrijenoscu
                LabeledContent {
                    // picker po datumu ispisuje dodani datum
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                // s tekst oznakom
                } label: {
                    // ispisuje date added
                    Text("Date Added")
                }
                // ako je status knjige u procesu citanja ili je knjiga zavrsena
                if status == .inProgress || status == .completed {
                    // View koji prikazuje/vezuje ime oznake sa njenom vrijenoscu
                    LabeledContent {
                        // picker sa datumom pocetka citanja
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    // s tekst oznakom
                    } label: {
                        // ispisuje date started
                        Text("Date Started")
                    }
                }
                // ako je status knjige knjiga zavrsena
                if status == .completed {
                    // View koji prikazuje/vezuje ime oznake sa njenom vrijenoscu
                    LabeledContent {
                        // picker po datumu ispisuje zavrseni datum
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    // s tekst oznakom
                    } label: {
                        // ispisuje date completed
                        Text("Date Completed")
                    }
                }
            }
            // boja slova group boxa
            .foregroundStyle(.secondary)
            // na promjenu vrijednosti statusa
            .onChange(of: status) { oldValue, newValue in
                // izvrsit ce se ako nije prikazan prvi ekran
                if !firstView {
                    // ako je nova vrijednost statusa knjige na polici
                    if newValue == .onShelf {
                        // datum pocetka setiran na "proslo vrijeme"
                        dateStarted = Date.distantPast
                        // datum zavrsetka setiran na "proslo vrijeme"
                        dateCompleted = Date.distantPast
                    // osim ako je nova vrijednost statusa u procesu citanja i stara vrijednost je zavrsena knjiga
                    } else if newValue == .inProgress && oldValue == .completed {
                        // datum zavrsetka setiran na "proslo vrijeme"
                        dateCompleted = Date.distantPast
                    // osim ako je nova vrijednost statusa u procesu citanja i stara vrijednost je na polici
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        // datum pocetka citanja je setiran na trenutni datum
                        dateStarted = Date.now
                    // osim ako je nova vrijednost statusa zavrsena knjiga i stara vrijednost je na polici
                    } else if newValue == .completed && oldValue == .onShelf {
                        // datum zavrsetaka je setiran na trenutni datum
                        dateCompleted = Date.now
                        // datum pocetka je setiran na dodatni datum od usera
                        dateStarted = dateAdded
                    // drugacije
                    } else {
                        // datum zavrsetka knige je setiran na trenutni datum
                        dateCompleted = Date.now
                    }
                    // resetiranje varijable nakon sto su datumi postavljeni
                    firstView = false
                }
            }
            // element(crta) za odvajanje sadrzaja
            //Divider()
            // funkcija koja dodaje prazan prostor na dno
            .padding(.bottom)
            
            // edit book View
            // prikaz ratinga
            LabeledContent {
                // View za editiranje ratinga sa vrijednostima
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            // oznaka teksta
            } label: {
                // tekst View
                Text("Rating")
            }
            // dodan prostor ispod ratinga
            .padding(.bottom)
            // prikaz naslova
            LabeledContent {
                // kreirano polje za unos naslova knjige
                TextField("", text: $title)
            // oznaka teksta
            } label: {
                // tekst View, naslov sa View Modifierima
                Text("Title").foregroundStyle(.secondary)
                    .padding(.trailing)
            }
            // prikaz autora
            LabeledContent {
                // kreirano polje za unos autora knjige
                TextField("", text: $author)
            // oznaka teksta
            } label: {
                // tekst View, autor sa View Modifierom
                Text("Author").foregroundStyle(.secondary)
            }
            //Divider()
            // dodan prostor ispod autora
            .padding(.bottom)
            
            // tekst View
            Text("Summary").foregroundStyle(.secondary)
            // kreirano polje za unos teksta
            TextEditor(text: $summary)
                // dodan prostor izmedu teksta i ruba editora
                .padding(5)
                // preklapanje preko VStacka sa View Modifierima
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
        }
        // dodan prostor oko VStacka
        .padding()
        // obrubi za tekst field
        .textFieldStyle(.roundedBorder)
        // prikaz naslova knjige u nav baru
        .navigationTitle(title)
        // stil prikaza naslova u nav baru
        .navigationBarTitleDisplayMode(.inline)
        // prikaz botuna u alatnoj traci
        .toolbar {
            // ako je promjenjen sadrzaj na ekranu, prikazuje update botun i sprema promjene
            if changed {
                Button("Update") {
                    // vrijednost iz state propertya se sprema u book model propertye
                    // promjena statusa u rawValue
                    book.status = status.rawValue
                    book.title = title
                    book.author = author
                    book.rating = rating
                    book.summary = summary
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateCompleted = dateCompleted
                    // poziv funkcije za izlazak iz Viewa
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        // na pojavu update botuna
        // spajamo book state propertije sa book model propertijima
        .onAppear {
            // povezivanje state propertya iz update Viewa sa book model propertyma
            // promjena statusa u rawValue sa force unwrapom
            status = Status(rawValue: book.status)!
            // state rating = book model rating
            rating = book.rating
            // state title = book model title
            title = book.title
            // state author = book model author
            author = book.author
            // state summary = book model summary
            summary = book.summary
            // state date addes = book model date added
            dateAdded = book.dateAdded
            // state date completed = book model date completed
            dateCompleted = book.dateCompleted
            // state date started = book model date started
            dateStarted = book.dateStarted
        }
        // boolean computed property
        // provjerava da li postoje promjene na propertijima
        var changed: Bool {
            // provjera da li je state status razlicit od book model statusa
            status != Status(rawValue: book.status)!  // force unwrap
            // ili je state rating razlicit od book model ratinga
            || rating != book.rating
            // ili je state title razlicit od book model title
            || title != book.title
            // ili je state author razlicit od book model authora
            || author != book.author
            // ili je state summary razlicit od book model summary
            || summary != book.summary
            // ili je state date addes razlicit od book model date added
            || dateAdded != book.dateAdded
            // ili je state date completed razlicit od book model date completed
            || dateCompleted != book.dateCompleted
            // ili je state date started razlicit od book model date started
            || dateStarted != book.dateStarted
        }
    }
}

// prikaz na canvasu
#Preview {
    // kreiranje custom preview containera
    let preview = PreviewContainer(Book.self)
    // Preview vraca Navigation stack View sa listom knjiga
    return NavigationStack {
        // prikaz edit book ekrana za primjerom knjige, primjer knjige na indexu 5
        EditBookView(book: Book.sampleBooks[5])
            // pozivanje funkcije za prikaz knjiga iz preview containera
            .modelContainer(preview.container)
    }
}

