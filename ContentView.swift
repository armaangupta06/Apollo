import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import Foundation


 
struct ContentView: View {
    @EnvironmentObject var settings: GlobalVariables
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
   
       
            VStack{
                if status{
                   Home2()
                }
                else{
                    Home()
                }
            }.animation(.spring())
                .onAppear(){
                    
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main){ (_) in
                        let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                        self.status = status
                    }
            }
            //LinearGradient(gradient: .init(colors:  [Color("Color"),Color("Color1")]),  startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
           
           // Home()
        }
    }
 
 
struct ContentView_Previews:  PreviewProvider {
    static var previews: some View {
        ContentView().enviromentalObject(settings)
    }
}
 
struct Home: View {
    @State var index = 0
    @State var show = false
   
    var body : some View{
        ZStack{
        VStack{
       
            Image("logo")
            .resizable()
            .scaledToFit()
           
            HStack{
                Button(action: {
                   
                    self.index = 0
                }){
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, UIScreen.main.bounds.height * 10/896)
                        .frame(width: ((UIScreen.main.bounds.width / 2 ) - 50))
                        .font(Font.system(size: setCustomFont()))
                   
                }.background(self.index == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
               
                Button(action: {
                                   
                    self.index = 1
                }){
                    Text("New")
                    .foregroundColor(self.index == 1 ? .black : .white)
                    .fontWeight(.bold)
                    .padding(.vertical, UIScreen.main.bounds.height * 10/896)
                    .frame(width: ((UIScreen.main.bounds.width / 2) - 50))
                    .font(Font.system(size: setCustomFont()))
                                   
                }.background(self.index == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
            }.background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, UIScreen.main.bounds.height * 25/896)
           
            if self.index == 0{
                Login()
               
            }else{
                SignUp(show: self.$show)
            }
           
            Button(action: {
               
            }) {
                Text("Forgot Password?")
                    .foregroundColor(.black)
                    .padding(.top, UIScreen.main.bounds.height * 100/896)
                    .font(Font.system(size: setCustomFont()))
                   
               
            }
            HStack(spacing: UIScreen.main.bounds.width * 15/414){
                Color.black.opacity(0.7)
                .frame(width: UIScreen.main.bounds.width * 20/414, height: UIScreen.main.bounds.height * 1/896)
               
                Text("Or")
                    .foregroundColor(.black)
                    .font(Font.system(size: setCustomFont()))
 
               
                Color.black.opacity(0.7)
                .frame(width: UIScreen.main.bounds.width * 20/414, height: UIScreen.main.bounds.height * 1/896)
            }
            HStack{
                GoogleSignView()
 
            }
            .padding(.top, UIScreen.main.bounds.height * 10/896)
           
    }
    .padding()
        }.background(LinearGradient(gradient: .init(colors:  [Color("Color"),Color("Color1")]),  startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
 
}
}
 
struct Login : View{
@State var mail = ""
@State var pass = ""
@State var msg = ""
@State var alert = false
@State var hidden = false
    var body : some View{
        VStack{
            VStack{
                HStack(spacing: UIScreen.main.bounds.width * 15/414){
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    TextField("Enter Email Address", text: self.$mail)
                                           .font(Font.system(size: setCustomFont()))
               
                }.padding(.vertical, UIScreen.main.bounds.height * 20/896)
       
                Divider()
                ZStack{
                    HStack{
                    if self.hidden {
                    HStack(spacing: UIScreen.main.bounds.width * 15/414){
                    Image(systemName: "lock")
 
                        .foregroundColor(.black)
               
                    SecureField("Password", text: self.$pass)
                        .font(Font.system(size: setCustomFont()))
                        }
                    }else{
                        HStack(spacing: UIScreen.main.bounds.width * 15/414){
                        Image(systemName: "lock")
 
                        .foregroundColor(.black)
                       
                        TextField("Password", text: self.$pass)
                            .font(Font.system(size: setCustomFont()))
                        }
                        }
                        Button(action: {
                        self.hidden.toggle()
                    }) {
                        Image(systemName: self.hidden ? "eye.fill": "eye.slash.fill")
                            .foregroundColor((self.hidden == true ) ? Color.green : Color.secondary)
                    }
                }.padding(.vertical, UIScreen.main.bounds.height * 20/896)
                   
                }
            }
            .padding(.vertical)
            .padding(.horizontal, UIScreen.main.bounds.width * 20/414)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, UIScreen.main.bounds.height * 25/896)
           
            Button(action: {
                signInWithEmail(email: self.mail, password: self.pass) {(verified, status) in
               
                if !verified{
                    self.msg = status
                    self.alert.toggle()
                }else{
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                }
            }) {
                Text("LOGIN")
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .font(Font.system(size: setCustomFont()))
                }
            .background(
               
                Color.white
            )
           
            .cornerRadius(20)
            .padding(.bottom, UIScreen.main.bounds.height * (-1*(40/896)))
                .padding(.top, UIScreen.main.bounds.height * 20/896)
                .shadow(radius:25)
               
           
} .alert(isPresented: $alert) {
           Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Dk")))
       }
}
}
 
struct SignUp : View{
@State var mail = ""
@State var name = ""
@State var pass = ""
@State var alert = false
@State var msg = ""
@State var hidden = false
@Binding var show : Bool
   
    var body : some View{
        VStack{
            VStack{
                HStack(spacing: UIScreen.main.bounds.width * 15/414){
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    TextField("Enter Email Address", text: self.$mail)
                                           .font(Font.system(size: setCustomFont()))
               
                }.padding(.vertical, UIScreen.main.bounds.height * 20/896)
       
                Divider()
               
                HStack(spacing: UIScreen.main.bounds.width * 15/414){
                    Image(systemName: "lock")
                        .foregroundColor(.black)
                    TextField("Name", text: self.$name)
                                           .font(Font.system(size: setCustomFont()))
                               
                }.padding(.vertical, UIScreen.main.bounds.height * 20/896)
                       
                Divider()
               
                ZStack{
                    HStack{
                    if self.hidden {
                    HStack(spacing: 15){
                    Image(systemName: "lock")
 
                        .foregroundColor(.black)
               
                        SecureField("Enter Password", text: self.$pass)
                            .font(Font.system(size: setCustomFont()))
 
                        }
                    }else{
                        HStack(spacing: UIScreen.main.bounds.width * 15/414){
                        Image(systemName: "lock")
 
                        .foregroundColor(.black)
                       
                        TextField("Enter Password", text: self.$pass)
                            .font(Font.system(size: setCustomFont()))
                        }
                        }
                        Button(action: {
                        self.hidden.toggle()
                    }) {
                        Image(systemName: self.hidden ? "eye.fill": "eye.slash.fill")
                            .foregroundColor((self.hidden == true ) ? Color.green : Color.secondary)
                    }
                }.padding(.vertical, UIScreen.main.bounds.height * 20/896)
                   
                }
                }.padding(.vertical, UIScreen.main.bounds.height * 20/896)
           
            .padding(.horizontal, UIScreen.main.bounds.width * 20/414)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, UIScreen.main.bounds.height * 25/896)
           
            Button(action: {
                signUpWithEmail(email: self.mail, password: self.pass, name: self.name){
                    (verified, status) in
                    if !verified{
                        self.msg = status
                        self.alert.toggle()
                    }else{
                        presentWelcomeMessage()
                        UserDefaults.standard.set(true, forKey: "status")
                        self.show.toggle()
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        
                    }
                }
            }) {
                Text("SIGNUP")
                    .font(Font.system(size: setCustomFont()))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }
            .background(
               
                Color.white
            )
            .cornerRadius(20)
            .padding(.bottom, UIScreen.main.bounds.height * (-1*(40/896)))
                .padding(.top, UIScreen.main.bounds.height * 20/896)
                .shadow(radius:25)
 
           
    }.alert (isPresented: $alert){
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("")))
        }
       
}
}
 
struct GoogleSignView : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<GoogleSignView>) -> GIDSignInButton{
        let button = GIDSignInButton()
        button.colorScheme = .dark
 
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<GoogleSignView>) {
    }
     
}
 
func signInWithEmail(email: String, password: String, completion: @escaping (Bool, String)->Void){
    Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
        if err != nil{
            completion(false,(err?.localizedDescription)!)
            return
        }
        completion(true, (res?.user.email)!)
       
}
}
func presentWelcomeMessage(){
    let db = Firestore.firestore()
    if let userId = Auth.auth().currentUser?.uid {
        let collectionRef = db.collection("users")
        let thisUserDoc = collectionRef.document(userId)
        thisUserDoc.getDocument(completion: { document, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            if let doc = document {
                let welcomeName = doc.get("Name") ?? "No Name"
                global.name = welcomeName as! String
                print("Hey, \(global.name) welcome!")
                    
                
            }
        })
    }
}

func signUpWithEmail(email: String, password: String, name: String, completion: @escaping (Bool, String)->Void){
    Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
       
        if err != nil{
            completion(false,(err?.localizedDescription)!)
            return
        }
        else{
            let db = Firestore.firestore()
            db.collection("users").document(res!.user.uid).setData(["Name": name]){ (err) in
            
                if err != nil{
                    completion(false,(err?.localizedDescription)!)
                    return
                }else{
                    completion(true, (res?.user.email)!)

            }
            
 
       
}
}
}
}
struct Home2 : View {
    var body : some View{
        ZStack{
            Color.blue
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                Text(global.name)
                    
                .font(.largeTitle)
                .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .offset(y: -40)
 
           
                Button(action: {
               
                try! Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }) {
                HStack{
                    Image(systemName: "arrow.down.left.circle.fill")
                    Text("Logout")
                                            .font(Font.system(size: setCustomFont()))
                }
           
                }.buttonStyle(GradientButtonStyle())
                    .padding(.top, UIScreen.main.bounds.height * 500/896)
            }
    }
}
}
struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.blue)
            .padding()
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width - 100 )
            .background(Color.white)
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}
struct scaleButton: ButtonStyle {
func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}
func setCustomFont() -> CGFloat {
 
    //Current runable device/simulator width find
    let bounds = UIScreen.main.bounds
    let width = bounds.size.width
 
    // basewidth you have set like your base storybord is IPhoneSE this storybord width 320px.
    let baseWidth: CGFloat = 414
 
    // "14" font size is defult font size
    let fontSize = 14 * (width / baseWidth)
 
    return fontSize
}

