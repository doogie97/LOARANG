//
//  BookmarkManager.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/08.
//

import Foundation

final class BookmarkManager {
    static let shared = BookmarkManager()
    private var bookmarks: [String : String] = [:]
    
    var count: Int {
        return bookmarks.count
    }
    
    func getUsersArrays() -> [[String]] {
        var name: [String] = []
        var `class`: [String] = []
        for user in bookmarks {
            name.append(user.key)
            `class`.append(user.value)
        }
        
        return [name, `class`]
    }
    
    func setUsers() {
        guard let users = UserDefaults.standard.dictionary(forKey: "bookmarks") as? [String : String] else { return }
        bookmarks = users
    }
    
    func addUser(name: String, `class`: String) {
        bookmarks.updateValue(`class`, forKey: name)
        UserDefaults.standard.set(bookmarks, forKey: "bookmarks")
    }
    
    func removeUser(name: String) {
        bookmarks.removeValue(forKey: name)
        UserDefaults.standard.set(bookmarks, forKey: "bookmarks")
    }
    
    func isContain(name: String) -> Bool {
        return bookmarks.contains {$0.key == name }
    }
    
    private init() {}
}
