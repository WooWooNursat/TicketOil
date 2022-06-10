// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  enum Common {
    static var helloWorld: String {
      return L10n.tr("Localizable", "common.hello_world")
    }
  }

  enum Litres {
    static func count(_ p1: Int) -> String {
      return L10n.tr("Localizable", "litres.count", p1)
    }
  }

  private static let localizationManager = DIResolver.resolve(LocalizationManager.self)!
  public static var bundle = Bundle(path: Bundle.main.path(forResource: localizationManager.language.rawValue, ofType: "lproj")!)
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: bundle ?? Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: localizationManager.locale.toLocale(), arguments: args)
  }
}

private final class BundleToken {}
