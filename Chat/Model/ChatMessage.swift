//
//  ChatMessage.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 11/19/21.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatMessage: Codable, Identifiable {
    @DocumentID var id: String?
    let fromId, toId, text: String
    let timestamp: Date
}
