import AppKit
import ApplicationServices

struct Accessibility {
  static var allowed: Bool { AXIsProcessTrustedWithOptions(nil) }

  /// Pasting posts a synthetic ⌘V keystroke, which macOS silently drops unless
  /// the app has Accessibility permission. When it is missing, ask macOS to show
  /// its own permission prompt (System Settings › Privacy & Security).
  static func check() {
    guard !allowed else {
      return
    }

    let options = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
    _ = AXIsProcessTrustedWithOptions(options)
  }
}
