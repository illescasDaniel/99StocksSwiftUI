//  JSONDecoder+Extension.swift
//  Based on extensions from GitHubSearchWithSwiftUI, by marty-suzuki
//  https://github.com/marty-suzuki/GitHubSearchWithSwiftUI

import Foundation
import Combine

// It allows Publisher.Decode to use this decoder
extension JSONDecoder: TopLevelDecoder {}
