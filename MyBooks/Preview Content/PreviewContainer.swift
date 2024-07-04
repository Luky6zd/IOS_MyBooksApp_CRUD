//
//  PreviewContainer.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 04.07.2024..


import Foundation
import SwiftData

struct Preview {
    // property tipa model container
    let container: ModelContainer
    
    // kreiranje containera sa do-try-catch blokom
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Error: couldn't create preview container")
        }
    }
    
    // funkcija s kojom dodajemo primjere knjiga tipa array
    func addExamples(_ examples: [Book]) {  // [any PersistentModel]
        // asinkroni task gdje koristimo main actor za akciju u threadu
        Task { @MainActor in
            // prolazimo kroz array knjiga sa for each petljom i koristimo container main context za umetnuti example
            examples.forEach { example in
                container.mainContext.insert(example)
            }
        }
    }
}
