//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024..


import SwiftUI
import SwiftData

@main
// lokacija gdje se app pokrece -> app main decoratin
struct MyBooksApp: App {
    // container property koji konfigurira gdje zelimo pohraniti bazu
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        // metoda model container za knjigu, tu spremamo knjigu
        //.modelContainer(for: Book.self)
        .modelContainer(container)
    }
    
    init() { // inicijalizator
        // objekt koji mapira model classes u data-u (u modelu)
        let schema = Schema([Book.self])
        // kreiranje konfiguracije koja koristi shemu sa imenom baze podataka
        let config = ModelConfiguration("MyBooks", schema: schema)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Error: couldn't configure the container")
        }
        
        // konfiguriranje containera -> setiramo ime i lokaciju baze u document directory
        //let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
        // kreiranje containera i dodjeljivanje u "moj" container property
        //do {
        //    container = try ModelContainer(for: Book.self, configurations: config)
        //} catch {
        //    fatalError("Error: couldn't configure the container")
        //}
        
        // putanja do lokacije gdje su spremljeni podaci baze podataka (SQLite), tj.putanja do application support directory-a
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        // putanja do document direktorija
        //print(URL.documentsDirectory.path())
    }
}

