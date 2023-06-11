//
//  ChatLogView.swift
//  Chat
//
//  Created by beardmikle on 06.06.2023.
//

import SwiftUI

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
    }
    
    func handleSend() {
        print(chatText)
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
    }
}

struct ChatLogView: View {
    
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    
    @ObservedObject var vm = ChatLogViewModel
    
    var body: some View {
        messagesView
   
            .navigationTitle(chatUser?.email ?? "")
                .navigationBarTitleDisplayMode(.inline)

    }
    
    private var messagesView: some View {
        VStack {
            
                ScrollView {
                    ForEach(0..<22) { num in
                            HStack {
                                Spacer()
                                HStack {
                                    Text("Fake MESS NOW")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(15)
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                    
                    HStack { Spacer() }
                    }
        }
                .background(Color(.init(white: 0.96, alpha: 1)))
                .safeAreaInset(edge: .bottom) {
                    chatBottomBar
                        .background(Color(.systemBackground)
                            .ignoresSafeArea())
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 30))
                .foregroundColor(Color(.darkGray))
            ZStack {
                DescriptionPlaceholder()
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
           
            Button {
                vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.green)
            .cornerRadius(8)

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

private struct DescriptionPlaceholder: View {
    var body: some View {
        HStack {
            Text("Please insert some text")
                .foregroundColor(Color(.gray))
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}


struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {

        MainMessagesView()
    }
}
