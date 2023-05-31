//
//  CreateNewMessageView.swift
//  Chat
//
//  Created by beardmikle on 31.05.2023.
//

import SwiftUI

class CreateNewMessageViewModel: ObservableObject {
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        
    }
}

struct CreateNewMessageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<10) { num in
                    Text("User agent")
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
