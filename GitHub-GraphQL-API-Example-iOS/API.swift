//  This file was automatically generated and should not be edited.

import Apollo

public final class SearchRepositoriesQuery: GraphQLQuery {
  public static let operationDefinition =
    "query SearchRepositories($query: String!, $count: Int!) {" +
    "  search(query: $query, type: REPOSITORY, first: $count) {" +
    "    edges {" +
    "      node {" +
    "        __typename" +
    "        ... on Repository {" +
    "          name" +
    "          owner {" +
    "            __typename" +
    "            path" +
    "          }" +
    "          stargazers {" +
    "            totalCount" +
    "          }" +
    "          url" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public let query: String
  public let count: Int

  public init(query: String, count: Int) {
    self.query = query
    self.count = count
  }

  public var variables: GraphQLMap? {
    return ["query": query, "count": count]
  }

  public struct Data: GraphQLMappable {
    public let search: Search

    public init(reader: GraphQLResultReader) throws {
      search = try reader.value(for: Field(responseName: "search"))
    }

    public struct Search: GraphQLMappable {
      public let __typename = "SearchResultItemConnection"
      public let edges: [Edge?]?

      public init(reader: GraphQLResultReader) throws {
        edges = try reader.optionalList(for: Field(responseName: "edges"))
      }

      public struct Edge: GraphQLMappable {
        public let __typename = "SearchResultItemEdge"
        public let node: Node?

        public init(reader: GraphQLResultReader) throws {
          node = try reader.optionalValue(for: Field(responseName: "node"))
        }

        public struct Node: GraphQLMappable {
          public let __typename: String

          public let asRepository: AsRepository?

          public init(reader: GraphQLResultReader) throws {
            __typename = try reader.value(for: Field(responseName: "__typename"))

            asRepository = try AsRepository(reader: reader, ifTypeMatches: __typename)
          }

          public struct AsRepository: GraphQLConditionalFragment {
            public static let possibleTypes = ["Repository"]

            public let __typename = "Repository"
            public let name: String
            public let owner: Owner
            public let stargazers: Stargazer
            public let url: String

            public init(reader: GraphQLResultReader) throws {
              name = try reader.value(for: Field(responseName: "name"))
              owner = try reader.value(for: Field(responseName: "owner"))
              stargazers = try reader.value(for: Field(responseName: "stargazers"))
              url = try reader.value(for: Field(responseName: "url"))
            }

            public struct Owner: GraphQLMappable {
              public let __typename: String
              public let path: String

              public init(reader: GraphQLResultReader) throws {
                __typename = try reader.value(for: Field(responseName: "__typename"))
                path = try reader.value(for: Field(responseName: "path"))
              }
            }

            public struct Stargazer: GraphQLMappable {
              public let __typename = "StargazerConnection"
              public let totalCount: Int

              public init(reader: GraphQLResultReader) throws {
                totalCount = try reader.value(for: Field(responseName: "totalCount"))
              }
            }
          }
        }
      }
    }
  }
}