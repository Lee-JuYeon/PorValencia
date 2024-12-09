//
//  VolunteerView.swift
//  PorValencia
//
//  Created by C.A.V.S.S on 11/9/24.
//

import SwiftUI
import MapKit

struct VolunteerView: View {
    let searchHint = "봉사단체 이름을 검색하세요"
    @State private var getSearch: String = ""
    @Environment(\.colorScheme) private var scheme

    @State private var viewType = ViewType.List
    @State private var isShowCreatingVolunteerRoom = false
    
    // 추가된 상태 변수
    @State private var createVolunteerTitle = ""
    @State private var createVolunteerPurpose = ""
    @State private var createVolunteerRequirement = ""
    @State private var createVolunteerLocation = ""
    @State private var createVolunteerContact = [
        "insta": "",
        "x": "",
        "phone": "",
        "email": ""
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                TextField(searchHint, text: $getSearch)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 20))
                    .background(Color.yellow)
                    .foregroundColor(scheme == .dark ? .white : .black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))

                Text(" + ")
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.system(size: 20, weight: .bold))
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        isShowCreatingVolunteerRoom.toggle()
                    }
                    .fullScreenCover(
                        isPresented: $isShowCreatingVolunteerRoom,
                        onDismiss: {
                            isShowCreatingVolunteerRoom = false
                        },
                        content: {
                            CreateVolunteer(
                                setTitle: $createVolunteerTitle,
                                setPurpose: $createVolunteerPurpose,
                                setRequirements: $createVolunteerRequirement,
                                setLocation: $createVolunteerLocation,
                                setContact: $createVolunteerContact,
                                isPresented: $isShowCreatingVolunteerRoom  // Binding 전달
                            )
                        }
                    )
            }
           
            ZStack(alignment:.bottomTrailing) {
                if viewType == .List {
                    listView()
                } else {
                    mapView()
                }
                
                Image(uiImage: UIImage(named: viewType == .List ? "image_map" : "image_list")!)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(5)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
                    .onTapGesture {
                        viewType = viewType == .List ? .Map : .List
                    }
            }
        }
    }
    
    private func listView() -> some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                ForEach(DummyPack.shared.volunteerList, id: \.self) { volunteerModel in
                    VolunteerCell(setModel: volunteerModel)
                }
            }
        }
    }
    
    private func mapView() -> some View {
        Text("map view")
    }
}

