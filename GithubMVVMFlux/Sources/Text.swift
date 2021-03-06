// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Navigation {
    internal enum Search {
      /// test
      internal static let test = L10n.tr("Text", "navigation.search.test")
      /// Search
      internal static let title = L10n.tr("Text", "navigation.search.title")
    }
    internal enum Trend {
      /// Trending
      internal static let title = L10n.tr("Text", "navigation.trend.title")
    }
    internal enum UserFavorate {
      /// Your Favorate
      internal static let title = L10n.tr("Text", "navigation.user_favorate.title")
    }
    internal enum UserRepositories {
      /// Your Repositories
      internal static let title = L10n.tr("Text", "navigation.user_repositories.title")
    }
  }

  internal enum TableCell {
    internal enum Trend {
      /// %@ / %@
      internal static func title(_ p1: String, _ p2: String) -> String {
        return L10n.tr("Text", "table_cell.trend.title", p1, p2)
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
