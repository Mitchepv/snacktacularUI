//
//  ListView.swift
//  snacktacularUI
//
//  Created by Nia Mitchell on 3/20/26.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
            List{
                Text("List items will go here" )
            }
            .listStyle(.plain)
            .navigationTitle("Snack Spot:")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Sign out"){
                        do{
                            try Auth.auth().signOut()
                            print("🪵 ➡️ Log out successful")
                            dismiss()
                        }catch{
                            print("😡Error: coul dnot sign out")
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }
    }
}

#Preview {
    ListView()
}
