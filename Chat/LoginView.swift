 
//  Chat
//
//  Created by beardmikle on 10.05.2023.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    @State var shouldShowImagePicker = false //image picker avatar
        
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 18) {
                    Picker(selection: $isLoginMode, label: Text("Picker here"))
                    {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                    
                    if !isLoginMode {
                        Button
                        {
                            shouldShowImagePicker //image picker avatar
                                .toggle()
                        } label: {
                            
                            VStack {
                                if let image = self.image
                                {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person")
                                        .font(.system(size: 69))
                                        .padding()
//                                        .foregroundColor(Color(.systemMint))
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                . stroke(lineWidth:3)
                            )
                        }
                        
                        
                    }
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                    }
                    .padding(13)
                    .background(Color.white)
                    
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack
                        {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.red)
                    
                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
               
        }
    }
    
    @State var image: UIImage?
    
    private func handleAction() {
        if isLoginMode {
//            print("Should log in Firebase")
            loginUser()
        } else {
            createNewAccount()
//            print("Register a new account of Firebase")
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to login user! Error: ", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            
            print("Successfuly logged in as user: \(result?.user.uid ?? "") ")
            
            self.loginStatusMessage = "Successfuly logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to create user! Error: ", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successfuly created user: \(result?.user.uid ?? "") ")
            
            self.loginStatusMessage = "Successfuly created user: \(result?.user.uid ?? "")"
            
            self.persistImageToStorage()
        }
    }
    
    private func persistImageToStorage() {
//        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Problem with to push avatar image to Storage: \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err
                {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                self.loginStatusMessage = "Successfulle stored image with url: \(url?.absoluteString ?? "")"
                
                guard let url = url else { return }
                self.storeUserInformation(imageProfileUrL: url)
            }
        }
    }
    
    private func storeUserInformation(imageProfileUrL: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "profileImageUrl": imageProfileUrL.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
                print("Success")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

