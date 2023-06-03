//
//  String-EmptyChecking.swift
//  Bookworm
//
//  Created by Uriel Ortega on 03/06/23.
//

import Foundation

extension String {
    var isPureWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
