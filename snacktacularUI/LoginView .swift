//
//  ContentView.swift
//  snacktacularUI
//
//  Created by Nia Mitchell on 3/20/26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView : View {
    enum Field {
        case email,password
    }
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertmessage = ""
    @State private var buttonDisabled = true
    @State private var presentSheet = false
    @FocusState private var focusField: Field?
    
   
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                
            Group{
                TextField("email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit{
                        focusField = .password
                    }
                    .onChange(of: email) { enableButton()
        
                    }
                
                SecureField("password", text: $password)
                    .submitLabel(.done)
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        focusField = nil
                    }
                    .onChange( of: password){ enableButton()}
            }
            .textFieldStyle(.roundedBorder)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5),lineWidth:2)
            }
            
            HStack{
                Button ("Sign up") {
                    register()
                }
                .padding(.trailing)
                
                Button("Log in"){
                    login()
                }
                .padding(.leading)
            }
            .buttonStyle(.borderedProminent)
            .tint(.snack)
            .font(.title2)
            .padding(.top)
            .disabled(buttonDisabled)
        }
        .padding()
        .alert(alertmessage, isPresented: $showingAlert){
            Button("OK", role: .cancel) { }
        }
        .onAppear(){
            if Auth.auth().currentUser != nil {
                print("🪵 Login successful")
                presentSheet = true
            }
        }
        .fullScreenCover(isPresented: $presentSheet) {
            ListView()
        }
        
    }
    func enableButton(){
        let emailIsGood = email.count >= 6 && email.contains("@")
        
        let passwordIsGood = password.count >= 6
        buttonDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { Result, error in
            if let error = error {
                print("😡 SIGNUP error: \(error.localizedDescription)")
                alertmessage = "Login error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("😎 Registration successful")
                presentSheet = true
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error {
                print("😡 SIGN IN  error: \(error.localizedDescription)")
                alertmessage = "Login error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("🪵 Login successful")
                presentSheet = true
    
            }
        }
    }
    
    
}

#Preview {
    LoginView ()
}
