//
//  GlobalVariable.swift
//  
//
//  Created by Gupta Family on 7/24/20.
//

import SwiftUI

struct GlobalVariable: View {
    @EnvironmentObject var globals: GlobalVariables
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GlobalVariable_Previews: PreviewProvider {
    static var previews: some View {
        GlobalVariable()
    }
}
class GlobalVariable: ObservedObject{
    @Published var name = ""
}
