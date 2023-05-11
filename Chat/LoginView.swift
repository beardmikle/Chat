 
//  Chat
//
//  Created by beardmikle on 10.05.2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    init() {
        FirebaseApp.configure()
    }
    
    
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
                        Button {
                            
                        } label: {
                            Image(systemName: "person")
                                .font(.system(size: 69))
                                .padding()
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

                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea())
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
  
    }
    
    private func handleAction() {
        if isLoginMode {
            print("Should log in Firebase")
        } else {
            print("Reister a new account of Firebase")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
