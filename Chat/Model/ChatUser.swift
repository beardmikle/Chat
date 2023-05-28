//
//  ChatUser.swift
//  Chat
//
//  Created by beardmikle on 28.05.2023.
//

import Foundation

struct ChatUser {
    let uid, email, profileImageUrl: String
    let sub: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? "uid-problem"
        self.email = data["email"] as? String ?? "emeail-problem"
        self.profileImageUrl = data["profileImageUrl"] as? String ?? "profileImageUrl-problem"

        let index = email.range(of: "@")?.lowerBound //my version delete email before "@"
        self.sub = String(email[..<index!]) //delete email before "@"
    }
}
