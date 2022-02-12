//
//  ContentView.swift
//  PexelsSwiftExample
//
//  Created by Alex Nagy on 12.02.2022.
//

import SwiftUI
import pexels_swift

struct ContentView: View {
    
    @AppStorage("\(PexelsRateLimit.X_Ratelimit_Limit.rawValue)") var xRatelimitLimit = ""
    @AppStorage("\(PexelsRateLimit.X_Ratelimit_Remaining.rawValue)") var xRatelimitRemaining = ""
    @AppStorage("\(PexelsRateLimit.X_Ratelimit_Reset.rawValue)") var xRatelimitReset = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("xRatelimitLimit: \(xRatelimitLimit)")
                Divider()
                Text("xRatelimitRemaining: \(xRatelimitRemaining)")
                Divider()
                Text("xRatelimitReset: \(Date(timeIntervalSince1970: Double(xRatelimitReset) ?? 0.0))")
                Divider()
            }
            .font(.caption)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            
            Button {
                fetch(.photo)
            } label: {
                Text("Fetch")
            }
            .buttonStyle(.borderedProminent)

        }
        .padding()
    }
    
    func fetch(_ type: PexelsFetchType) {
        Task {
            do {
                switch type {
                case .photo:
                    let photo = try await Pexels<Photo>.get(.photo(id: 2014422))
                    print(photo)
                case .searchedPhotos:
                    let photos = try await Pexels<Photos>.get(.searchedPhotos(query: "nature", orientation: nil, size: nil, color: nil, locale: nil, page: nil, perPage: nil))
                    print(photos)
                case .curatedPhotos:
                    let photos = try await Pexels<Photos>.get(.curatedPhotos(page: nil, perPage: nil))
                    print(photos)
                case .video:
                    let video = try await Pexels<Video>.get(.video(id: 2499611))
                    print(video)
                case .popularVideos:
                    let videos = try await Pexels<Videos>.get(.popularVideos(minWidth: nil, minHeight: nil, minDuration: nil, maxDuration: nil, page: nil, perPage: nil))
                    print(videos)
                case .featuredCollections:
                    let collections = try await Pexels<Collections>.get(.featuredCollections(page: nil, perPage: nil))
                    print(collections)
                case .myCollections:
                    let collections = try await Pexels<Collections>.get(.myCollections(page: nil, perPage: nil))
                    print(collections)
                case .mediaCollection:
                    let collections = try await Pexels<Collections>.get(.featuredCollections(page: nil, perPage: nil))
                    let id = collections.collections.first?.id ?? ""
                    let collection = try await Pexels<MediaCollection>.get(.mediaCollection(id: id, type: nil, page: nil, perPage: nil))
                    print(collection)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
}

enum PexelsFetchType {
    case photo
    case searchedPhotos
    case curatedPhotos
    case video
    case popularVideos
    case featuredCollections
    case myCollections
    case mediaCollection
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
