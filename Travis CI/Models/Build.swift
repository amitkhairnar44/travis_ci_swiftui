//
//  Build.swift
//  Travis CI
//
//  Created by Amit Khairnar on 20/02/21.
//  Copyright © 2021 Amit Khairnar. All rights reserved.
//

import Foundation

struct CreatedBy: Decodable {
    public var id: Int
    public var login: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
    }
}

struct Pagination: Decodable {
    public var limit: Int
    public var offset: Int
    public var count: Int
    public var isLast: Bool
    public var next: Next?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case limit = "limit"
        case offset = "offset"
        case isLast = "is_last"
        case next = "next"
    }
}

struct Next: Decodable {
    public var offset: Int
    
    enum CodingKeys: String, CodingKey {
        case offset = "offset"
    }
}

struct Builds: Decodable {
    public var builds: [Build]
    public var pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case builds = "builds"
        case pagination = "@pagination"
    }
}

struct Commit: Decodable, Identifiable {
    //final int id;
    //final String sha;
    //final String ref;
    //final String message;
    //final String compareUrl;
    //final String committedAt;
    public var id: Int
    public var sha: String
    public var ref: String?
    public var message: String
    public var compareUrl: String
    public var comittedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sha = "sha"
        case ref = "ref"
        case message = "message"
        case compareUrl = "compare_url"
        case comittedAt = "committed_at"
    }
}

//struct Jobs: Decodable {
//    public var jobs: [Job]
//
//    enum CodingKeys: String, CodingKey {
//        case jobs = "jobs"
//    }
//}

struct Job: Decodable, Identifiable{
    public var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}

struct Build: Decodable, Identifiable {
    //final int id;
    //final String number;
    //final BuildState state;
    //final int duration;
    //final String previousState;
    //final String updatedAt;
    //final String createdAt;
    //final CreatedBy createdBy;
    //final Commit commit;
    //final Repository repository;
    //final Branch branch;
    //final Tag tag;
    //final List<Job> jobs;
    public var id: Int
    public var duration: Int?
    public var number: String
    public var state: String
    public var previousState: String?
    public var updatedAt: String
    public var startedAt: String?
    public var commit: Commit?
    public var jobs: [Job]?
    public var tag: Tag?
    public var branch: Branch?
    public var createdBy: CreatedBy
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case duration = "duration"
        case number = "number"
        case state = "state"
        case previousState = "previous_state"
        case startedAt = "started_at"
        case updatedAt = "updated_at"
        case commit = "commit"
        case jobs = "jobs"
        case tag = "tag"
        case branch = "branch"
        case createdBy = "created_by"
    }
}
