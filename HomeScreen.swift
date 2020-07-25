//
//  HomeScreen.swift
//  Apollo
//
//  Created by Gupta Family on 7/22/20.
//  Copyright © 2020 Armaan Gupta. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack{
            VStack{
                Text("Other Ventyres")
                HStack{
                    Text("Apollo")
                }.frame(width: UIScreen.main.bounds.width / 2)

                
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
