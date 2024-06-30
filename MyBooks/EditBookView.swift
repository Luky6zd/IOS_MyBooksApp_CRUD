//
//  EditBookView.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 29.06.2024..


import SwiftUI

struct EditBookView: View {
    @Environment(\.dismiss) private var dismiss
    let book: Book
    // state propertiji za svih 8 book propertija (book model) koje zelimo updatat
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    // u onAppear-u kada zelimo da se ucita first view sa propertijima (a ne nakon svakog refresha)
    @State private var firstView = true
    
    var body: some View {
        HStack {
            Text("Status")
            // kreiran picker u kojem je selekcija vezana sa status state varijablom
            Picker("Status", selection: $status) {
                // status je tipa enum kroz koji prolazimo foreach petljom
                ForEach(Status.allCases) { status in
                    Text(status.descript).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            // grupiranje preostalih 7 propertija book-a
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if status == .inProgress || status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) { oldValue, newValue in
                // izvrsit ce se ako nije first view
                if !firstView {
                    if newValue == .onShelf {
                        dateStarted = Date.distantPast
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .completed {
                        // stanje knjige od zavrsene do u progresu citanja
                        dateCompleted = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        // knjiga je zapoceta
                        dateStarted = Date.now
                    } else if newValue == .completed && oldValue == .onShelf {
                        // knjiga "pala u zaborav"
                        dateCompleted = Date.now
                        dateStarted = dateAdded
                    } else {
                        // knjiga zavrsena
                        dateCompleted = Date.now
                    }
                    // ide na false nakon sto su datumi postavljeni
                    firstView = false
                }
            }
            //  element za odvajanje sadrzaja
            Divider()
                LabeledContent {
                    RatingsView(maxRating: 5, currentRating: $rating, width: 30)
                } label: {
                    Text("Rating")
                }
                LabeledContent {
                    TextField("", text: $title)
                } label: {
                    Text("Title").foregroundStyle(.secondary)
                }
                LabeledContent {
                    TextField("", text: $author)
                } label: {
                    Text("Author").foregroundStyle(.secondary)
                }
                Divider()
            
                Text("Summary").foregroundStyle(.secondary)
                TextEditor(text: $summary)
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // prikaz update botuna ako je changed true sa state propertijima
                if changed {
                    Button("Update") {
                        book.status = status
                        book.title = title
                        book.author = author
                        book.rating = rating
                        book.summary = summary
                        book.dateAdded = dateAdded
                        book.dateStarted = dateStarted
                        book.dateCompleted = dateCompleted
                    
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            // spajamo book state propertije sa book model propertijima
            .onAppear {
                status = book.status
                rating = book.rating
                title = book.title
                author = book.author
                summary = book.summary
                dateAdded = book.dateAdded
                dateCompleted = book.dateCompleted
                dateStarted = book.dateStarted
            }
            // boolean computed property koji provjerava promjene na propertijima
            var changed: Bool {
            // provjera ako status nije jednak book statusu ili
                status != book.status
                || rating != book.rating
                || title != book.title
                || author != book.author
                || summary != book.summary
                || dateAdded != book.dateAdded
                || dateCompleted != book.dateCompleted
                || dateStarted != book.dateStarted
            }
        }
    
    //#Preview {
    //    NavigationStack {
    //        EditBookView()
    //    }
    // }
    
}
