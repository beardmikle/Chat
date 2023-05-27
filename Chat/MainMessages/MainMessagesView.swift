//
//  MainMessagesView.swift
//  Chat
//
//  Created by beardmikle on 15.05.2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import SDWebImageSwiftUI


struct ChatUser {
    let uid, email, profileImageUrl: String
    let sub: String
}

class MainMessagesViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
        else {
            self.errorMessage = "Coild not find firebase uid"
            return
        }


        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user. Error log:", error)
                return
            
        }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
                
            }

            
        //            self.errorMessage = "Data: \(data.description)"
            let uid = data["uid"] as? String ?? "uid-problem"
            let email = data["email"] as? String ?? "emeail-problem"
            let profileImageUrl = data["profileImageUrl"] as? String ?? "profileImageUrl-problem"
            
            let index = email.range(of: "@")?.lowerBound //my version delete email before "@"
            let sub = email[..<index!] //delete email before "@"
    
            
            self.chatUser = ChatUser(uid: uid, email: email, profileImageUrl: profileImageUrl, sub: String(sub))
            
            
//            default version gmail email delete string
//            self.chatUser = ChatUser(uid: uid, email: email.replacingOccurrences(of: "@gmail.com", with: ""), profileImageUrl: profileImageUrl, sub: String(sub))
            
            
        //            self.errorMessage = chatUser.profileImageUrl

            }
            
        }

    }


struct MainMessagesView: View {
    
    @State var shouldShowLogOutOptions = false
    
    @ObservedObject private var vm = MainMessagesViewModel()
    
    var body: some View {
        NavigationView {

            VStack {
                
//                Text("Current user: \(vm.chatUser?.uid ?? "")")
                
                customNavBar
                messageView

                }
            .overlay(
                newMessageButton, alignment: .bottom).navigationBarHidden(true)
            }

        }
    
    private var customNavBar: some View {
        
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .clipped()
                .cornerRadius(55)
                .overlay(RoundedRectangle(cornerRadius: 55)
                    .stroke(Color.green, lineWidth: 1))
                .shadow(radius: 8)
            
//            default avatar
//            Image(systemName: "person.fill")
//                .font(.system(size: 24, weight: .heavy))
//                .foregroundColor(Color(.systemGreen))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(vm.chatUser?.sub ?? "")")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.systemGreen))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 16))
                        .foregroundColor(Color(.lightGray))
                }
            }
            
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
                print("test gear")
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 30, weight: .bold))
//                            .foregroundColor(Color(.label))
            }

        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    print("handle sign out")
                }),
//                        .default(Text("DEFAULT BUTTON")),
                    .cancel()
            ])
        }
    }
    

    }

private var messageView: some View {
    ScrollView {
        ForEach(0..<10, id: \.self) { num in
            VStack {
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                        .padding(8)
                        .foregroundColor(Color(.systemBlue))
                        .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color.blue, lineWidth: 1)
                                 
                        )
                    
                    VStack(alignment: .leading) {
                        Text("Username")
                            .font(.system(size:16, weight: .bold))
                        Text("Message sent to user")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                    }
                    
                    Spacer()
                    
                    Text("22d")
                        .font(.system(size:14, weight: .semibold))
                }
                Divider()
                    .padding(.vertical, 8)
                
            }.padding(.horizontal)
               
        }
        
    }.padding(.bottom, 50)
}

private var newMessageButton: some View {
    Button {
        print("test")
    } label: {
        HStack {
            Spacer()
            Text("+ New Message")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        
        MainMessagesView()
            .preferredColorScheme(.dark)
        
        MainMessagesView()
    }
}
