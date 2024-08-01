//
//  ContentView.swift
//  happy ending app
//
//  Created by Edoardo Martino on 23/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var onclick: Bool = false
    @State private var text: String = ""
    @State private var annotazioni: [String] = []
//    //Con questo metodo imposto il colore bianco per il titolo grande e il titolo dello sheet
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
//        }
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color(.gray)
                    .ignoresSafeArea()
                    .opacity(0.1)
                
                VStack{
                    List{
                        ForEach(annotazioni, id:\.self){ annotation in
                            Text(annotation)
                                .padding()
                        }
                        .onDelete(perform: cancella)
                        
                    }
                    Spacer()
                        
                    Button(action: {
                        onclick = true
                    }){
                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.indigo)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .padding(.bottom, 10)
                    
                    
                    .sheet(isPresented: $onclick){
                            NavigationView{
                                
                                    VStack{
                                        TextEditor(text: $text)
                                            .padding()
                                            .background(Color.clear)
                                            .navigationBarItems(leading: Button("Cancel"){
                                                onclick = false
                                        }, trailing: Button(action: {
                                            text = ""
                                        }){
                                            Label("Cancella", systemImage: "trash")
                                        })
                                            .foregroundColor(.indigo)
                                    }
                                        .toolbar{
                                            ToolbarItem(placement: .bottomBar){
                                                HStack{
                                                    Button(action: {}) {
                                                    Image(systemName: "sparkles")
                                                    }
                                                    .foregroundColor(.indigo)
                                                    Spacer()
                                                    Button(action: {}) {
                                                        Image(systemName: "photo")
                                                    }
                                                    .foregroundColor(.indigo)
                                                    Spacer()
                                                    Button(action: {}) {
                                                        Image(systemName: "camera")
                                                    }
                                                    .foregroundColor(.indigo)
                                                    Spacer()
                                                    Button(action: {}) {
                                                        Image(systemName: "waveform")
                                                    }
                                                    .foregroundColor(.indigo)
                                                    Spacer()
                                                    Button(action: {
                                                        if !text.isEmpty{
                                                            annotazioni.append(text)
                                                            text = ""
                                                        }
                                                        onclick = false
                                                    }) {
                                                        Image(systemName: "paperplane")
                                                    }
                                                    .foregroundColor(.indigo)
                                                }
                                            }
                                    }
                            
                            .navigationBarTitle(Text(getCurrentData()))
                            .navigationBarTitleDisplayMode(.inline)
                            
                        }
                        
                    }
                }
            }
            .navigationTitle("Diary")
            
        }
    }
    
    private func cancella(at offsets: IndexSet) {
        annotazioni.remove(atOffsets: offsets)
      }
}

func getCurrentData() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_EN") //identifica la datA PAESE
    dateFormatter.dateFormat = "EEEE dd MMM"
    return dateFormatter.string(from: Date())
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
