//
//  FLACApplicationMetadataBlock.swift
//  HarmonyKit
//
//  Created by Claudio Cambra on 22/2/24.
//

import Foundation

public struct FLACApplicationMetadataBlock {
    public let header: FLACMetadataBlockHeader
    public let appId: String
    public let data: Data

    init(bytes: Data, header: FLACMetadataBlockHeader) throws {
        let expectedSize = 4 + Int(header.metadataBlockDataSize)
        guard bytes.count == expectedSize else {
            throw FLACParser.ParseError.unexpectedEndError(
                "Cannot parse application metadata block, unexpected data size!"
            )
        }
        self.header = header
        let value = bytes[0..<4]
        appId = String(bytes: value, encoding: .ascii) ?? "\(value)"
        data = Data(bytes[4..<expectedSize])
    }
}
