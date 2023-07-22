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
//                            Text("A One-Stop Shopping Assistant")
//                                .foregroundColor(.white)
//                                .font(.system(size: 24))
//                                .fontWeight(.bold)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding(.leading, 270)
//                                .padding(.top, -150)
                        }

                        VStack(spacing: 30) {
                            VStack(spacing: 30){
                                CustomTextField(placeHolder: "Name", imageName: "person", bColor: "color7", tOpacity: 0.6, value: $password)
                                CustomTextField(placeHolder: "Username", imageName: "envelope", bColor: "color7", tOpacity: 0.6, value: $username)
                                CustomTextField(placeHolder: "Password", imageName: "lock", bColor: "color7", tOpacity: 0.6, value: $password)
                                CustomTextField(placeHolder: "Confirm Password", imageName: "lock", bColor: "color7", tOpacity: 0.6, value: $password).padding(.bottom, 20)
                            }
                            
                            VStack(alignment: .trailing) {
                                
                                Button(action: {}, label: {
                                    CustomButton(title: "Sign Up", bgColor: "color3");
                                })
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
                            
                            
                            HStack {
                                Text("Already Have an Account?")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18));
                                
                                Button(action: {}, label: {
                                    Text("SIGN UP")
                                        .font(.system(size: 18))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                })
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
