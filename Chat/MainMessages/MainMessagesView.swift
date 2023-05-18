//
//  MainMessagesView.swift
//  Chat
//
//  Created by beardmikle on 15.05.2023.
//

import SwiftUI

struct MainMessagesView: View {
    
    @State var shouldShowLogOutOptions = false
    
    var body: some View {
        NavigationView {

            VStack {
                
                HStack(spacing: 16) {
                    
                    Image(systemName: "person.fill")
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(Color(.systemGreen))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("USERNAME")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(.systemBlue))
                        
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
                    }

                }
                .padding()
                .actionSheet(isPresented: $shouldShowLogOutOptions) {
                    .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                        .default(Text("DEFAULT BUTTON"))
                    ])
                }
                
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
            .overlay(
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
                }, alignment: .bottom).navigationBarHidden(true)
            }

        }
    }


struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
