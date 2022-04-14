//
//  APIManager.swift
//  appstore
//
//  Created by jh_song on 2022/03/19.
//

import Foundation


class AppStore_Api: ObservableObject{
    static let shared = AppStore_Api()
    @Published var searchResult = AppStoreResponse()
    @Published var recommadList = AppStoreResponse()
    @Published var developerAppList = AppStoreResponse()
    func getPosts_SearchResult(inputText: String, failCallback: @escaping()->(), completion: @escaping()->()){
        let encodingtext = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL.init(string: "https://itunes.apple.com/search?term=\(encodingtext)&entity=software&country=kr") else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    print("Download fail : \(url)")
                    failCallback()
                    return
            }
            let posts = try! JSONDecoder().decode(AppStoreResponse.self, from:data)
            print(posts)
            self.searchResult = posts
            completion()
        }
        .resume()
    }
    func getPosts_SearchDeveloper(inputText: String, failCallback: @escaping()->(), completion: @escaping()->()){
        let encodingtext = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL.init(string: "https://itunes.apple.com/search?term=\(encodingtext)&entity=software&country=kr") else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    print("Download fail : \(url)")
                    failCallback()
                    return
            }
            let posts = try! JSONDecoder().decode(AppStoreResponse.self, from:data)
            print(posts)
            self.developerAppList = posts
            completion()
        }
        .resume()
    }
    func getPosts_recommdList(failCallback: @escaping()->(), completion: @escaping()->()){
        
        let encodingtext = "recommand".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL.init(string: "https://itunes.apple.com/search?term=\(encodingtext)&entity=software&country=kr") else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil
                else {
                    print("Download fail : \(url)")
                    failCallback()
                    return
            }
            let posts = try! JSONDecoder().decode(AppStoreResponse.self, from:data)
            print(posts)
            self.searchResult = posts
            completion()
        }
        .resume()
    }
}
