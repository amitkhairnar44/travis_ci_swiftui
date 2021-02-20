//
//  BuildDetails.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import SwiftUI

struct BuildDetails: View {
    
    let build: Build
    let accessToken: String
    
    func parseDate(data: String) -> String {
        print(data)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:data)!
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    var body: some View {
        List{
            Section{
                VStack(alignment: .leading){
                    Text(build.commit?.message ?? "-")
                        .font(.headline)
                        //.lineLimit(1)
                        .padding(.vertical, 4)
                    
                    HStack{
                        Image(systemName: stateIcon(for: build.state)).font(.system(size: 16, weight: .bold))
                        Text(build.state).bold()
                    }.foregroundColor(stateColor(for: build.state)).padding(.vertical, 4)
                    
                    HStack{
                        Image(systemName: "info.circle")
                        Text("Commit \(String(build.commit!.sha[..<build.commit!.sha.index(build.commit!.sha.startIndex, offsetBy: 7)]))").font(.subheadline)
                    }.padding(.vertical, 2)
                    
                    //                    Text("Commit \(String(build.commit!.sha[..<build.commit!.sha.index(build.commit!.sha.startIndex, offsetBy: 7)]))")
                    //                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Image(systemName: "clock")
                        if(build.duration != nil){
                            Text("Ran for \(build.duration! / 60) min \(build.duration! % 60) sec").font(.subheadline)
                        } else{
                            Text("-")
                        }
                        
                    }.padding(.vertical, 2)
                    
                    //                        HStack{
                    //                            Image(systemName: "folder")
                    //                            Link("Compare", destination: URL(string: fetcher.builds[0].commit!.compareUrl)!)
                    //                            Button{
                    //                                print("Compare")
                    //                            } label:{
                    //                                Text("Compare \(fetcher.builds[0].commit!.compareUrl)").font(.subheadline)
                    //                            }
                    //                        }.padding(.vertical, 2)
                    
                    HStack{
                        Image(systemName: build.tag != nil ? "tag": "folder")
                        build.tag != nil ? Text("Tag \(build.tag!.name)").font(.subheadline):
                            Text("Branch \(build.branch!.name)").font(.subheadline)
                    }.padding(.vertical, 2)
                    HStack{
                        Image(systemName: "calendar")
                        Text(build.startedAt != nil ? parseDate(data: build.startedAt!) : "-").font(.subheadline)
                    }.padding(.vertical, 2)
                    
                    UserTileView(id: "\(build.createdBy.id)", accessToken: accessToken)
                }
            }
            
            Section() {
                Button{
                    
                } label: {
                    Text("Restart Build")
                }
            }
            
            Section() {
                NavigationLink(destination: BuildLogView(id: "\(build.jobs!.first!.id)", accessToken: accessToken)) {
                    Text("Build Logs")
                }
            }
            
        }.listStyle(InsetGroupedListStyle())
        .navigationTitle("Build #\(build.number)")
    }
}

struct BuildDetails_Previews: PreviewProvider {
    static var previews: some View {
        BuildDetails(build: Build(id: 2, duration: 233, number: "23", state: "passed", previousState: nil, updatedAt: "", startedAt: "", commit: nil, jobs: nil, tag: nil, branch: nil, createdBy: CreatedBy(id: 2, login: "")), accessToken: "")
    }
}
