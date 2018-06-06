import AppKit
import ScriptingBridge

// Generated 13 Feb 2018 by Maxime De Greve
// Using: https://github.com/tingraldi/SwiftScripting

@objc public protocol SBObjectProtocol: NSObjectProtocol {
    func get() -> Any!
}

@objc public protocol SBApplicationProtocol: SBObjectProtocol {
    func activate()
    var delegate: SBApplicationDelegate! { get set }
    var isRunning: Bool { get }
}

// MARK: KeynoteSaveOptions
@objc public enum KeynoteSaveOptions : AEKeyword {
    case yes = 0x79657320 /* b'yes ' */
    case no = 0x6e6f2020 /* b'no  ' */
    case ask = 0x61736b20 /* b'ask ' */
}

// MARK: KeynotePrintingErrorHandling
@objc public enum KeynotePrintingErrorHandling : AEKeyword {
    case standard = 0x6c777374 /* b'lwst' */
    case detailed = 0x6c776474 /* b'lwdt' */
}

// MARK: KeynoteSaveableFileFormat
@objc public enum KeynoteSaveableFileFormat : AEKeyword {
    case keynote = 0x4b6e6666 /* b'Knff' */
}

// MARK: KeynoteExportFormat
@objc public enum KeynoteExportFormat : AEKeyword {
    case html = 0x4b68746d /* b'Khtm' */
    case quickTimeMovie = 0x4b6d6f76 /* b'Kmov' */
    case pdf = 0x4b706466 /* b'Kpdf' */
    case slideImages = 0x4b696d67 /* b'Kimg' */
    case microsoftPowerPoint = 0x4b707074 /* b'Kppt' */
    case keynote09 = 0x4b6b6579 /* b'Kkey' */
}

// MARK: KeynoteImageExportFormats
@objc public enum KeynoteImageExportFormats : AEKeyword {
    case jpeg = 0x4b69666a /* b'Kifj' */
    case png = 0x4b696670 /* b'Kifp' */
    case tiff = 0x4b696674 /* b'Kift' */
}

// MARK: KeynoteMovieExportFormats
@objc public enum KeynoteMovieExportFormats : AEKeyword {
    case i360p = 0x4b6d6633 /* b'Kmf3' */
    case i540p = 0x4b6d6635 /* b'Kmf5' */
    case i720p = 0x4b6d6637 /* b'Kmf7' */
    case i1080p = 0x4b6d6638 /* b'Kmf8' */
    case i2160p = 0x4b6d6634 /* b'Kmf4' */
    case nativeSize = 0x4b6d664e /* b'KmfN' */
}

// MARK: KeynotePrintWhat
@objc public enum KeynotePrintWhat : AEKeyword {
    case individualSlides = 0x4b707769 /* b'Kpwi' */
    case slideWithNotes = 0x4b70776e /* b'Kpwn' */
    case handouts = 0x4b707768 /* b'Kpwh' */
}

// MARK: KeynotePDFImageQuality
@objc public enum KeynotePDFImageQuality : AEKeyword {
    case good = 0x4b6e5030 /* b'KnP0' */
    case better = 0x4b6e5031 /* b'KnP1' */
    case best = 0x4b6e5032 /* b'KnP2' */
}

// MARK: KeynoteTransitionEffects
@objc public enum KeynoteTransitionEffects : AEKeyword {
    case noTransitionEffect = 0x746e696c /* b'tnil' */
    case magicMove = 0x746d6a76 /* b'tmjv' */
    case shimmer = 0x7473686d /* b'tshm' */
    case sparkle = 0x7473706b /* b'tspk' */
    case swing = 0x74737767 /* b'tswg' */
    case objectCube = 0x746f6362 /* b'tocb' */
    case objectFlip = 0x746f6670 /* b'tofp' */
    case objectPop = 0x746f7070 /* b'topp' */
    case objectPush = 0x746f7068 /* b'toph' */
    case objectRevolve = 0x746f7276 /* b'torv' */
    case objectZoom = 0x746f7a6d /* b'tozm' */
    case perspective = 0x74707273 /* b'tprs' */
    case clothesline = 0x74636c6f /* b'tclo' */
    case confetti = 0x74636674 /* b'tcft' */
    case dissolve = 0x74646973 /* b'tdis' */
    case drop = 0x74647270 /* b'tdrp' */
    case droplet = 0x7464706c /* b'tdpl' */
    case fadeThroughColor = 0x74667463 /* b'tftc' */
    case grid = 0x74677264 /* b'tgrd' */
    case iris = 0x74697273 /* b'tirs' */
    case moveIn = 0x746d7669 /* b'tmvi' */
    case push = 0x74707368 /* b'tpsh' */
    case reveal = 0x7472766c /* b'trvl' */
    case `switch` = 0x74737769 /* b'tswi' */
    case wipe = 0x74777065 /* b'twpe' */
    case blinds = 0x74626c64 /* b'tbld' */
    case colorPlanes = 0x7463706c /* b'tcpl' */
    case cube = 0x74637562 /* b'tcub' */
    case doorway = 0x74647779 /* b'tdwy' */
    case fall = 0x7466616c /* b'tfal' */
    case flip = 0x74666970 /* b'tfip' */
    case flop = 0x74666f70 /* b'tfop' */
    case mosaic = 0x746d7363 /* b'tmsc' */
    case pageFlip = 0x7470666c /* b'tpfl' */
    case pivot = 0x74707674 /* b'tpvt' */
    case reflection = 0x7472666c /* b'trfl' */
    case revolvingDoor = 0x74726576 /* b'trev' */
    case scale = 0x7473636c /* b'tscl' */
    case swap = 0x74737770 /* b'tswp' */
    case swoosh = 0x74737773 /* b'tsws' */
    case twirl = 0x7474776c /* b'ttwl' */
    case twist = 0x74747769 /* b'ttwi' */
}

// MARK: KeynoteTAVT
@objc public enum KeynoteTAVT : AEKeyword {
    case bottom = 0x61766274 /* b'avbt' */
    case center = 0x61637472 /* b'actr' */
    case top = 0x61767470 /* b'avtp' */
}

// MARK: KeynoteTAHT
@objc public enum KeynoteTAHT : AEKeyword {
    case autoAlign = 0x61617574 /* b'aaut' */
    case center = 0x61637472 /* b'actr' */
    case justify = 0x616a7374 /* b'ajst' */
    case left = 0x616c6674 /* b'alft' */
    case right = 0x61726974 /* b'arit' */
}

// MARK: KeynoteNMSD
@objc public enum KeynoteNMSD : AEKeyword {
    case ascending = 0x6173636e /* b'ascn' */
    case descending = 0x6473636e /* b'dscn' */
}

// MARK: KeynoteNMCT
@objc public enum KeynoteNMCT : AEKeyword {
    case automatic = 0x66617574 /* b'faut' */
    case checkbox = 0x66636368 /* b'fcch' */
    case currency = 0x66637572 /* b'fcur' */
    case dateAndTime = 0x6664746d /* b'fdtm' */
    case fraction = 0x66667261 /* b'ffra' */
    case number = 0x6e6d6272 /* b'nmbr' */
    case percent = 0x66706572 /* b'fper' */
    case popUpMenu = 0x66637070 /* b'fcpp' */
    case scientific = 0x66736369 /* b'fsci' */
    case slider = 0x6663736c /* b'fcsl' */
    case stepper = 0x66637374 /* b'fcst' */
    case text = 0x63747874 /* b'ctxt' */
    case duration = 0x66647572 /* b'fdur' */
    case rating = 0x66726174 /* b'frat' */
    case numeralSystem = 0x66636e73 /* b'fcns' */
}

// MARK: KeynoteItemFillOptions
@objc public enum KeynoteItemFillOptions : AEKeyword {
    case noFill = 0x66696e6f /* b'fino' */
    case colorFill = 0x6669636f /* b'fico' */
    case gradientFill = 0x66696772 /* b'figr' */
    case advancedGradientFill = 0x66696167 /* b'fiag' */
    case imageFill = 0x6669696d /* b'fiim' */
    case advancedImageFill = 0x66696169 /* b'fiai' */
}

// MARK: KeynotePlaybackRepetitionMethod
@objc public enum KeynotePlaybackRepetitionMethod : AEKeyword {
    case none = 0x6d76726e /* b'mvrn' */
    case loop = 0x6d766c70 /* b'mvlp' */
    case loopBackAndForth = 0x6d766266 /* b'mvbf' */
}

// MARK: KeynoteLegacyChartType
@objc public enum KeynoteLegacyChartType : AEKeyword {
    case pie_2d = 0x70696532 /* b'pie2' */
    case vertical_bar_2d = 0x76627232 /* b'vbr2' */
    case stacked_vertical_bar_2d = 0x73766232 /* b'svb2' */
    case horizontal_bar_2d = 0x68627232 /* b'hbr2' */
    case stacked_horizontal_bar_2d = 0x73686232 /* b'shb2' */
    case pie_3d = 0x70696533 /* b'pie3' */
    case vertical_bar_3d = 0x76627233 /* b'vbr3' */
    case stacked_vertical_bar_3d = 0x73766233 /* b'svb3' */
    case horizontal_bar_3d = 0x68627233 /* b'hbr3' */
    case stacked_horizontal_bar_3d = 0x73686233 /* b'shb3' */
    case area_2d = 0x61726532 /* b'are2' */
    case stacked_area_2d = 0x73617232 /* b'sar2' */
    case line_2d = 0x6c696e32 /* b'lin2' */
    case line_3d = 0x6c696e33 /* b'lin3' */
    case area_3d = 0x61726533 /* b'are3' */
    case stacked_area_3d = 0x73617233 /* b'sar3' */
    case scatterplot_2d = 0x73637032 /* b'scp2' */
}

// MARK: KeynoteLegacyChartGrouping
@objc public enum KeynoteLegacyChartGrouping : AEKeyword {
    case chartRow = 0x4b436772 /* b'KCgr' */
    case chartColumn = 0x4b436763 /* b'KCgc' */
}

// MARK: KeynoteGenericMethods
@objc public protocol KeynoteGenericMethods {
    @objc optional func closeSaving(_ saving: KeynoteSaveOptions, savingIn: URL!) // Close a document.
    @objc optional func saveIn(_ in_: URL!, as: KeynoteSaveableFileFormat) // Save a document.
    @objc optional func printWithProperties(_ withProperties: [AnyHashable : Any]!, printDialog: Bool) // Print a document.
    @objc optional func delete() // Delete an object.
    @objc optional func duplicateTo(_ to: SBObject!, withProperties: [AnyHashable : Any]!) // Copy an object.
    @objc optional func moveTo(_ to: SBObject!) // Move an object to a new location.
}

// MARK: KeynoteApplication
@objc public protocol KeynoteApplication: SBApplicationProtocol {
    @objc optional func documents() -> SBElementArray
    @objc optional func windows() -> SBElementArray
    @objc optional var name: String { get } // The name of the application.
    @objc optional var frontmost: Bool { get } // Is this the active application?
    @objc optional var version: String { get } // The version number of the application.
    @objc optional func `open`(_ x: Any!) -> Any // Open a document.
    @objc optional func print(_ x: Any!, withProperties: [AnyHashable : Any]!, printDialog: Bool) // Print a document.
    @objc optional func quitSaving(_ saving: KeynoteSaveOptions) // Quit the application.
    @objc optional func exists(_ x: Any!) -> Bool // Verify that an object exists.
    @objc optional func showNext() // Advance one build or slide.
    @objc optional func showPrevious() // Go to the previous slide.
    @objc optional func themes() -> SBElementArray
}
extension SBApplication: KeynoteApplication {}

// MARK: KeynoteDocument
@objc public protocol KeynoteDocument: SBObjectProtocol, KeynoteGenericMethods {
    @objc optional var name: String { get } // Its name.
    @objc optional var modified: Bool { get } // Has it been modified since the last save?
    @objc optional var file: URL { get } // Its location on disk, if it has one.
    @objc optional func exportTo(_ to: URL!, as: KeynoteExportFormat, withProperties: [AnyHashable : Any]!) // Export a slideshow to another file
    @objc optional func startFrom(_ from: KeynoteSlide!) // Start playing the presentation.
    @objc optional func makeImageSlidesFiles(_ files: [URL]!, setTitles: Bool, master: KeynoteMasterSlide!) // Make a series of slides from a list of files.
    @objc optional func stop() // Stop the presentation.
    @objc optional func showSlideSwitcher() // Show the slide switcher in play mode
    @objc optional func hideSlideSwitcher() // Hide the slide switcher in play mode
    @objc optional func moveSlideSwitcherForward() // Move the slide switcher forward one slide
    @objc optional func moveSlideSwitcherBackward() // Move the slide switcher backward one slide
    @objc optional func cancelSlideSwitcher() // Hide the slide switcher without changing slides
    @objc optional func acceptSlideSwitcher() // Hide the slide switcher, going to the slide it has selected
    @objc optional func slides() -> SBElementArray
    @objc optional func masterSlides() -> SBElementArray
    @objc optional func id() -> String // Document ID.
    @objc optional var slideNumbersShowing: Bool { get } // Are the slide numbers displayed?
    @objc optional var documentTheme: KeynoteTheme { get } // The theme assigned to the document.
    @objc optional var autoLoop: Bool { get } // Make the slideshow play repeatedly.
    @objc optional var autoPlay: Bool { get } // Automatically play the presentation when opening the file.
    @objc optional var autoRestart: Bool { get } // Restart the slideshow if it's inactive for the specified time
    @objc optional var maximumIdleDuration: Int { get } // Restart the slideshow if it's inactive for the specified time
    @objc optional var currentSlide: KeynoteSlide { get } // The currently selected slide, or the slide that would display if the presentation was started.
    @objc optional var height: Int { get } // The height of the document (in points). Standard slide height = 768. Wide slide height = 1080.
    @objc optional var width: Int { get } // The width of the document (in points). Standard slide width = 1024. Wide slide width = 1920.
    @objc optional func setSlideNumbersShowing(_ slideNumbersShowing: Bool) // Are the slide numbers displayed?
    @objc optional func setDocumentTheme(_ documentTheme: KeynoteTheme!) // The theme assigned to the document.
    @objc optional func setAutoLoop(_ autoLoop: Bool) // Make the slideshow play repeatedly.
    @objc optional func setAutoPlay(_ autoPlay: Bool) // Automatically play the presentation when opening the file.
    @objc optional func setAutoRestart(_ autoRestart: Bool) // Restart the slideshow if it's inactive for the specified time
    @objc optional func setMaximumIdleDuration(_ maximumIdleDuration: Int) // Restart the slideshow if it's inactive for the specified time
    @objc optional func setCurrentSlide(_ currentSlide: KeynoteSlide!) // The currently selected slide, or the slide that would display if the presentation was started.
    @objc optional func setHeight(_ height: Int) // The height of the document (in points). Standard slide height = 768. Wide slide height = 1080.
    @objc optional func setWidth(_ width: Int) // The width of the document (in points). Standard slide width = 1024. Wide slide width = 1920.
}
extension SBObject: KeynoteDocument {}

// MARK: KeynoteWindow
@objc public protocol KeynoteWindow: SBObjectProtocol, KeynoteGenericMethods {
    @objc optional var name: String { get } // The title of the window.
    @objc optional func id() -> Int // The unique identifier of the window.
    @objc optional var index: Int { get } // The index of the window, ordered front to back.
    @objc optional var bounds: NSRect { get } // The bounding rectangle of the window.
    @objc optional var closeable: Bool { get } // Does the window have a close button?
    @objc optional var miniaturizable: Bool { get } // Does the window have a minimize button?
    @objc optional var miniaturized: Bool { get } // Is the window minimized right now?
    @objc optional var resizable: Bool { get } // Can the window be resized?
    @objc optional var visible: Bool { get } // Is the window visible right now?
    @objc optional var zoomable: Bool { get } // Does the window have a zoom button?
    @objc optional var zoomed: Bool { get } // Is the window zoomed right now?
    @objc optional var document: KeynoteDocument { get } // The document whose contents are displayed in the window.
    @objc optional func setIndex(_ index: Int) // The index of the window, ordered front to back.
    @objc optional func setBounds(_ bounds: NSRect) // The bounding rectangle of the window.
    @objc optional func setMiniaturized(_ miniaturized: Bool) // Is the window minimized right now?
    @objc optional func setVisible(_ visible: Bool) // Is the window visible right now?
    @objc optional func setZoomed(_ zoomed: Bool) // Is the window zoomed right now?
}
extension SBObject: KeynoteWindow {}

// MARK: KeynoteTheme
@objc public protocol KeynoteTheme: SBObjectProtocol, KeynoteGenericMethods {
    @objc optional func id() -> String // The identifier used by the application.
    @objc optional var name: String { get }
}
extension SBObject: KeynoteTheme {}

// MARK: KeynoteRichText
@objc public protocol KeynoteRichText: SBObjectProtocol, KeynoteGenericMethods {
    @objc optional func characters() -> SBElementArray
    @objc optional func paragraphs() -> SBElementArray
    @objc optional func words() -> SBElementArray
    @objc optional var color: NSColor { get } // The color of the font. Expressed as an RGB value consisting of a list of three color values from 0 to 65535. ex: Blue = {0, 0, 65535}.
    @objc optional var font: String { get } // The name of the font.  Can be the PostScript name, such as: “TimesNewRomanPS-ItalicMT”, or display name: “Times New Roman Italic”. TIP: Use the Font Book application get the information about a typeface.
    @objc optional var size: Int { get } // The size of the font.
    @objc optional func setColor(_ color: NSColor!) // The color of the font. Expressed as an RGB value consisting of a list of three color values from 0 to 65535. ex: Blue = {0, 0, 65535}.
    @objc optional func setFont(_ font: String!) // The name of the font.  Can be the PostScript name, such as: “TimesNewRomanPS-ItalicMT”, or display name: “Times New Roman Italic”. TIP: Use the Font Book application get the information about a typeface.
    @objc optional func setSize(_ size: Int) // The size of the font.
}
extension SBObject: KeynoteRichText {}

// MARK: KeynoteCharacter
@objc public protocol KeynoteCharacter: KeynoteRichText {
}
extension SBObject: KeynoteCharacter {}

// MARK: KeynoteParagraph
@objc public protocol KeynoteParagraph: KeynoteRichText {
    @objc optional func characters() -> SBElementArray
    @objc optional func words() -> SBElementArray
}
extension SBObject: KeynoteParagraph {}

// MARK: KeynoteWord
@objc public protocol KeynoteWord: KeynoteRichText {
    @objc optional func characters() -> SBElementArray
}
extension SBObject: KeynoteWord {}

// MARK: KeynoteIWorkContainer
@objc public protocol KeynoteIWorkContainer: SBObjectProtocol, KeynoteGenericMethods {
    @objc optional func audioClips() -> SBElementArray
    @objc optional func charts() -> SBElementArray
    @objc optional func images() -> SBElementArray
    @objc optional func iWorkItems() -> SBElementArray
    @objc optional func groups() -> SBElementArray
    @objc optional func lines() -> SBElementArray
    @objc optional func movies() -> SBElementArray
    @objc optional func shapes() -> SBElementArray
    @objc optional func tables() -> SBElementArray
    @objc optional func textItems() -> SBElementArray
}
extension SBObject: KeynoteIWorkContainer {}

// MARK: KeynoteSlide
@objc public protocol KeynoteSlide: KeynoteIWorkContainer {
    @objc optional var baseSlide: KeynoteMasterSlide { get } // The master slide this slide is based upon
    @objc optional var bodyShowing: Bool { get } // Is the default body text displayed?
    @objc optional var skipped: Bool { get } // Is the slide skipped?
    @objc optional var slideNumber: Int { get } // index of the slide in the document
    @objc optional var titleShowing: Bool { get } // Is the default slide title displayed?
    @objc optional var defaultBodyItem: KeynoteShape { get } // The default body container of the slide
    @objc optional var defaultTitleItem: KeynoteShape { get } // The default title container of the slide
    @objc optional var presenterNotes: KeynoteRichText { get } // The presenter notes for the slide
    @objc optional var transitionProperties: [AnyHashable : Any] { get } // The transition settings to apply to the slide.
    @objc optional func addChartRowNames(_ rowNames: [String]!, columnNames: [String]!, data: [Any]!, type: KeynoteLegacyChartType, groupBy: KeynoteLegacyChartGrouping) // Add a chart to a slide
    @objc optional func setBaseSlide(_ baseSlide: KeynoteMasterSlide!) // The master slide this slide is based upon
    @objc optional func setBodyShowing(_ bodyShowing: Bool) // Is the default body text displayed?
    @objc optional func setSkipped(_ skipped: Bool) // Is the slide skipped?
    @objc optional func setTitleShowing(_ titleShowing: Bool) // Is the default slide title displayed?
    @objc optional func setPresenterNotes(_ presenterNotes: KeynoteRichText!) // The presenter notes for the slide
    @objc optional func setTransitionProperties(_ transitionProperties: [AnyHashable : Any]!) // The transition settings to apply to the slide.
}
extension SBObject: KeynoteSlide {}

// MARK: KeynoteMasterSlide
@objc public protocol KeynoteMasterSlide: KeynoteSlide {
    @objc optional var name: String { get } // The name of the master slide
}
extension SBObject: KeynoteMasterSlide {}

// MARK: KeynoteIWorkItem
@objc public protocol KeynoteIWorkItem: SBObjectProtocol, KeynoteGenericMethods {
    @objc optional var height: Int { get } // The height of the iWork item.
    @objc optional var locked: Bool { get } // Whether the object is locked.
    @objc optional var parent: KeynoteIWorkContainer { get } // The iWork container containing this iWork item.
    @objc optional var position: NSPoint { get } // The horizontal and vertical coordinates of the top left point of the iWork item.
    @objc optional var width: Int { get } // The width of the iWork item.
    @objc optional func setHeight(_ height: Int) // The height of the iWork item.
    @objc optional func setLocked(_ locked: Bool) // Whether the object is locked.
    @objc optional func setPosition(_ position: NSPoint) // The horizontal and vertical coordinates of the top left point of the iWork item.
    @objc optional func setWidth(_ width: Int) // The width of the iWork item.
}
extension SBObject: KeynoteIWorkItem {}

// MARK: KeynoteAudioClip
@objc public protocol KeynoteAudioClip: KeynoteIWorkItem {
    @objc optional var fileName: Any { get } // The name of the audio file.
    @objc optional var clipVolume: Int { get } // The volume setting for the audio clip, from 0 (none) to 100 (full volume).
    @objc optional var repetitionMethod: KeynotePlaybackRepetitionMethod { get } // If or how the audio clip repeats.
    @objc optional func setFileName(_ fileName: Any!) // The name of the audio file.
    @objc optional func setClipVolume(_ clipVolume: Int) // The volume setting for the audio clip, from 0 (none) to 100 (full volume).
    @objc optional func setRepetitionMethod(_ repetitionMethod: KeynotePlaybackRepetitionMethod) // If or how the audio clip repeats.
}
extension SBObject: KeynoteAudioClip {}

// MARK: KeynoteShape
@objc public protocol KeynoteShape: KeynoteIWorkItem {
    @objc optional var backgroundFillType: KeynoteItemFillOptions { get } // The background, if any, for the shape.
    @objc optional var objectText: KeynoteRichText { get } // The text contained within the shape.
    @objc optional var reflectionShowing: Bool { get } // Is the iWork item displaying a reflection?
    @objc optional var reflectionValue: Int { get } // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional var rotation: Int { get } // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional var opacity: Int { get } // The opacity of the object, in percent.
    @objc optional func setObjectText(_ objectText: KeynoteRichText!) // The text contained within the shape.
    @objc optional func setReflectionShowing(_ reflectionShowing: Bool) // Is the iWork item displaying a reflection?
    @objc optional func setReflectionValue(_ reflectionValue: Int) // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional func setRotation(_ rotation: Int) // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional func setOpacity(_ opacity: Int) // The opacity of the object, in percent.
}
extension SBObject: KeynoteShape {}

// MARK: KeynoteChart
@objc public protocol KeynoteChart: KeynoteIWorkItem {
}
extension SBObject: KeynoteChart {}

// MARK: KeynoteImage
@objc public protocol KeynoteImage: KeynoteIWorkItem {
    @objc optional var objectDescription: String { get } // Text associated with the image, read aloud by VoiceOver.
    @objc optional var file: URL { get } // The image file.
    @objc optional var fileName: Any { get } // The name of the image file.
    @objc optional var opacity: Int { get } // The opacity of the object, in percent.
    @objc optional var reflectionShowing: Bool { get } // Is the iWork item displaying a reflection?
    @objc optional var reflectionValue: Int { get } // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional var rotation: Int { get } // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional func setObjectDescription(_ objectDescription: String!) // Text associated with the image, read aloud by VoiceOver.
    @objc optional func setFileName(_ fileName: Any!) // The name of the image file.
    @objc optional func setOpacity(_ opacity: Int) // The opacity of the object, in percent.
    @objc optional func setReflectionShowing(_ reflectionShowing: Bool) // Is the iWork item displaying a reflection?
    @objc optional func setReflectionValue(_ reflectionValue: Int) // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional func setRotation(_ rotation: Int) // The rotation of the iWork item, in degrees from 0 to 359.
}
extension SBObject: KeynoteImage {}

// MARK: KeynoteGroup
@objc public protocol KeynoteGroup: KeynoteIWorkContainer {
    @objc optional var height: Int { get } // The height of the iWork item.
    @objc optional var parent: KeynoteIWorkContainer { get } // The iWork container containing this iWork item.
    @objc optional var position: NSPoint { get } // The horizontal and vertical coordinates of the top left point of the iWork item.
    @objc optional var width: Int { get } // The width of the iWork item.
    @objc optional var rotation: Int { get } // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional func setHeight(_ height: Int) // The height of the iWork item.
    @objc optional func setPosition(_ position: NSPoint) // The horizontal and vertical coordinates of the top left point of the iWork item.
    @objc optional func setWidth(_ width: Int) // The width of the iWork item.
    @objc optional func setRotation(_ rotation: Int) // The rotation of the iWork item, in degrees from 0 to 359.
}
extension SBObject: KeynoteGroup {}

// MARK: KeynoteLine
@objc public protocol KeynoteLine: KeynoteIWorkItem {
    @objc optional var endPoint: NSPoint { get } // A list of two numbers indicating the horizontal and vertical position of the line ending point.
    @objc optional var reflectionShowing: Bool { get } // Is the iWork item displaying a reflection?
    @objc optional var reflectionValue: Int { get } // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional var rotation: Int { get } // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional var startPoint: NSPoint { get } // A list of two numbers indicating the horizontal and vertical position of the line starting point.
    @objc optional func setEndPoint(_ endPoint: NSPoint) // A list of two numbers indicating the horizontal and vertical position of the line ending point.
    @objc optional func setReflectionShowing(_ reflectionShowing: Bool) // Is the iWork item displaying a reflection?
    @objc optional func setReflectionValue(_ reflectionValue: Int) // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional func setRotation(_ rotation: Int) // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional func setStartPoint(_ startPoint: NSPoint) // A list of two numbers indicating the horizontal and vertical position of the line starting point.
}
extension SBObject: KeynoteLine {}

// MARK: KeynoteMovie
@objc public protocol KeynoteMovie: KeynoteIWorkItem {
    @objc optional var fileName: Any { get } // The name of the movie file.
    @objc optional var movieVolume: Int { get } // The volume setting for the movie, from 0 (none) to 100 (full volume).
    @objc optional var opacity: Int { get } // The opacity of the object, in percent.
    @objc optional var reflectionShowing: Bool { get } // Is the iWork item displaying a reflection?
    @objc optional var reflectionValue: Int { get } // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional var repetitionMethod: KeynotePlaybackRepetitionMethod { get } // If or how the movie repeats.
    @objc optional var rotation: Int { get } // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional func setFileName(_ fileName: Any!) // The name of the movie file.
    @objc optional func setMovieVolume(_ movieVolume: Int) // The volume setting for the movie, from 0 (none) to 100 (full volume).
    @objc optional func setOpacity(_ opacity: Int) // The opacity of the object, in percent.
    @objc optional func setReflectionShowing(_ reflectionShowing: Bool) // Is the iWork item displaying a reflection?
    @objc optional func setReflectionValue(_ reflectionValue: Int) // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional func setRepetitionMethod(_ repetitionMethod: KeynotePlaybackRepetitionMethod) // If or how the movie repeats.
    @objc optional func setRotation(_ rotation: Int) // The rotation of the iWork item, in degrees from 0 to 359.
}
extension SBObject: KeynoteMovie {}

// MARK: KeynoteTable
@objc public protocol KeynoteTable: KeynoteIWorkItem {
    @objc optional func cells() -> SBElementArray
    @objc optional func rows() -> SBElementArray
    @objc optional func columns() -> SBElementArray
    @objc optional func ranges() -> SBElementArray
    @objc optional var name: String { get } // The item's name.
    @objc optional var cellRange: KeynoteRange { get } // The range describing every cell in the table.
    @objc optional var selectionRange: KeynoteRange { get } // The cells currently selected in the table.
    @objc optional var rowCount: Int { get } // The number of rows in the table.
    @objc optional var columnCount: Int { get } // The number of columns in the table.
    @objc optional var headerRowCount: Int { get } // The number of header rows in the table.
    @objc optional var headerColumnCount: Int { get } // The number of header columns in the table.
    @objc optional var footerRowCount: Int { get } // The number of footer rows in the table.
    @objc optional func sortBy(_ by: KeynoteColumn!, direction: KeynoteNMSD, inRows: KeynoteRange!) // Sort the rows of the table.
    @objc optional func setName(_ name: String!) // The item's name.
    @objc optional func setSelectionRange(_ selectionRange: KeynoteRange!) // The cells currently selected in the table.
    @objc optional func setRowCount(_ rowCount: Int) // The number of rows in the table.
    @objc optional func setColumnCount(_ columnCount: Int) // The number of columns in the table.
    @objc optional func setHeaderRowCount(_ headerRowCount: Int) // The number of header rows in the table.
    @objc optional func setHeaderColumnCount(_ headerColumnCount: Int) // The number of header columns in the table.
    @objc optional func setFooterRowCount(_ footerRowCount: Int) // The number of footer rows in the table.
}
extension SBObject: KeynoteTable {}

// MARK: KeynoteTextItem
@objc public protocol KeynoteTextItem: KeynoteIWorkItem {
    @objc optional var backgroundFillType: KeynoteItemFillOptions { get } // The background, if any, for the text item.
    @objc optional var objectText: KeynoteRichText { get } // The text contained within the text item.
    @objc optional var opacity: Int { get } // The opacity of the object, in percent.
    @objc optional var reflectionShowing: Bool { get } // Is the iWork item displaying a reflection?
    @objc optional var reflectionValue: Int { get } // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional var rotation: Int { get } // The rotation of the iWork item, in degrees from 0 to 359.
    @objc optional func setObjectText(_ objectText: KeynoteRichText!) // The text contained within the text item.
    @objc optional func setOpacity(_ opacity: Int) // The opacity of the object, in percent.
    @objc optional func setReflectionShowing(_ reflectionShowing: Bool) // Is the iWork item displaying a reflection?
    @objc optional func setReflectionValue(_ reflectionValue: Int) // The percentage of reflection of the iWork item, from 0 (none) to 100 (full).
    @objc optional func setRotation(_ rotation: Int) // The rotation of the iWork item, in degrees from 0 to 359.
}
extension SBObject: KeynoteTextItem {}

// MARK: KeynoteRange
@objc public protocol KeynoteRange: SBObjectProtocol, KeynoteGenericMethods {
    @objc optional func cells() -> SBElementArray
    @objc optional func columns() -> SBElementArray
    @objc optional func rows() -> SBElementArray
    @objc optional var fontName: String { get } // The font of the range's cells.
    @objc optional var fontSize: Double { get } // The font size of the range's cells.
    @objc optional var format: KeynoteNMCT { get } // The format of the range's cells.
    @objc optional var alignment: KeynoteTAHT { get } // The horizontal alignment of content in the range's cells.
    @objc optional var name: String { get } // The range's coordinates.
    @objc optional var textColor: NSColor { get } // The text color of the range's cells.
    @objc optional var textWrap: Bool { get } // Whether text should wrap in the range's cells.
    @objc optional var backgroundColor: NSColor { get } // The background color of the range's cells.
    @objc optional var verticalAlignment: KeynoteTAVT { get } // The vertical alignment of content in the range's cells.
    @objc optional func clear() // Clear the contents of a specified range of cells, including formatting and style.
    @objc optional func merge() // Merge a specified range of cells.
    @objc optional func unmerge() // Unmerge all merged cells in a specified range.
    @objc optional func setFontName(_ fontName: String!) // The font of the range's cells.
    @objc optional func setFontSize(_ fontSize: Double) // The font size of the range's cells.
    @objc optional func setFormat(_ format: KeynoteNMCT) // The format of the range's cells.
    @objc optional func setAlignment(_ alignment: KeynoteTAHT) // The horizontal alignment of content in the range's cells.
    @objc optional func setTextColor(_ textColor: NSColor!) // The text color of the range's cells.
    @objc optional func setTextWrap(_ textWrap: Bool) // Whether text should wrap in the range's cells.
    @objc optional func setBackgroundColor(_ backgroundColor: NSColor!) // The background color of the range's cells.
    @objc optional func setVerticalAlignment(_ verticalAlignment: KeynoteTAVT) // The vertical alignment of content in the range's cells.
}
extension SBObject: KeynoteRange {}

// MARK: KeynoteCell
@objc public protocol KeynoteCell: KeynoteRange {
    @objc optional var column: KeynoteColumn { get } // The cell's column.
    @objc optional var row: KeynoteRow { get } // The cell's row.
    @objc optional var value: Any { get } // The actual value in the cell, or missing value if the cell is empty.
    @objc optional var formattedValue: String { get } // The formatted value in the cell, or missing value if the cell is empty.
    @objc optional var formula: String { get } // The formula in the cell, as text, e.g. =SUM(40+2). If the cell does not contain a formula, returns missing value. To set the value of a cell to a formula as text, use the value property.
    @objc optional func setValue(_ value: Any!) // The actual value in the cell, or missing value if the cell is empty.
}
extension SBObject: KeynoteCell {}

// MARK: KeynoteRow
@objc public protocol KeynoteRow: KeynoteRange {
    @objc optional var address: Int { get } // The row's index in the table (e.g., the second row has address 2).
    @objc optional var height: Double { get } // The height of the row.
    @objc optional func setHeight(_ height: Double) // The height of the row.
}
extension SBObject: KeynoteRow {}

// MARK: KeynoteColumn
@objc public protocol KeynoteColumn: KeynoteRange {
    @objc optional var address: Int { get } // The column's index in the table (e.g., the second column has address 2).
    @objc optional var width: Double { get } // The width of the column.
    @objc optional func setWidth(_ width: Double) // The width of the column.
}
extension SBObject: KeynoteColumn {}

