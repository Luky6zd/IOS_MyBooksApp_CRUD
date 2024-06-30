//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 10.06.2024..


import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self) // metoda model container za knjigu, tu spremamo knjigu
    }
    
    init() { // inicijalizator
        // putanja na lokaciju gdje je spremljena app
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}

