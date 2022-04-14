//
//  Data.swift
//  appstore
//
//  Created by jh_song on 2022/03/19.
//

import Foundation

struct AppStoreResponse:Codable{
    var resultCount:Int?
    var results:[AppData]?
    
}

struct AppData:Codable,Hashable{
    var wrapperType:String?
    var explicitness:String?
    var screenshotUrls:[String]?
    var artworkUrl60:String?
    var artworkUrl100:String?
    var artworkUrl512:String?
    var trackContentRating:String?
    var releaseDate:String?
    var currentVersionReleaseDate:String?
    var trackName:String?
    var primaryGenreName:String?
    var sellerName:String?
    var releaseNotes:String?
    var description:String?
    var artistName:String?
    var genres:[String]?
    var price:Float?
    var version:String?
    var userRatingCount:Int?
    var averageUserRatingForCurrentVersion:Float?
    var languageCodesISO2A:[String]?
}
