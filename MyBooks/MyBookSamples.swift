//
//  MyBookSamples.swift
//  MyBooks
//
//  Created by Luky on 09.08.2024.


import Foundation

// MARK: Book samples
// Test data for Preview

// dodatak za klasu Book
extension Book {
    // u varijablu last week sprema se kalendar i current date funkcija s kojom dodajemo dan od 7 dana unazad do danasnjeg datuma
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    // u varijablu last month sprema se kalendar i current date funkcija s kojom dodajemo mjesec od 1 mjeseca unazad do danasnjeg datuma
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    
    // primjeri knjiga tipa array
    static var sampleBooks: [Book] {
        [
             Book(title: "I pad je let",
                 author: "Ajahn Brahm i Chana Guojun",
                 summary: "U slobodnom padu nema ničega čvrstog i ničega za što biste se mogli uhvatiti. Nema načina da se iskustvo kontrolira. Morate se predati, a tom predajom dolazi okus oslobađanja.",
                 rating: 2),
            
            Book(title: "Depra",
                 author: "Aleksandar Stanković",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 summary: "Ovo nije biografija. Pisao sam o jednom posebnom stanju svijesti koje nije slika sreće. Nisam psiholog i ne mogu sugerirati kako treba živjeti. Mogu tek prenijeti vlastito iskustvo bolesti, pojedincu pružiti spoznaju da ima još ljudi koji se osjećaju kao on. Da budem iskren, pišem kako bih pomogao sebi.", 
                 rating: 4,
                 status: Status.inProgress),
            
            Book(title: "Pet stvari za kojima umirući najviše žale",
                 author: "Bronnie Ware",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 summary: "Australka Bronnie Ware nakon dugogodišnje je karijere odlučila potražiti posao koji će je ispuniti većom radošću i smislom. Iako se nije školovala za to, život ju je odveo u svijet palijativne njege. U radu s umirućima, kao i s njihovim obiteljima, susrela se s mnogim mudrim ljudima koji su joj dali sjajne životne savjete i odlučila ih je primjeniti.",
                 rating: 1,
                 status: Status.completed),
            
            Book(title: "Propuh, papuče i punica",
                 author: "Cody McClain Brown",
                 summary: "Vedra priča o prilagođavanju Amerikanca Codya McClaina Browna na život u Hrvatskoj. Nakon što se zaljubi u tajanstvenu, prelijepu hrvatsku djevojku (za koju se zna da je iz Hrvatske, no pretpostavlja da to znači iz Rusije), Cody je uspijeva zavesti i njih se dvoje zajedno sele u Split. Ondje će ga zateći svijet smrtonosnih propuha, beskrajnog ispijanja kave, kao i silovita volja matrijarhalno punice. Propuh, papuče i punica ide dalje od predivnih slika Hrvatske i na komičan način nam otkriva ljepotu hrvatskih ljudi i kulture.",
                 rating: 3),
            
            Book(title: "Pet jezika ljubavi",
                 author: "Gary Chapman",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 summary: "Učeći 5 jezika ljubavi, vi i vaš bračni partner naučit ćete jedinstvene jezike i naučiti praktične korake kako istinski voljeti jedno drugo. Svako poglavljem zbog lakšeg snalaženja, obrađuje po jedan jezik ljubavi, a svako završava sa specifičnim, jednostavnim koracima koje trebate poduzeti kako biste se svome bračnom partneru obratili na specifičnom jeziku i tako svoj brak pokrenuli u pravome smjeru.",
                 status: Status.inProgress),
            
            Book(title: "8 pravila ljubavi",
                 author: "Jay Shetty",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 dateCompleted: Date.now,
                 summary: "Jay Shetty vodi čitatelja zamršenim putevima ljubavi - na prekrasan se način dotičući nesavršenosti naših izbora i izazova.      Izvrstan vodič za rad u ljubavi prema radosti i ispunjenju.",
                 rating: 3,
                 status: Status.completed),
            
            Book(title: "Knjižničarka na konju",
                 author: "Kim Michele Richardson",
                 summary: "Cussy Mary Carter ima plavu boju kože jer je rođena sa rijetkim krvnim poremećajem. S ocem rudarom živi u neimaštini, u abačenu kraju Apalačkog gorja. Posao koji joj se nudi u Vladinu projektu “Knjižnice na konjima” vidi kao svoj put u neovisnost, ali otac ima i druge planove. Želi je udarati i priskrbiti joj zaštitu muža. No Cussy se tvrdoglavo opire ideji udaje. Premda je posao Knjižničarke na konju težak i pun opasnosti, pogotovo za jednu “obojenu”, njezina joj ljubav prema knjigama daje nepokolebljivu snagu."),
            
            Book(title: "Parazit",
                 author: "Magdalena Mrčela",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 summary: "Zbirka priča “Parazit” nastala je iz jednostavnog razloga - straha da priče ne nestanu tako lako kao što nestaju ljudi. Desetak godina kratkopričaških izleta rezultiralo je zbirkom koja se bavi šarolikim temama - svijetom nenaklonjenim malom čovjeku, egzistencijalnim pitanjima, predrasudama, razočaranjima, prijateljstvima, ljubavima i igrom. Igrom u kojoj se, dok žmirite i brojite, u tren oka na poziciji suigrača stvore paraziti. Nemam jednoznačan odgovor kako ih se riješiti. Moji obično nestanu kad im posvetim koje poglavlje knjige.",
                 rating: 5,
                 status: Status.inProgress),
            
            Book(title: "Knjiga utjehe",
                 author: "Matt Haig",
                 dateAdded: lastMonth,
                 dateStarted: lastWeek,
                 summary: "Empatija i jedinstven uvid u sva stanja ljudske duše čine Matta Haifa piscem koji, osim sjajne fikcije, čitateljima isporučuje neponovljiv žanr koji zaslužuje vlastitu kategoriju.",
                 rating: 5,
                 status: Status.completed),
             
             Book(title: "Zelena svjetla",
                  author: "Matthew McConaughey",
                  summary: "Riječ je o ljubavnom pismu. Životu. Ovo je knjiga o hvatanju zelenih svjetala i uviđaju da se i žuta i crvena svjetla s vremenom pretvaraju u zelena."),
             
             Book(title: "Užitak sebičnosti",
                  author: "Michele Elman",
                  summary: "U knjizi Užitak sebičnosti svjetski poznata životna trenerica i influencerica Michelle Elman poučit će vas vještini zdravog određivanja i pridržavanja granica. Postavljanje čvrstih granica poučit će druge kako se trebaju ponašati prema vama, izbacit će iz vašeg života nepotrebne napetosti i toksične odnose te vam omogućiti da sebe i druge volite na najbolji mogući način."),
             
             Book(title: "Oraspoložite se odmah",
                  author: "Olivia Remes",
                  summary: "50 strategija za prevladavanje anksioznosti, panike, stresa i drugih mentalnih izazova."),
             
             Book(title: "Strah",
                  author: "Thich Nhat Nanh",
                  summary: "Neustrašivost ne samo da je moguća, ona je najviša radost. Kada dotaknete nestrah, vi ste slobodni.", rating: 2),
             
             Book(title: "Uvod u programiranje",
                  author: "Vedran Mornar",
                  summary: "Udžbenik Sveučilišta u Zagrebu, sa Fakulteta  elektrotehnike i računarstva."),
             
             Book(title: "La Petite Marie",
                  author: "Vjekoslava Huljić",
                  summary: "Roman La Petite Marie dosad je najzrelije djelo spisateljice Vjekoslave Huljić, roman koji ostavlja bez daha. Ovo je priča o potrazi za izgubljenim obiteljskim korijenima čije se okosnica događa u Splitu i Parizu, a pratimo je na vremenskoj crti dužoj od sto godina. Ovo nije ljubavni roman, ali jest priča o ljubavi, onoj koju nazivamo vječnom, toliko velikoj da je ni rastanak ne može ugušiti. O ljubavi nad ljubavima.", 
                  rating: 6)
        ]
    }
}


