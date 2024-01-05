//
//  Login.swift
//  RoboChef
//
//  Created by Alex Pallozzi on 5/8/23.
//

import SwiftUI

struct Signup: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String = ""
    @State private var isLinkActive = false
    @State private var isSignupSuccessful = false
    @State private var showError = false

    func signup() async {
        let url = URL(string: "http://localhost:8080/auth/register")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "email": email
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("Failed to serialize parameters: \(error)")
            return
        }

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                isSignupSuccessful = true
            } else {
                print("Incorrect credentials")
                print(httpResponse)
            }
        } catch {
            print("Error during signup: \(error)")
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("color2").ignoresSafeArea()
                VStack {
                    VStack {
                        ZStack {
                            Ellipse().frame(width: 450, height: 420)
                                .padding(.trailing, -500)
                                .foregroundColor(Color("color3"))
                                .padding(.top, -350);
                        
                            Text("Create your\n")
                                .foregroundColor(.white)
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 100)
                                .padding(.leading, 20)
                                .padding(.top, -175)
                            Text("RoboChef")
                                .foregroundColor(.black)
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 100)
                                .padding(.leading, 20)
                                .padding(.top, -115)
                            Text("Account")
                                .foregroundColor(.white)
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 100)
                                .padding(.leading, 20)
                                .padding(.top, -50)
                        }

                        VStack(spacing: 30) {
                            VStack(spacing: 30){
                                CustomTextField(placeHolder: "Username", imageName: "person", bColor: "color7", tOpacity: 0.6, value: $username)
                                CustomTextField(placeHolder: "Password", imageName: "lock", bColor: "color7", tOpacity: 0.6, value: $password)
                                CustomTextField(placeHolder: "Confirm Password", imageName: "lock", bColor: "color7", tOpacity: 0.6, value: $confirmPassword)
                                CustomTextField(placeHolder: "Email", imageName: "envelope", bColor: "color7", tOpacity: 0.6, value: $email).padding(.bottom, 20)
                            }
                            
                            VStack(alignment: .trailing) {
                                
                                NavigationLink(destination: Home(), isActive: $isSignupSuccessful) {
                                    Button(action: {
                                        Task {
                                            await self.signup()
                                        }
                                    }, label: {
                                        CustomButton(title: "Sign In", bgColor: "color3");
                                    })
                                }
                            }.padding(.horizontal, 20)
                            
                            HStack(spacing: 20) {
                                GeometryReader { geometry in
                                    Button(action: {}, label: {
                                        Image("fb")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .frame(width: min(geometry.size.width, 200)) // Set a maximum width (e.g., 200), but adjust to screen size if smaller
                                            .padding(.vertical, 15)
                                            .background(Color("color3"))
                                            .cornerRadius(15)
                                    })
                                }
                                
                                GeometryReader { geometry in
                                    Button(action: {}, label: {
                                        Image("insta")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .frame(width: min(geometry.size.width, 200)) // Set a maximum width (e.g., 200), but adjust to screen size if smaller
                                            .padding(.vertical, 15)
                                            .background(Color("color3"))
                                            .cornerRadius(15)
                                    })
                                }
                            }
                            .padding(.horizontal, 20)
                            
                            Spacer()
                            
                            HStack {
                                Text("Already Have an Account?")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18));
                                
                                NavigationLink(destination: Login(), isActive: $isLinkActive) {
                                    Button(action: {
                                        self.isLinkActive = true
                                    }, label: {
                                        Text("SIGN IN")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                    })
                                }
                            }
                            .frame(height: 63)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color("color2"))
                        }
                    }
                }.padding(.top, 80)
            }
        }.navigationBarHidden(true)
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = nil
    }
}
