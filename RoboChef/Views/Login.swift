//
//  Login.swift
//  RoboChef
//
//  Created by Alex Pallozzi on 5/8/23.
//

import SwiftUI
import UIKit


struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful = false
    @State private var showError = false
    @State var isLinkActive = false
    
    func login() {
        let url = URL(string: "http://localhost:8080/auth/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("Failed to serialize parameters: \(error)")
            return
        }

        let semaphore = DispatchSemaphore(value: 0)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                semaphore.signal()
                return
            }

            if response.statusCode == 200 {
                isLoginSuccessful = true
            }
            else {
                print("incorrect credentials")
                print(response.statusCode)
            }

            semaphore.signal()
        }

        task.resume()

        _ = semaphore.wait(timeout: .distantFuture)
    }

    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        ZStack {
                            Ellipse().frame(width: 510, height: 478)
                                .padding(.leading, -200)
                                .foregroundColor(Color("color2"))
                                .padding(.top, -175);
                            
                            Ellipse().frame(width: 458, height: 420)
                                .padding(.trailing, -450)
                                .foregroundColor(Color("color3"))
                                .padding(.top, -225);
                            
                            Text("Welcome \nBack to \n")
                                .foregroundColor(.white)
                                .font(.system(size: 36))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 100)
                                .padding(.leading, 20)
                                .padding(.top, -100)
                            Text("RoboChef")
                                .foregroundColor(.black)
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 100)
                                .padding(.leading, 20)
                                .padding(.top, -15)
                            Text("A One-Stop Shopping Assistant")
                                .foregroundColor(.white)
                                .font(.system(size: 27))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 270)
                                .padding(.top, -150)
                        }

                        VStack(spacing: 30) {
                            VStack(spacing: 20){
                                CustomTextField(placeHolder: "Username", imageName: "envelope", bColor: "textColor1", tOpacity: 0.6, value: $username).padding(.top, 20)
                                CustomTextField(placeHolder: "Password", imageName: "lock", bColor: "textColor1", tOpacity: 0.6, value: $password)
                            }
                            
                            VStack(alignment: .trailing) {
                                Button(action: {
                                    //add forgot password functionality
                                }, label: {
                                    Text("Forgot Password?")
                                        .fontWeight(.bold).padding(.bottom, 20)
                                        .font(.system(size: 18))
                                        .foregroundColor(.black)
                                })
                                NavigationLink(destination: Home(), isActive: $isLoginSuccessful) {
                                    Button(action: {
                                        login()
                                    }, label: {
                                        CustomButton(title: "Sign In", bgColor: "color3");
                                    })
                                }
                            }.padding(.horizontal, 20)
                            HStack(spacing: 20) {
                                Button(action: {}, label: {
                                    Image("fb")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.horizontal, 75)
                                        .padding(.vertical, 15)
                                        .background(Color("color3"))
                                        .cornerRadius(15)
                                })
                                
                                Button(action: {}, label: {
                                    Image("insta")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.horizontal, 75)
                                        .padding(.vertical, 15)
                                        .background(Color("color3"))
                                        .cornerRadius(15)
                                })
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text("Don't Have an Account?")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18));
                                NavigationLink(destination: Signup(), isActive: $isLinkActive) {
                                    Button(action: {
                                        self.isLinkActive = true
                                    }, label: {
                                        Text("SIGN UP")
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
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
//
//extension UINavigationController {
//    open override func viewWillLayoutSubviews() {
//        navigationBar.topItem?.backButtonDisplayMode = .minimal
//    }
//}
