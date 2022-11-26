//
//  User+sampleJSON.swift
//  iOSEngineerCodeCheck
//
//  Created by HIROKI IKEUCHI on 2022/11/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

extension User {
    
    static var sampleJSON: String {
        return #"""
{
    "login": "tensorflow",
    "id": 15658638,
    "node_id": "MDEyOk9yZ2FuaXphdGlvbjE1NjU4NjM4",
    "avatar_url": "https://avatars.githubusercontent.com/u/15658638?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/tensorflow",
    "html_url": "https://github.com/tensorflow",
    "followers_url": "https://api.github.com/users/tensorflow/followers",
    "following_url": "https://api.github.com/users/tensorflow/following{/other_user}",
    "gists_url": "https://api.github.com/users/tensorflow/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/tensorflow/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/tensorflow/subscriptions",
    "organizations_url": "https://api.github.com/users/tensorflow/orgs",
    "repos_url": "https://api.github.com/users/tensorflow/repos",
    "events_url": "https://api.github.com/users/tensorflow/events{/privacy}",
    "received_events_url": "https://api.github.com/users/tensorflow/received_events",
    "type": "Organization",
    "site_admin": false
}
"""#
    }
}
