//
//  ContentView.swift
//  Notifications
//
//  Created by Admin on 8/1/20.
//  Copyright © 2020 Yerlan. All rights reserved.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State var show = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: Detail(show: $show), isActive: self.$show) {
                    Text("")
                }
                Button(action: {
                    send()
                }) {
                    Text("Send Notification")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.all, 15)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }.navigationBarTitle("Home")
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { (_) in
                    self.show = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func send() {
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, _) in
        
    }
    
    let content = UNMutableNotificationContent()
    content.title = "Message"
    content.body = "Do you want to work in Microsoft?"
    
    let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
    let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
    
    let categories = UNNotificationCategory(identifier: "action", actions: [open, cancel], intentIdentifiers: [])
    UNUserNotificationCenter.current().setNotificationCategories([categories])
    
    content.categoryIdentifier = "action"
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    let request = UNNotificationRequest(identifier: "request", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

struct Detail: View {
    
    @Binding var show: Bool
    
    var body: some View {
        Bill_Gates()
            .navigationBarTitle("Detail View")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.show = false
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.title)
                }))
    }
}

struct Bill_Gates: View {
    var body: some View {
        ZStack {
            Image("microsoft")
                .resizable()
            VStack {
                Image("billgates")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(10)
                
                Text("Hi! Welcome to my profile")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                
                Divider()
                
                HStack {
                    Image("billgates")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                    
                    VStack(alignment: .leading) {
                        Text("I'm former CEO of Microsoft Inc")
                            .foregroundColor(.white)
                        Text("Now I'm a founder Bill & Melissa Gates foundation")
                            .foregroundColor(.white)
                    }.padding()
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


