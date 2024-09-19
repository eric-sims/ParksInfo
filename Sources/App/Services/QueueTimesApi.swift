//
//  QueueTimesImpl.swift
//  ParksInfo
//
//  Created by Eric Sims on 9/18/24.
//
import Vapor

struct QueueTimesApi {
    let client: Client
    let baseURL: String = "https://queue-times.com"
    
    func fetchDisneyData() -> EventLoopFuture<RideQueues> {
        let url = "\(baseURL)/parks/16/queue_times.json"
        
        return client.get(URI(string: url)).flatMapThrowing { response in
            guard response.status == .ok else {
                throw Abort(.badRequest, reason: "Failed to fetch data")
            }
            
            // Decode the response content into QueueTimesAPIResponse
            let apiResponse = try response.content.decode(QueueTimesAPIResponse.self)
            
            // Initialize an empty array to hold all RideQueue objects
            var rideQueues = RideQueues(queueTimes: [])
            
            // Loop through all lands and their rides to populate RideQueues
            for land in apiResponse.lands {
                for ride in land.rides {
                    // Transform each Ride into RideQueue and append it to rideQueues
                    rideQueues.queueTimes.append(RideQueue(from: ride))
                }
            }
            
            return rideQueues
        }
    }
}
