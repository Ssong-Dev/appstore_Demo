//
//  DetailView.swift
//  appstore
//
//  Created by jh_song on 2022/03/19.
//

import SwiftUI

struct DetailView: View {
    var data:AppData = AppData()
    @State var descMoreBtnClicked = false
    @State var releaseNoteMoreBtnClicked = false
    @State var isAppListPresent = false
    var body: some View {
        VStack{
            ScrollView(showsIndicators:false)
            {
                VStack(spacing:0)
                {
                    HStack(spacing:0)
                    {
    //                    AsyncImage(url: URL(string: data.artworkUrl512 ?? "")!, content: {
    //                        image in
    //                        image.resizable()
    //                             .aspectRatio(contentMode: .fit)
    //                        frame(width: 100, height: 100).clipShape(RoundedRectangle(cornerRadius: 8))
    //                    }, placeholder: { Text("Loading ...") }).padding(.trailing, 10)
                        AsyncImage(url: URL(string: data.artworkUrl512 ?? "")!,
                                      placeholder: { Text("Loading ...") },
                                   image: { Image(uiImage: $0).resizable() }).frame(width: 100, height: 100).clipShape(RoundedRectangle(cornerRadius: 8)).padding(.trailing, 10)
                        VStack(alignment:.leading, spacing:0)
                        {
                            Text(data.trackName ?? "").font(.title2)
                            Text(data.genres?.first ?? "").font(.caption).padding(.bottom, 8)
                            HStack(spacing:0)
                            {
                                Text("열기").font(.system(size: 14, weight: .bold)).foregroundColor(.white).padding(.horizontal, 20).padding(.vertical, 6).background(RoundedRectangle(cornerRadius: 25).foregroundColor(.blue))
                                Spacer()
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                    }.padding(.vertical, 12)
                    Divider().padding(.bottom, 12)
                    ScrollView(.horizontal, showsIndicators:false)
                    {
                        HStack(alignment:.center, spacing:0)
                        {
                            if data.userRatingCount != 0
                            {
                                VStack(alignment:.leading, spacing:8)
                                {
                                    
    //                                Text("\(CalcFloatRound(input:data.averageUserRatingForCurrentVersion ?? 0.0))")
                                    HStack(spacing:0)
                                    {
                                        Text(String(format:"%.1f",CalcFloatRound(input:data.averageUserRatingForCurrentVersion ?? 0.0)))
                                        FiveStarView(rating: data.averageUserRatingForCurrentVersion ?? 0.0).frame(height: 10).padding(.horizontal, 5)
//                                        StarRating(initialRating: Double(data.averageUserRatingForCurrentVersion ?? 0.0), configuration: $customConfig).frame(width:90, height: 10)
                                    }.padding(.bottom, 5)
                                    
                                    Text("\(CalcNumToString(input:data.userRatingCount ?? 0))개의 평가").font(.caption2)
                                    
                                }.frame(minWidth:100)
                                Divider()
                            }
                            
                            VStack(spacing:8)
                            {
                                Text("연령").font(.caption2)
                                Text(data.trackContentRating ?? "")
                                Text("세").font(.caption)
                            }.frame(minWidth:100)
                            Divider()
                            VStack(spacing:8)
                            {
                                Text("개발자").font(.caption2)
                                Image(systemName: "person.crop.square")
                                Text(data.artistName ?? "").font(.caption).padding(.horizontal, 5)
                            }.frame(minWidth:100)
                            Divider()
                            VStack(spacing:8)
                            {
                                Text("언어").font(.caption2)
                                Text("\(data.languageCodesISO2A?.filter{$0 == (Locale(identifier: Locale.preferredLanguages.first!).languageCode!.uppercased())}.first ?? "")")
                                if data.languageCodesISO2A?.count ?? 0 > 1
                                {
                                    Text("+ \((data.languageCodesISO2A?.count)!-1)개 언어").font(.caption)
                                }
                                
                            }.frame(minWidth:100)
                        }
                        
                    }.padding(.bottom, 12)
                    Divider()
                    VStack(alignment:.leading, spacing:0)
                    {
                        HStack(alignment:.top, spacing: 0)
                        {
                            Text("새로운 기능").font(.system(size:23, weight: .heavy))
                            Spacer()
                            Text("버전 기록").font(.system(size: 14, weight: .regular)).foregroundColor(.blue)
                        }.padding(.bottom, 5)
                       
                        HStack{
                            Text("버전 \(data.version ?? "")").font(.system(size: 13, weight: .light)).foregroundColor(Color("gerneColor")).padding(.bottom, 5)
                            Spacer()
                            Text(CalcDateFromCurrentTime(input: data.currentVersionReleaseDate ?? "")).font(.system(size: 14, weight: .light)).foregroundColor(Color("gerneColor"))
                        }
                        ZStack{
                            HStack{
                                Text("\(data.releaseNotes ?? "")").lineLimit(releaseNoteMoreBtnClicked ? nil : 4)
                                Spacer()
                            }
                            
                            if !releaseNoteMoreBtnClicked
                            {
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Text("더보기").foregroundColor(.blue).padding(.horizontal, 12).padding(.vertical, 4)//.background(RoundedRectangle(cornerRadius: 5))
                                            .onTapGesture {
                                                releaseNoteMoreBtnClicked = true
                                            }
                                    }
                                }
                            }
                        }
                        
                    }.padding(.top, 12).padding(.bottom, 30)
                    ScrollView(.horizontal, showsIndicators: false)
                    {
                        HStack(spacing:10)
                        {
                            ForEach(data.screenshotUrls ?? [], id:\.self){screenshot in
                                AsyncImage(url: URL(string: screenshot)!,
                                              placeholder: { Text("Loading ...") },
                                           image: { Image(uiImage: $0).resizable() }).aspectRatio( contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: 8)).overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2))).frame(maxWidth:300,maxHeight: 400)
    //                            AsyncImage(url: URL(string: screenshot)!, content: { image in
    //                                image.resizable()
    //                                     .aspectRatio(contentMode: .fit)
    //                                     .frame(maxWidth: 300, maxHeight: 100)
    //                            }, placeholder: { Text("Loading ...") }).border(.gray.opacity(0.2)).clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                    Divider().padding(.bottom, 12)
                    ZStack{
                        HStack{
                            Text(data.description ?? "").lineLimit(descMoreBtnClicked ? nil : 4)
                            Spacer()
                        }
                        if !descMoreBtnClicked
                        {
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    Text("더보기").foregroundColor(.blue).padding(.horizontal, 12).padding(.vertical, 4)//.background(RoundedRectangle(cornerRadius: 5))
                                        .onTapGesture {
                                            descMoreBtnClicked = true
                                        }
                                }
                            }
                        }
                        
                    }
                    HStack(alignment:.top){
                        VStack(alignment:.leading, spacing:0)
                        {
                            Text(data.artistName ?? "").font(.caption).foregroundColor(.blue).padding(.bottom, 3)
                            Text("개발자").font(.caption).foregroundColor(.gray.opacity(0.5))
                        }
                        Spacer()
                        Image(systemName: "greaterthan")
                        
                    }.padding(.top, 15)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isAppListPresent = true
                        }
                }.padding(.horizontal, 22)
            }
            Spacer()
            if isAppListPresent{
                NavigationLink(isActive: $isAppListPresent, destination: {
                    DeveloperAppListView(developerName:data.artistName ?? "").navigationTitle(data.artistName ?? "")
                }, label: {
                    EmptyView()
                })
            }
        }.navigationBarTitleDisplayMode(.inline)
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
