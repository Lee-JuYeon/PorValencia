//
//  CreateVolunteer.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/11/24.
//

import SwiftUI

struct CreateVolunteer: View {
    @Environment(\.colorScheme) private var scheme
    @Binding private var getTitle: String
    @Binding private var getPurpose: String
    @Binding private var getRequirements: String
    @Binding private var getLocation: String
    @Binding private var getContact: [String: String]
    @Binding var isPresented: Bool  // 추가된 Binding 변수
    
    init(
        setTitle: Binding<String>,
        setPurpose: Binding<String>,
        setRequirements: Binding<String>,
        setLocation: Binding<String>,
        setContact: Binding<[String: String]>,
        isPresented: Binding<Bool>  // 추가된 Binding 변수
    ) {
        self._getTitle = setTitle
        self._getPurpose = setPurpose
        self._getRequirements = setRequirements
        self._getLocation = setLocation
        self._getContact = setContact
        self._isPresented = isPresented
    }
    
    private func createTextField(placeholder: String, binding: Binding<String>) -> some View {
        TextField(placeholder, text: binding)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .frame(minWidth: 0, maxWidth: .infinity)
            .font(.system(size: 20))
            .background(Color.yellow)
            .foregroundColor(scheme == .dark ? .white : .black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 10)
    }
    
    private func contactTextField(image: String, hint: String, key: String) -> some View {
        let textBinding = Binding(
            get: { getContact[key] ?? "" },
            set: { getContact[key] = $0 }
        )
        
        return HStack(alignment: .center) {
            Image(image)
                .resizable()
                .frame(width: 24, height: 24)
            
            TextField(hint, text: textBinding)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 20))
                .foregroundColor(scheme == .dark ? .white : .black)
                .padding(.horizontal, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            GradientText(text: "구호단체 팀 결성", gradientColors: [Color.blue, Color.cyan])
            
            createTextField(placeholder: "구호단체 이름", binding: $getTitle)
            createTextField(placeholder: "구호단체 목적", binding: $getPurpose)
            createTextField(placeholder: "구호단체 필요조건", binding: $getRequirements)
            createTextField(placeholder: "구호단체 담당지역", binding: $getLocation)
          
            contactTextField(image: "image_insta", hint: "@insta ID", key: "insta")
            contactTextField(image: "image_x", hint: "@X id", key: "x")
            contactTextField(image: "image_email", hint: "yourEmail@mail.com", key: "email")
            contactTextField(image: "image_phone", hint: "your number", key: "phone")

            HStack {
                Button(action: {
                    // 취소 버튼 클릭 시 fullScreenCover 닫기
                    isPresented = false
                }) {
                    Text("취소")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Button(action: {
                    print("생성하기 버튼 클릭")
                    isPresented = false  // 생성하기 버튼 클릭 시 fullScreenCover 닫기
                }) {
                    Text("생성하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.top, 20)
        }
        .padding()
    }
}
