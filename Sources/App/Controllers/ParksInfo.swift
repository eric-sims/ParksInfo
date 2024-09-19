//
//  File.swift
//  ParksInfo
//
//  Created by Eric Sims on 9/18/24.
//

import Foundation
import Vapor

struct ParksInfoController: RouteCollection {
    let queueTimes: QueueTimesApi
    
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let c = routes.grouped("parks")
        c.get("disney-queue-times", use: getDisneyQueueTimes)
    }
    
    @Sendable
    func getDisneyQueueTimes(_ req: Request) throws -> EventLoopFuture<RideQueues> {
        return queueTimes.fetchDisneyData()
    }
}
