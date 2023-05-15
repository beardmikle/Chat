//
//  MainMessagesView.swift
//  Chat
//
//  Created by beardmikle on 15.05.2023.
//

import SwiftUI

struct MainMessagesView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<10, id: \.self) { num in
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(.systemBlue))
                        VStack(alignment: .leading) {
                            Text("Username")
                            Text("Message sent to user")
                        }
                        
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size:14, weight: .semibold))
                           
                    }
                    
                    Divider()
                        .overlay(.green)
                        .frame(height: 4)
                        
                }
            }
            .navigationTitle("Main Message View")
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
