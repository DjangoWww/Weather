//
//  NetWorksActivityPlugin.swift
//  CarSelect
//
//  Created by Django on 2/8/22.
//

import Moya

/// NetWorksActivityPlugin
public final class NetWorksActivityPlugin: PluginType {

    public func willSend(
        _ request: RequestType,
        target: TargetType
    ) {
        NetWorksIndicatorScheduler.shared.pushActivityIndicator()
    }

    public func didReceive(
        _ result: Result<Response, MoyaError>,
        target: TargetType
    ) {
        NetWorksIndicatorScheduler.shared.popActivityIndicator()
    }
}
