//
//  PreviewContainer.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 04.07.2024.


import Foundation
import SwiftData

// struktura
struct PreviewContainer {
    // container tipa model container
    let container: ModelContainer
    
    // initializer
    // An interface that enables SwiftData to manage a Swift class as a stored model.
    // insert modela u koji implementiramo protokol Persistent model, u kojem Swift data ima pristup upravljati klasom kao stored modelom
    // na ovaj nacin u model mozemo insertat ne samo array knjiga, vec i bilo koju drugu @model klasu u Swiftu
    init(_ models: any PersistentModel.Type...) {
        // u config se sprema konfiguracija modela, spremljena samo u memoriji programa
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // schema moze primiti razne vrste @modela, stoga u schemu spremamo nas model
        let schema = Schema(models)
        // kreiranje containera sa do-try-catch blokom
        do {
            // pokusa kreirati novi container tipa model container sa schemom i konfiguracijom
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            // ako catch blok uhvati gresku, aplikacija se nece pokrenuti, ispisat ce gresku na ekranu u obliku recenice
            fatalError("Error: couldn't create preview container")
        }
    }
    
    // funkcija koja skenira primjere knjiga u arrayu knjiga i dodaje ih u container
    // mozemo birati hocemo li dodati @model array knjiga ili any PersistantModel
    func addExamples(_ examples: [any PersistentModel]) { // or [Books]
        // asinkroni task koji se istovremeno vrti u @main threadu-main app
        Task { @MainActor in
            // prolazimo kroz array knjiga sa for each petljom, example je counter(brojac)
            examples.forEach { example in
                // u container main context umecemo example-primjere knjiga
                container.mainContext.insert(example)
            }
        }
    }
}
