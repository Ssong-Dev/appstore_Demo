//
//  DeveloperAppListView.swift
//  appstore
//
//  Created by jh_song on 2022/03/23.
//

import SwiftUI

struct DeveloperAppListView: View {
    var developerName = ""
    @State var isSearchComplete = false
    @State var searchResult:[String:[AppData]] = [:]
    @State var isAlertPresent = false
    var body: some View {
        ScrollView(showsIndicators:false)
        {
            VStack(alignment:.leading, spacing:0)
            {
                ForEach(searchResult.keys.sorted(by: >), id:\.self){ key in
                    Text(key).font(.system(size:18, weight:.medium)).padding(.bottom, 15)
                    ForEach(searchResult[key] ?? [], id:\.trackName){ item in
                        RecommandListCell(data:item)
                    }
                    
                }
                
            }.padding(.horizontal, 22)
        }.onAppear(perform: {
            AppStore_Api.shared.getPosts_SearchDeveloper(inputText: developerName, failCallback: {
                isAlertPresent = true
            }){
                for item in AppStore_Api.shared.developerAppList.results ?? []
                {
                    for gerne in item.genres ?? []
                    {
                        if searchResult[gerne] != nil
                        {
                            searchResult[gerne]!.append(item)
                        }
                        else
                        {
                            searchResult.updateValue([item], forKey: gerne)
                        }
                        
                    }
                    
                }
                isSearchComplete = true
            }
        })
        .alert(isPresented: $isAlertPresent, content:{
            Alert(title: Text("네트워크 오류"), message: Text("다시 시도해 주세요"), dismissButton: .default(Text("확인")))
        })
    }
}

struct DeveloperAppListView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperAppListView()
    }
}
