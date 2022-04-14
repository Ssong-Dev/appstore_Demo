//
//  AppDescriptionCell.swift
//  appstore
//
//  Created by jh_song on 2022/03/19.
//

import SwiftUI

struct AppDescriptionCell: View {
    var data:AppData = AppData()
    @State var isDetailPresent = false
    //MARK: 검색결과 Cell
    var body: some View {
        VStack(spacing:0)
        {
            HStack(alignment:.center, spacing:0)
            {
                // iOS 15에 추가된 함수는 메모리 리소스가 너무 크다...
//                AsyncImage(url: URL(string: data.artworkUrl100 ?? "")!, content: {
//                    image in
//                    image.resizable()
//                         .aspectRatio(contentMode: .fit)
//                    frame(width: 50, height: 50)
//                }, placeholder: { Text("Loading ...") }).clipShape(RoundedRectangle(cornerRadius: 8)).padding(.trailing, 10)
                AsyncImage(url: URL(string: data.artworkUrl100 ?? "")!,
                              placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() }).frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 8)).padding(.trailing, 10)
                VStack(alignment:.leading, spacing:0)
                {
                    Text(data.trackName ?? "").font(.system(size: 18, weight: .medium)).padding(.leading, 7)
                    Text(data.genres?.first ?? "").font(.system(size: 14, weight: .light)).foregroundColor(Color("gerneColor")).padding(.leading, 7).padding(.bottom, 5)
                    
                    if data.userRatingCount ?? 0 != 0
                    {
                        HStack(alignment:.center, spacing:0)
                        {
                            FiveStarView(rating: data.averageUserRatingForCurrentVersion ?? 0.0).frame(width:90, height: 10).padding(.horizontal, 5)
//                            StarRating(initialRating: Double(data.averageUserRatingForCurrentVersion ?? 0.0), configuration: $customConfig).frame(width:90, height: 10)
                            Text(String(CalcNumToString(input: data.userRatingCount ?? 0))).foregroundColor(.gray).font(.caption2)
                            Spacer()
                            
                        }
                    }
                    Spacer()
                    
                    
                }
                Spacer()
                Text("받기").font(.system(size: 14, weight: .bold)).foregroundColor(.blue).padding(.horizontal, 20).padding(.vertical, 6).background(RoundedRectangle(cornerRadius: 25).foregroundColor(.gray.opacity(0.2)))
            }.frame(height:50).padding(.bottom, 25)
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack(spacing:10)
                {
                    ForEach(data.screenshotUrls ?? [], id:\.self){screenshot in
                        AsyncImage(url: URL(string: screenshot)!,
                                      placeholder: { Text("Loading ...") },
                                   image: { Image(uiImage: $0).resizable() }).aspectRatio( contentMode: .fit).clipShape(RoundedRectangle(cornerRadius: 8)).overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray.opacity(0.2))).frame(maxWidth:300,maxHeight: 200)
                    }
                }
            }
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isDetailPresent = true
        }
        //MARK: NavigationLink 영역
        if isDetailPresent{
            NavigationLink(destination: DetailView(data:data), isActive: $isDetailPresent)
            {
                EmptyView()
            }
        }
    }
}

struct RecommandListCell: View {
    var data:AppData = AppData()
    @State var isDetailPresent = false
    //MARK: 추천 앱 결과 Cell, 개발자 정보 창에서도 사용
    var body: some View {
        VStack(spacing:0)
        {
            HStack(alignment:.center, spacing:0)
            {
                AsyncImage(url: URL(string: data.artworkUrl100 ?? "")!,
                              placeholder: { Text("Loading ...") },
                           image: { Image(uiImage: $0).resizable() }).frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 8)).padding(.trailing, 10)
                VStack(alignment:.leading, spacing:0)
                {
                    HStack(spacing:0)
                    {
                        VStack(alignment:.leading, spacing:0)
                        {
                            Text(data.trackName ?? "").font(.system(size: 18, weight: .medium)).padding(.leading, 7).padding(.bottom, 5).fixedSize(horizontal: false, vertical: true)
                            Text(data.genres?.first ?? "").font(.system(size: 14, weight: .light)).foregroundColor(Color("gerneColor")).padding(.leading, 7).padding(.bottom, 5)

                        }
                        Spacer()
                        Text("받기").font(.system(size: 14, weight: .bold)).foregroundColor(.blue).padding(.horizontal, 20).padding(.vertical, 6).background(RoundedRectangle(cornerRadius: 25).foregroundColor(.gray.opacity(0.2))).padding(.leading, 10)
                    }
                    Rectangle().frame(height:1).foregroundColor(.gray.opacity(0.2)).padding(.top, 10)
                }.padding(.top, 5)
                
            }.frame(height:50).padding(.bottom, 25)
    
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isDetailPresent = true
        }
        //MARK: NavigationLink 영역
        if isDetailPresent{
            NavigationLink(destination: DetailView(data:data), isActive: $isDetailPresent)
            {
                EmptyView()
            }
        }
    }
}
struct AppDescriptionCell_Previews: PreviewProvider {
    static var previews: some View {
        AppDescriptionCell()
    }
}
