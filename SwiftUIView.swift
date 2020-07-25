import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

struct SwiftUIView: View {
    @State var selected = "Ventures"
    var body: some View {
        VStack(){
            if self.selected == "Ventures"{
                Ventures()
            }else if self.selected == "Liked Ventures"{
                GeometryReader{_ in
                    
                    Text("Liked Ventures")
                }
                
            }
            else{
                GeometryReader{_ in
                
                Text("Chat")
            }
            
            
        }
            CustomTabView(selected: $selected)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
struct CustomTabView: View{
    @Binding var selected: String
    var body: some View{
        HStack{
            ForEach(tabs,id: \.self){i in
                VStack(spacing: 10){
                    Capsule().fill(Color.clear)
                    .overlay(
                        Capsule().fill(self.selected == i ? Color("Color-1") : Color.clear).frame(width: 55, height: 5)
                    )
                        .frame(height: 5)
                    Button(action: {
                        self.selected = i
                        
                    }) {
                VStack{
                    Image(i).renderingMode(.original)
 
                    Text(i).foregroundColor(.black)
                }
                }
                
            }
        }
        }.padding(.horizontal)
}
}
struct Ventures : View{
    var body : some View{
        VStack{
            HStack(spacing: 12){
            Text("Ventures")
            Image("logo").renderingMode(.original)
            }
        }
    }
}
}
var tabs = ["Ventures", "Liked Ventures", "Chat" ]
