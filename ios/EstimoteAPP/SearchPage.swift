//
//  SearchPage.swift
//  EstimoteAPP
//
//  Created by Mateusz on 17/11/2020.
//  Copyright © 2020 Mateusz. All rights reserved.
//

import SwiftUI

struct SearchPage: View {
    @State var searchValue:String = ""
    @State var isEditing:Bool = false
    @ObservedObject var pleacesVM = PleacesViewModel()
    @ObservedObject var beaconsVM = BeaconsViewModel.shared
    
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                ScrollView{
                    
                    HStack {
                        Text("Search Results")
                            .frame(alignment: .leading)
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding()
                    
                    ForEach(self.pleacesVM.pleacesModel, id: \.id){data in
                        NavigationLink(destination: SinglePleace(id: data.id)) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(data.location)
                                        .font(.title)
                                    Spacer()
                                }.padding([.leading,.top],16)
                                HStack {
                                    Text(data.name)
                                        .font(.subheadline)
                                    Spacer()
                                }.padding(.leading,16)
                            }
                        }
                    }
                    
                    Group{
                        HStack {
                            if(self.beaconsVM.beaconsModel.count>0){
                            Text("Found \(self.beaconsVM.beaconsModel.count) places you must visit").foregroundColor(.gray)
                            }
                            Spacer()
                        }.padding()
                        
                        ForEach(0..<self.beaconsVM.beaconsModel.count, id:\.self){ index in
                            HStack{
                                
                                ForEach(self.beaconsVM.beaconsModel[index], id:\.id){ data in
                                    
                                    NavigationLink(destination: SinglePleace(id: data.id)) {
                                        VStack{
                                            UrlImageView(urlString: data.coverImage)
                                                .cornerRadius(20)
                                                .aspectRatio(contentMode: .fill)
                                                .scaledToFit()
                                            HStack {
                                                Text(data.location)
                                                    .font(.title)
                                                Spacer()
                                            }.padding(.leading,16)
                                            
                                            HStack {
                                                Text(data.name)
                                                    .font(.subheadline)
                                                Spacer()
                                            }.padding(.leading,16)
                                        }.padding(5)
                                    }
                                }
                                
                            }
                            
                        }.padding(.horizontal, 10)
                    }
                    
                }.offset(y:100)
                
                if #available(iOS 14.0, *) {
                    SearchInput(editing: self.$isEditing, value: self.$searchValue)
                        .onChange(of: searchValue) { newValue in
                            self.pleacesVM.getDataByQuery(q: searchValue)
                        }
                } else {
                    // Fallback on earlier versions
                }
                
                ConnectionStatus()
                
            }.navigationBarHidden(true)
            
        }
    }
    
}









struct SearchPage_Previews: PreviewProvider {
    @ObservedObject var pleacesVM = PleacesViewModel()
    
    static var previews: some View {
        SearchPage()
    }
}






