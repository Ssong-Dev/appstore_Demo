//
//  ContentView.swift
//  appstore
//
//  Created by jh_song on 2022/03/19.
//

import SwiftUI

struct ContentView: View {
    @State var selectTag = "search"
    var body: some View {
        
            TabView(selection:$selectTag){
                Text("투데이").tabItem({
                    Text("투데이")
                    Image(systemName: "note.text")
                }).tag("today")
                Text("게임").tabItem({
                    Text("게임")
                    Image(systemName: "gamecontroller.fill")
                }).tag("game")
                Text("앱").tabItem({
                    Text("앱")
                    Image(systemName: "square.stack")
                }).tag("app")
                Text("업데이트").tabItem({
                    Text("업데이트")
                    Image(systemName: "square.and.arrow.down.fill")
                }).tag("arcade")
                SearchView().tabItem({
                    Text("검색")
                    Image(systemName: "magnifyingglass")
                }).tag("search")
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
