//
//  ArtHistoryDetailView.swift
//  VirtualGallery
//
//  Created by James Wu on 2021-06-01.
//

import SwiftUI

struct ArtHistoryDetailView: View {
    @State private var isNavigationBarHidden = false
    let period : Period
    @EnvironmentObject var artists: ArtistsStore
    
    var body: some View {
        ScrollView {
            
            Image(period.name).resizable().scaledToFit()
            Text(period.name) .font(.system(.title, design: .serif)).bold()
            Text(period.time) .font(.system(.title2, design: .serif))
            VStack {
                Text("Artwork Characteristics:").font(.system(.title2, design: .serif)).bold().multilineTextAlignment(.center).padding(.top)
                Text(period.characteristics).font(.system(.title2, design: .serif)).multilineTextAlignment(.center)
            }
            
            VStack {
                Text("Leading Contributors: ").font(.system(.title2, design: .serif)).bold().multilineTextAlignment(.center).padding(.top)
                Text("\(period.contributors)").font(.system(.title2, design: .serif)).multilineTextAlignment(.center)
            }
            
            Spacer(minLength: 30)
            
            Text(period.description).font(.system(.title2, design: .serif)).padding(.all).fixedSize(horizontal: false, vertical: true)
            
            if !period.artists.isEmpty {
                HStack {
                    Text("Leading Artists:").font(.system(.title2, design: .serif)).bold().padding()
                    Spacer()
                }
//                HStack {
//                    Spacer()
//                    Text("↓ Tap to see more about the artist! ↓").font(.system(.title2, design: .serif)).padding()
//                    Spacer()
//                }
                
                // Issue: Is there a better algorithm?
                ForEach(period.artists){artist in
                    NavigationLink(destination: ArtistDetailView(artist: artist)){
                        VStack {
                            ZStack {
                                Image(artist.name).resizable().scaledToFit()
                                VStack {
                                    Spacer()
                                    Text("Click to see more")
                                        .font(.system(.title2,design: .serif))
                                        .bold()
                                        .colorScheme(.light)
                                        .padding(.all)
                                        .colorInvert()
                                        .foregroundColor(.secondary)
                                }
                            }
                            VStack {
                                Text(artist.name).padding(.bottom, 1)
                                Text(artist.age)
                            }.font(.system(.title2, design: .serif))
                            .foregroundColor(.black)
                            
                            Spacer().frame(height: 15.0)
                        }
                        
                    }.padding()
                    
                }
            }
            
        }.ignoresSafeArea().navigationBarHidden(isNavigationBarHidden).onTapGesture {
            isNavigationBarHidden.toggle()
        }
    }
}

struct ArtHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtHistoryDetailView(period: Period.example)
    }
}
