//
//  SearchView.swift
//  appstore
//
//  Created by jh_song on 2022/03/19.
//

import SwiftUI

struct SearchView: View {
    @State var inputText = ""
    @State var isEditting = false
    @Environment(\.isSearching)
    private var isSearching: Bool
    @State var isSearchComplete = false
    @State var isRecommandComplete = false
    @State var isAlertPresent = false
    var body: some View {
        NavigationView{
            VStack(spacing:0)
            {
                ScrollView(showsIndicators:false)
                {
                    VStack(alignment: .leading, spacing:0)
                    {
                       
                        if isSearchComplete && inputText != ""
                        {
                            ForEach(AppStore_Api.shared.searchResult.results!, id:\.self){appItem in
                                AppDescriptionCell(data:appItem).padding(.vertical, 12)
                                
                            }
                        }
                        else
                        {
                            Group{
                                HStack{
                                    Text("새로운 발견").font(.system(size:23, weight: .heavy))
                                    Spacer()
                                }.padding(.top, 30)
                                Divider().padding(.vertical, 10)
                                HStack{
                                    Text("배달").font(.title2).foregroundColor(.blue)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    inputText = "배달"
                                    isSearchComplete = false
                                    AppStore_Api.shared.getPosts_SearchResult(inputText: inputText, failCallback: {
                                        isAlertPresent = true
                                    }){
                                        
                                        isSearchComplete = true
                                    }
                                }
                                Divider().padding(.vertical, 10)
                                HStack{
                                    Text("카트라이더").font(.title2).foregroundColor(.blue)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    inputText = "카트라이더"
                                    isSearchComplete = false
                                    AppStore_Api.shared.getPosts_SearchResult(inputText: inputText, failCallback: {
                                        isAlertPresent = true
                                    }){
                                        isSearchComplete = true
                                    }
                                }
                                Divider().padding(.vertical, 10)
                                HStack{
                                    Text("포도알").font(.title2).foregroundColor(.blue)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    inputText = "포도알"
                                    isSearchComplete = false
                                    AppStore_Api.shared.getPosts_SearchResult(inputText: inputText, failCallback: {
                                        isAlertPresent = true
                                    }){
                                        isSearchComplete = true
                                    }
                                }
                                Divider().padding(.vertical, 10)
                                HStack{
                                    Text("게임").font(.title2).foregroundColor(.blue)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    inputText = "게임"
                                    isSearchComplete = false
                                    AppStore_Api.shared.getPosts_SearchResult(inputText: inputText, failCallback: {
                                        isAlertPresent = true
                                    }){
                                        
                                        isSearchComplete = true
                                    }
                                }
                                Group{
                                    if isRecommandComplete
                                    {
                                        Text("추천 앱과 게임").font(.system(size:23, weight: .heavy)).padding(.top, 30)
                                        Divider().padding(.vertical, 10)
                                        
                                        ForEach(AppStore_Api.shared.searchResult.results ?? [], id:\.self){appItem in
                                            RecommandListCell(data:appItem).padding(.vertical, 6)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }.padding(.horizontal, 22)
                }
                Spacer()
            }
            .navigationTitle("검색")
            
        }.searchable(text: $inputText, placement: .navigationBarDrawer(displayMode: .always), prompt:Text("게임, 앱, 스토리 등")) {
            
        }
        .onSubmit(of:.search) {
            isSearchComplete = false
            AppStore_Api.shared.getPosts_SearchResult(inputText: inputText, failCallback: {
                isAlertPresent = true
            }){
                isSearchComplete = true
            }
        }
        .onAppear(perform: {
            //추천 앱 리스트 가져오기용. 파라메터를 recommad로 호출
            AppStore_Api.shared.getPosts_recommdList(failCallback: {
                isAlertPresent = true
            }){
                isRecommandComplete = true
            }
        })
        .alert(isPresented: $isAlertPresent, content:{
            Alert(title: Text("네트워크 오류"), message: Text("다시 시도해 주세요"), dismissButton: .default(Text("확인")))
            
        })
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
