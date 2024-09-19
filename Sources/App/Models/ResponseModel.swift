//
//  ResponseModel.swift
//  ParksInfo
//
//  Created by Eric Sims on 9/18/24.
//
import Vapor

// Model representing the expected structure of the API response
struct QueueTimesAPIResponse: Content {
    let lands: [Land]
}

struct Land: Content {
    let name: String
    let rides: [Ride]
}

struct Ride: Content {
    let name: String
    let is_open: Bool
    let wait_time: Int
}

// Model for the transformed data
struct RideQueues:Content {
    var queueTimes: [RideQueue]
}

struct RideQueue: Content {
    let name: String
    let wait_time: Int
    let is_open: Bool
    
    init(from ride: Ride) {
        self.name = ride.name
        self.is_open = ride.is_open
        self.wait_time = ride.wait_time
    }
}


