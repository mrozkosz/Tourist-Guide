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
    
    
    var body: some View {
        NavigationView {
            
            ScrollView{
                if #available(iOS 14.0, *) {
                    SearchInput(editing: self.$isEditing, value: self.$searchValue)
                        .onChange(of: searchValue) { newValue in
                            self.pleacesVM.getDataByQuery(q: searchValue)
                        }
                } else {
                    // Fallback on earlier versions
                }
                
                
                if #available(iOS 14.0, *) {
                    LazyVStack{
                        
                        ForEach(self.pleacesVM.pleacesModel, id: \.id){data in
                            NavigationLink(destination: SinglePleace(id: data.id)) {
                                Text(data.name);
                            }.onTapGesture{
                                
                            }
                        }
                        
                    }.navigationBarHidden(true)
                } else {
                    
                    List(){
                        ForEach(self.pleacesVM.pleacesModel, id: \.id){data in
                            NavigationLink(destination: SinglePleace(id: data.id)) {
                                Text(data.name);
                            }
                        }
                        
                    }
                }
            }
        }
    }
}
    
   

    
    
    struct SearchPage_Previews: PreviewProvider {
        @ObservedObject var pleacesVM = PleacesViewModel()
        
        static var previews: some View {
            SearchPage()
        }
    }






