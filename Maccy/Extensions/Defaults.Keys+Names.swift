import AppKit
import Defaults

struct StorageType {
  static let files = StorageType(types: [.fileURL])
  static let images = StorageType(types: [.png, .tiff, .jpeg, .heic])
  static let text = StorageType(types: [.html, .rtf, .string])
  static let all = StorageType(types: files.types + images.types + text.types)

  var types: [NSPasteboard.PasteboardType]
}

extension Defaults.Keys {
#if DEBUG
  // UI Tests bundle preferences
  static let testingSuiteName = "\(Bundle.main.bundleIdentifier ?? "org.p0deje.Maccy").uitests"

  // When UI tests run with the `enable-testing` argument, window and pin
  // preferences are stored in a separate xcuitest bundle
  private static let preferencesSuite: UserDefaults = CommandLine.arguments.contains("enable-testing")
    ? (UserDefaults(suiteName: testingSuiteName) ?? .standard)
    : .standard
#else
  private static let preferencesSuite: UserDefaults = .standard
#endif

  static let clearOnQuit = Key<Bool>("clearOnQuit", default: false)
  static let clearSystemClipboard = Key<Bool>("clearSystemClipboard", default: false)
  static let clipboardCheckInterval = Key<Double>("clipboardCheckInterval", default: 0.5)
  static let enabledPasteboardTypes = Key<Set<NSPasteboard.PasteboardType>>(
    "enabledPasteboardTypes", default: Set(StorageType.all.types)
  )
  static let highlightMatch = Key<HighlightMatch>("highlightMatch", default: .bold)
  static let ignoreAllAppsExceptListed = Key<Bool>("ignoreAllAppsExceptListed", default: false)
  static let ignoreEvents = Key<Bool>("ignoreEvents", default: false)
  static let ignoreOnlyNextEvent = Key<Bool>("ignoreOnlyNextEvent", default: false)
  static let ignoreRegexp = Key<[String]>("ignoreRegexp", default: [])
  static let ignoredApps = Key<[String]>("ignoredApps", default: [])
  static let ignoredPasteboardTypes = Key<Set<String>>(
    "ignoredPasteboardTypes",
    default: Set([
      "Pasteboard generator type",
      "com.agilebits.onepassword",
      "com.typeit4me.clipping",
      "de.petermaurer.TransientPasteboardType",
      "net.antelle.keeweb"
    ])
  )
  static let imageMaxHeight = Key<Int>("imageMaxHeight", default: 40)
  static let lastReviewRequestedAt = Key<Date>("lastReviewRequestedAt", default: Date.now)
  static let menuIcon = Key<MenuIcon>("menuIcon", default: .maccy)
  static let migrations = Key<[String: Bool]>("migrations", default: [:])
  static let numberOfUsages = Key<Int>("numberOfUsages", default: 0)
  static let pasteByDefault = Key<Bool>("pasteByDefault", default: false)
  static let pinTo = Key<PinsPosition>("pinTo", default: .top, suite: preferencesSuite)
  static let popupPosition = Key<PopupPosition>("popupPosition", default: .cursor)
  static let popupScreen = Key<Int>("popupScreen", default: 0)
  // Off in this fork: hovering a row no longer slides the preview panel out beside the list.
  // The preview is still there on demand (its toolbar button / shortcut).
  static let openPreviewAutomatically = Key<Bool>("openPreviewAutomatically", default: false)
  static let previewDelay = Key<Int>("previewDelay", default: 1500)
  static let removeFormattingByDefault = Key<Bool>("removeFormattingByDefault", default: false)
  static let searchMode = Key<Search.Mode>("searchMode", default: .exact)
  // Off in this fork, with showSearch below: the popup is the clips and nothing else. The footer's
  // actions keep their shortcuts while hidden (⌘, for settings, ⌘Q to quit).
  static let showFooter = Key<Bool>("showFooter", default: false)
  static let showInStatusBar = Key<Bool>("showInStatusBar", default: true)
  static let showRecentCopyInMenuBar = Key<Bool>("showRecentCopyInMenuBar", default: false)
  static let showSearch = Key<Bool>("showSearch", default: false)
  // The ⌘1-style label at the end of each row. Off in this fork; the shortcuts themselves stay.
  static let showShortcuts = Key<Bool>("showShortcuts", default: false)
  static let searchVisibility = Key<SearchVisibility>("searchVisibility", default: .always)
  static let showSpecialSymbols = Key<Bool>("showSpecialSymbols", default: true)
  static let showTitle = Key<Bool>("showTitle", default: true)
  static let size = Key<Int>("historySize", default: 200)
  // How many unpinned items the popup lists. The rest of the history is kept, just not shown.
  // 0 lists everything, as upstream does. `defaults write org.p0deje.Maccy visibleSize -int 5`.
  static let visibleSize = Key<Int>("visibleSize", default: 3)
  static let sortBy = Key<Sorter.By>("sortBy", default: .lastCopiedAt)
  static let suppressClearAlert = Key<Bool>("suppressClearAlert", default: false)
  static let windowSize = Key<NSSize>("windowSize", default: NSSize(width: 450, height: 800), suite: preferencesSuite)
  static let windowPosition = Key<NSPoint>("windowPosition", default: NSPoint(x: 0.5, y: 0.8))
  static let showApplicationIcons = Key<Bool>("showApplicationIcons", default: false)
  static let showHexColorSwatch = Key<Bool>("showHexColorSwatch", default: true)
  static let previewWidth = Key<CGFloat>("previewWidth", default: 400)
}
