// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Memasukan minimal %@ kategori limbah
  internal static func claimPointRequirementCategory(_ p1: Any) -> String {
    return L10n.tr("Localizations", "claim_point_requirement_category", String(describing: p1))
  }
  /// Kamu dapat mengklaim poin lagi pada jam %@
  internal static func claimPointRequirementHour(_ p1: Any) -> String {
    return L10n.tr("Localizations", "claim_point_requirement_hour", String(describing: p1))
  }
  /// Mengizinkan lokasi dan berada kurang dari sampai dengan %@ meter dari Agen sampah
  internal static func claimPointRequirementLocation(_ p1: Any) -> String {
    return L10n.tr("Localizations", "claim_point_requirement_location", String(describing: p1))
  }
  /// Agen sampah yang dikunjungi berstatus “Buka”
  internal static let claimPointRequirementOpen = L10n.tr("Localizations", "claim_point_requirement_open")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
