//
//  ChatLogView.swift
//  Chat
//
//  Created by beardmikle on 06.06.2023.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    @State var chatText = ""
    
    var body: some View {
        VStack {
            messagesView
            
            chatBottomBar
            
                .navigationTitle(chatUser?.email ?? "")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var messagesView: some View {
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
            TextField("Description", text: $chatText)
           
            Button {
                
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

    struct ChatLogView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                ChatLogView(chatUser: .init(data: ["uid": "xK8TyAjmnTWpSAA17GDV07Cyl3p1", "email" : "man@gmail.com"]))
            }
        }
    }
}
