//
//  ChatUser.swift
//  Chat
//
//  Created by beardmikle on 28.05.2023.
//

import FirebaseFirestoreSwift

struct ChatUser: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, email, profileImageUrl: String
}



