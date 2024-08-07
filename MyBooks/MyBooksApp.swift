//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024.


import SwiftUI
import SwiftData

@main
// lokacija gdje se app pokrece -> app main decoratin
struct MyBooksApp: App {
    // container tipa model container
    // pomocu model containera konfiguriramo ime i lokaciju gdje zelimo pohraniti bazu podataka
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        //.modelContainer(for: Book.self)
        // poziv funkcije model container sa argumentom container
        // setiranje containera pomocu funkcije model container
        .modelContainer(container)
    }
    
    // inicijalizator za model container
    init() {
        // konfiguriranje containera
        // schema je objekt koji mapira model klasu u model store u bazi podataka,
        // na taj nacin radimo migraciju podataka
        // za koristenje scheme moramo joj specificirati array knjiga
        let schema = Schema([Book.self])
        // kreiranje konfiguracije modela koja koristi schemu sa imenom baze podataka i definiranu schemu
        let config = ModelConfiguration("MyBooks", schema: schema)
        // kreiranje containera pomocu do-try-catch bloka
        do {
            // pokusa kreirati novi container tipa model container sa schemom i konfiguracijom
            container = try ModelContainer(for: schema, configurations: config)
        // ako catch blok uhvati gresku, aplikacija se nece pokrenuti i ispisat ce gresku na ekranu u obliku recenice
        } catch {
            fatalError("Error: couldn't configure the container")
        }
        
        // konfiguriranje containera -> setiramo ime i lokaciju baze u document directory
        // let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
        // kreiranje containera i dodjeljivanje u "moj" container property
        //do {
        //    container = try ModelContainer(for: Book.self, configurations: config)
        //} catch {
        //    fatalError("Error: couldn't configure the container")
        //}
        
        // putanja do lokacije gdje su spremljeni podaci baze podataka (SQLite), tj.putanja do application support directory-a
        // ispis putanje u konzoli pri paljenju simulatora, percent encoded=false-bez razmaka u putanji
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        // putanja do document direktorija gdje je pohranjena MyBooks baza podataka
        //print(URL.documentsDirectory.path())
    }
}

