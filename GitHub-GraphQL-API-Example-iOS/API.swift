//  This file was automatically generated and should not be edited.

import Apollo

public final class SearchRepositoriesQuery: GraphQLQuery {
  public static let operationString =
    "query SearchRepositories($query: String!, $count: Int!) {" +
    "  search(query: $query, type: REPOSITORY, first: $count) {" +
    "    __typename" +
    "    edges {" +
    "      __typename" +
    "      node {" +
    "        __typename" +
    "        ... on Repository {" +
    "          __typename" +
    "          ...RepositoryDetails" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(RepositoryDetails.fragmentString) }

  public var query: String
  public var count: Int

  public init(query: String, count: Int) {
    self.query = query
    self.count = count
  }

  public var variables: GraphQLMap? {
    return ["query": query, "count": count]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["query": Variable("query"), "type": "REPOSITORY", "first": Variable("count")], type: .nonNull(.object(Search.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(snapshot: snapshot["search"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("edges", type: .list(.object(Edge.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(edges: [Edge?]? = nil) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "edges": edges])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of edges.
      public var edges: [Edge?]? {
        get {
          return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes = ["SearchResultItemEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(node: Node? = nil) {
          self.init(snapshot: ["__typename": "SearchResultItemEdge", "node": node])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(AsRepository.self),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public static func makeIssue() -> Node {
            return Node(snapshot: ["__typename": "Issue"])
          }

          public static func makePullRequest() -> Node {
            return Node(snapshot: ["__typename": "PullRequest"])
          }

          public static func makeRepository(name: String, owner: AsRepository.Owner, stargazers: AsRepository.Stargazer, url: String) -> Node {
            return Node(snapshot: ["__typename": "Repository", "name": name, "owner": owner, "stargazers": stargazers, "url": url])
          }

          public static func makeUser() -> Node {
            return Node(snapshot: ["__typename": "User"])
          }

          public static func makeOrganization() -> Node {
            return Node(snapshot: ["__typename": "Organization"])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var asRepository: AsRepository? {
            get {
              if !AsRepository.possibleTypes.contains(__typename) { return nil }
              return AsRepository(snapshot: snapshot)
            }
            set {
              guard let newValue = newValue else { return }
              snapshot = newValue.snapshot
            }
          }

          public struct AsRepository: GraphQLFragment {
            public static let possibleTypes = ["Repository"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("owner", type: .nonNull(.object(Owner.self))),
              GraphQLField("stargazers", type: .nonNull(.object(Stargazer.self))),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String, owner: Owner, stargazers: Stargazer, url: String) {
              self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner, "stargazers": stargazers, "url": url])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The name of the repository.
            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            /// The User owner of the repository.
            public var owner: Owner {
              get {
                return Owner(snapshot: snapshot["owner"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "owner")
              }
            }

            /// A list of users who have starred this starrable.
            public var stargazers: Stargazer {
              get {
                return Stargazer(snapshot: snapshot["stargazers"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "stargazers")
              }
            }

            /// The HTTP URL for this repository
            public var url: String {
              get {
                return snapshot["url"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "url")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var repositoryDetails: RepositoryDetails {
                get {
                  return RepositoryDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }

            public struct Owner: GraphQLSelectionSet {
              public static let possibleTypes = ["Organization", "User"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("resourcePath", type: .nonNull(.scalar(String.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public static func makeOrganization(resourcePath: String) -> Owner {
                return Owner(snapshot: ["__typename": "Organization", "resourcePath": resourcePath])
              }

              public static func makeUser(resourcePath: String) -> Owner {
                return Owner(snapshot: ["__typename": "User", "resourcePath": resourcePath])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The HTTP URL for the owner.
              public var resourcePath: String {
                get {
                  return snapshot["resourcePath"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "resourcePath")
                }
              }
            }

            public struct Stargazer: GraphQLSelectionSet {
              public static let possibleTypes = ["StargazerConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(totalCount: Int) {
                self.init(snapshot: ["__typename": "StargazerConnection", "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }
            }
          }
        }
      }
    }
  }
}

public struct RepositoryDetails: GraphQLFragment {
  public static let fragmentString =
    "fragment RepositoryDetails on Repository {" +
    "  __typename" +
    "  name" +
    "  owner {" +
    "    __typename" +
    "    resourcePath" +
    "  }" +
    "  stargazers {" +
    "    __typename" +
    "    totalCount" +
    "  }" +
    "  url" +
    "}"

  public static let possibleTypes = ["Repository"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.object(Owner.self))),
    GraphQLField("stargazers", type: .nonNull(.object(Stargazer.self))),
    GraphQLField("url", type: .nonNull(.scalar(String.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(name: String, owner: Owner, stargazers: Stargazer, url: String) {
    self.init(snapshot: ["__typename": "Repository", "name": name, "owner": owner, "stargazers": stargazers, "url": url])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The name of the repository.
  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  /// The User owner of the repository.
  public var owner: Owner {
    get {
      return Owner(snapshot: snapshot["owner"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "owner")
    }
  }

  /// A list of users who have starred this starrable.
  public var stargazers: Stargazer {
    get {
      return Stargazer(snapshot: snapshot["stargazers"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "stargazers")
    }
  }

  /// The HTTP URL for this repository
  public var url: String {
    get {
      return snapshot["url"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "url")
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes = ["Organization", "User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("resourcePath", type: .nonNull(.scalar(String.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public static func makeOrganization(resourcePath: String) -> Owner {
      return Owner(snapshot: ["__typename": "Organization", "resourcePath": resourcePath])
    }

    public static func makeUser(resourcePath: String) -> Owner {
      return Owner(snapshot: ["__typename": "User", "resourcePath": resourcePath])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The HTTP URL for the owner.
    public var resourcePath: String {
      get {
        return snapshot["resourcePath"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "resourcePath")
      }
    }
  }

  public struct Stargazer: GraphQLSelectionSet {
    public static let possibleTypes = ["StargazerConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(totalCount: Int) {
      self.init(snapshot: ["__typename": "StargazerConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return snapshot["totalCount"]! as! Int
      }
      set {
        snapshot.updateValue(newValue, forKey: "totalCount")
      }
    }
  }
}