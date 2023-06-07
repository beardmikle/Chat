//
//  CreateNewMessageView.swift
//  Chat
//
//  Created by beardmikle on 31.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

class CreateNewMessageViewModel: ObservableObject {
    
    @Published var users = [ChatUser]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users")
            .getDocuments { documentSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    print("Failed to fetch users: \(error)")
                    return
                }
                
                documentSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let user = ChatUser(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
        
                    }

                    
                })
                
            }
    }
}

struct CreateNewMessageView: View {
    
    let didSelectNewUser: (ChatUser) -> ()
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm = CreateNewMessageViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(vm.errorMessage)
                
                ForEach(vm.users) { user in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        didSelectNewUser(user)
                    } label: {
                        HStack {
                            WebImage(url: URL(string: user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 55, height: 55)
                                .clipped()
                                .cornerRadius(55)
                                .overlay(RoundedRectangle(cornerRadius: 55)
                                    .stroke(Color.green, lineWidth: 3))
                                .shadow(radius: 8)
                            Text(user.email)
                                .foregroundColor(Color(.label))
                            Spacer()
                        }.padding(.horizontal)

                    }
                    Divider()
                        .padding(.vertical, 1)

                }
            } .navigationTitle("+ New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue
                                .dismiss()
                        } label: {
                            Text("Cancel")
                        }

                    }
                }
        }
    }
}
struct CreateNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
//        CreateNewMessageView()
        MainMessagesView()
    }
}
