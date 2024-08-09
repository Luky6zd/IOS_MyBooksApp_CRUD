//
//  RatingsView.swift
//  MyBooks
//
//  Created by Lucrezia Odrljin on 29.06.2024..


import SwiftUI

// MARK: RATING

// RatingsView predstavlja ocjenu koju user daje knjizi
//     RatingsView(maxRating: 10,
//              currentRating: $currentRating,
//              width: 20,
//              color: .red,
//              ratingImage: .flag)

// struktura tipa View
public struct RatingsView: View {
    // omotac za spajanje vrijednosti
    @Binding var currentRating: Int?
    // setiranje propertya
    var maxRating: Int
    var width:Int
    var color: UIColor
    var sfSymbol: String
    
    // kreiranje inicijalizatora i setiranje defaultnih vrijednosti ratinga
    public init(
        maxRating: Int,
        currentRating: Binding<Int?>,
        width: Int = 50,
        color: UIColor = .red,
        sfSymbol: String = "heart"
    ) {
        // pridruzivanje vrijednosti propertya iz strukture propertyu iz inita
        self.maxRating = maxRating
        self._currentRating = currentRating
        self.width = width
        self.color = color
        self.sfSymbol = sfSymbol
    }
    
    // body tipa some View
    public var body: some View {
        // horizontalni stack View
        HStack {
            // Image View sa View modifikatorima
            Image(systemName: sfSymbol)
                .resizable()
                .scaledToFit()
                .symbolVariant(.slash)
                .foregroundStyle(Color(color))
                .onTapGesture {
                    withAnimation{
                        currentRating = nil
                    }
                }
                // ako je trenutni rating 0, ako je true opacity je vidljiva, ako je false onda je transparentna/nevidljiva
                .opacity(currentRating == 0 ? 0 : 1)
            
            // petlja krece od 1 do vrijednosti max ratinga
            // rating je kontrolna varijabla
            ForEach(1...maxRating, id: \.self) { rating in
                // kreira i prikazuje simbol ratinga
               Image(systemName: sfSymbol)
                    .resizable()
                    .scaledToFit()
                    .fillImage(correctImage(for: rating))
                    .foregroundStyle(Color(color))
                    .onTapGesture {
                        withAnimation{
                            currentRating = rating + 1
                        }
                    }
            }
        }
        // okvir rating simbola
        .frame(width: CGFloat(maxRating * width))
    }
    
    // funkcija za korekciju simbola prima int, vraca bool
    func correctImage(for rating: Int) -> Bool {
        // ako je rating manji od trenutnog ratinga
        if let currentRating, rating < currentRating {
            // vrati true
            return true
        // drugacije, vrati false
        } else {
            return false
        }
    }
}

// struktura implementira protokol ViewModifier
struct FillImage: ViewModifier {
    // varijabla tipa bool
    let fill: Bool
    
    // funkcija body prima generic Content, vraca some View,
    // primjenjuje fill na simbol zvjedice
    func body(content: Content) -> some View {
        // ako je fill true
        if fill {
            // primjeni i prikazi content simbol sa ispunom
            content
                .symbolVariant(.fill)
        // ako nije, vrati content
        } else {
            content
        }
    }
}

// dodatak View-u
extension View {
    // funkcija za popuniti sliku simbola
    // prima bool, vraca some View, ovisno jel fill true ili false odradit ce ispunu simbola
    func fillImage(_ fill: Bool) -> some View {
       // vraca modifier za ispunu boje
       return modifier(FillImage(fill: fill))
    }
}

// prikaz na canvasu
#Preview {
    // struktura tipa View
    struct PreviewWrapper: View {
        // state varijabla optional int
        @State var currentRating: Int? = 4
        
        // body tipa some View
        var body: some View {
            // View za prikaz ratinga u preview canvasu
            RatingsView(
                // prikaz varijabli sa vrijednostima
                maxRating: 5,
                currentRating: $currentRating,
                width: 60,
                color: .systemYellow,
                sfSymbol: "star"
            )
        }
    }
    // vrati view preview wrapper
    return PreviewWrapper()
}
