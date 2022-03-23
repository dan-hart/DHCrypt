//
//  FileManager+documentsDirectory.swift
//  
//
//  Created by Dan Hart on 3/20/22.
//

import Foundation
import FileKit

extension FileManager {
    var documentsDirectoryURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    var documentsDirectoryPath: Path? {
        guard let url = documentsDirectoryURL else {
            return nil
        }

        return Path(url: url)
    }
}
