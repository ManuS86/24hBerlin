//
//  Event.swift
//  24hBerlin
//
//  Created by Emanuel Sutor on 19.12.24.
//

import Foundation

struct Event: Codable, Identifiable, Hashable {
    var id: String
    let content: String
    let name: String
    let permalink: String
    var start: Date
    var end: Date?
    let details: String
    let repeats: [[Int]]?
    let subtitle: String?
    let learnmoreLink: String?
    let featured: String?
    let imageURL: String?
    let locationName: String?
    let address: String?
    let lat: Double?
    let lon: Double?
    let locationLink: String?
    let locationImage: [String: String]?
    let locationDesc: String?
    let entranceFee: EntranceFee?
    let eventType: [String: String]?
    let sounds: [String: String]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = ""
        self.content = try container.decode(String.self, forKey: .content)
        self.name = try container.decode(String.self, forKey: .name)
        self.permalink = try container.decode(String.self, forKey: .permalink)
        
        let startInt = try container.decode(Int.self, forKey: .start)
        self.start = Date(timeIntervalSince1970: TimeInterval(startInt))
        
        if let endInt = try container.decodeIfPresent(Int.self, forKey: .end) {
            self.end = Date(timeIntervalSince1970: TimeInterval(endInt))
        } else {
            self.end = nil
        }
        
        self.details = try container.decode(String.self, forKey: .details)
        self.repeats = try container.decodeIfPresent([[Int]].self, forKey: .repeats)
        self.subtitle = try container.decodeIfPresent(String.self, forKey: .event_subtitle)
        self.learnmoreLink = try container.decodeIfPresent(String.self, forKey: .learnmore_link)
        self.featured = try container.decodeIfPresent(String.self, forKey: .featured)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .image_url)
        self.locationName = try container.decodeIfPresent(String.self, forKey: .location_name)
        self.address = try container.decodeIfPresent(String.self, forKey: .location_address)
        self.locationDesc = try container.decodeIfPresent(String.self, forKey: .location_desc)
        self.locationLink = try container.decodeIfPresent(String.self, forKey: .location_link)
        self.locationImage = try container.decodeIfPresent([String: String].self, forKey: .location_image)
        self.entranceFee = try container.decodeIfPresent(EntranceFee.self, forKey: .customfield_1)
        self.eventType = try container.decodeIfPresent([String: String].self, forKey: .event_type)
        self.sounds = try container.decodeIfPresent([String: String].self, forKey: .event_type_2)
        
        if let latString = try? container.decodeIfPresent(String.self, forKey: .location_lat) {
            self.lat = Double(latString)
        } else if let latDouble = try? container.decodeIfPresent(Double.self, forKey: .location_lat) {
            self.lat = latDouble
        } else {
            self.lat = nil
        }
        
        if let lonString = try? container.decodeIfPresent(String.self, forKey: .location_lon) {
            self.lon = Double(lonString)
        } else if let lonDouble = try? container.decodeIfPresent(Double.self, forKey: .location_lon) {
            self.lon = lonDouble
        } else {
            self.lon = nil
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
        hasher.combine(name)
        hasher.combine(permalink)
        hasher.combine(start)
        hasher.combine(end)
        hasher.combine(details)
        hasher.combine(repeats)
        hasher.combine(subtitle)
        hasher.combine(learnmoreLink)
        hasher.combine(featured)
        hasher.combine(imageURL)
        hasher.combine(locationName)
        hasher.combine(address)
        hasher.combine(lat)
        hasher.combine(lon)
        hasher.combine(locationLink)
        hasher.combine(locationImage)
        hasher.combine(locationDesc)
        hasher.combine(eventType)
        hasher.combine(sounds)
    }
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.content == rhs.content &&
        lhs.name == rhs.name &&
        lhs.permalink == rhs.permalink &&
        lhs.start == rhs.start &&
        lhs.end == rhs.end &&
        lhs.details == rhs.details &&
        lhs.repeats == rhs.repeats &&
        lhs.subtitle == rhs.subtitle &&
        lhs.learnmoreLink == rhs.learnmoreLink &&
        lhs.featured == rhs.featured &&
        lhs.imageURL == rhs.imageURL &&
        lhs.locationName == rhs.locationName &&
        lhs.address == rhs.address &&
        lhs.lat == rhs.lat &&
        lhs.lon == rhs.lon &&
        lhs.locationLink == rhs.locationLink &&
        lhs.locationImage == rhs.locationImage &&
        lhs.locationDesc == rhs.locationDesc &&
        lhs.eventType == rhs.eventType &&
        lhs.sounds == rhs.sounds
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(name, forKey: .name)
        try container.encode(permalink, forKey: .permalink)
        try container.encode(start.timeIntervalSince1970, forKey: .start)
        try container.encodeIfPresent(end?.timeIntervalSince1970, forKey: .end)
        try container.encode(details, forKey: .details)
        try container.encodeIfPresent(repeats, forKey: .repeats)
        try container.encodeIfPresent(subtitle, forKey: .event_subtitle)
        try container.encodeIfPresent(learnmoreLink, forKey: .learnmore_link)
        try container.encode(featured, forKey: .featured)
        try container.encodeIfPresent(imageURL, forKey: .image_url)
        try container.encode(locationName, forKey: .location_name)
        try container.encodeIfPresent(address, forKey: .location_address)
        try container.encodeIfPresent(lat, forKey: .location_lat)
        try container.encodeIfPresent(lon, forKey: .location_lon)
        try container.encodeIfPresent(locationLink, forKey: .location_link)
        try container.encodeIfPresent(locationImage, forKey: .location_image)
        try container.encode(locationDesc, forKey: .location_desc)
        try container.encodeIfPresent(entranceFee, forKey: .customfield_1)
        try container.encode(eventType, forKey: .event_type)
        try container.encodeIfPresent(sounds, forKey: .event_type_2)
    }
    
    enum CodingKeys: String, CodingKey {
        case content, name, permalink
        case start
        case end
        case details
        case repeats
        case event_subtitle = "event_subtitle"
        case learnmore_link = "learnmore_link"
        case featured
        case image_url = "image_url"
        case location_name = "location_name"
        case location_address = "location_address"
        case location_lat = "location_lat"
        case location_lon = "location_lon"
        case location_link = "location_link"
        case location_image = "location_image"
        case location_desc = "location_desc"
        case customfield_1 = "customfield_1"
        case event_type = "event_type"
        case event_type_2 = "event_type_2"
    }
}
