//
//  ChatUser.swift
//  Chat
//
//  Created by beardmikle on 28.05.2023.
//

import Foundation


struct ChatUser: Identifiable {
    var id: String { uid }
    
    let uid, email, profileImageUrl: String
    let sub: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""

        let index = email.range(of: "@")?.lowerBound //delete email symbol "@" and after
        self.sub = String(email[..<index!]) //delete email symbol "@" and after
    }
}


