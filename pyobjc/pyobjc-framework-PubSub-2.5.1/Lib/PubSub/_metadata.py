# This file is generated by objective.metadata
#
# Last update: Mon Sep 24 10:35:14 2012

import objc, sys

if sys.maxsize > 2 ** 32:
    def sel32or64(a, b): return b
else:
    def sel32or64(a, b): return a
if sys.byteorder == 'little':
    def littleOrBig(a, b): return a
else:
    def littleOrBig(a, b): return b

misc = {
}
constants = '''$PSEnclosureDownloadStateDidChangeNotification$PSErrorDomain$PSFeedAddedEntriesKey$PSFeedDidChangeEntryFlagsKey$PSFeedEntriesChangedNotification$PSFeedRefreshingNotification$PSFeedRemovedEntriesKey$PSFeedUpdatedEntriesKey$'''
enums = '''$PSAtomFormat@2$PSEnclosureDownloadDidFail@4$PSEnclosureDownloadDidFinish@3$PSEnclosureDownloadIsActive@2$PSEnclosureDownloadIsIdle@0$PSEnclosureDownloadIsQueued@1$PSEnclosureDownloadWasDeleted@5$PSFeedSettingsUnlimitedSize@0$PSInternalError@1$PSLinkToAlternate@7$PSLinkToAtom@2$PSLinkToAtomService@3$PSLinkToFOAF@4$PSLinkToOther@0$PSLinkToRSD@5$PSLinkToRSS@1$PSLinkToSelf@6$PSNotAFeedError@2$PSRSSFormat@1$PSUnknownFormat@0$'''
misc.update({'PSFeedSettingsIntervalNever': -1.0, 'PSFeedSettingsAllTypes': None, 'PSFeedSettingsIntervalDefault': 0.0})
r = objc.registerMetaDataForSelector
objc._updatingMetadata(True)
try:
    r(b'PSClient', b'addFeed:', {'retval': {'type': 'Z'}})
    r(b'PSClient', b'isPrivate', {'retval': {'type': 'Z'}})
    r(b'PSClient', b'removeFeed:', {'retval': {'type': 'Z'}})
    r(b'PSClient', b'setPrivate:', {'arguments': {2: {'type': 'Z'}}})
    r(b'PSEnclosure', b'download:', {'retval': {'type': 'Z'}, 'arguments': {2: {'type_modifier': b'o'}}})
    r(b'PSEntry', b'isCurrent', {'retval': {'type': 'Z'}})
    r(b'PSEntry', b'isFlagged', {'retval': {'type': 'Z'}})
    r(b'PSEntry', b'isRead', {'retval': {'type': 'Z'}})
    r(b'PSEntry', b'setCurrent:', {'arguments': {2: {'type': 'Z'}}})
    r(b'PSEntry', b'setFlagged:', {'arguments': {2: {'type': 'Z'}}})
    r(b'PSEntry', b'setRead:', {'arguments': {2: {'type': 'Z'}}})
    r(b'PSFeed', b'XMLRepresentationWithEntries:', {'arguments': {2: {'type': 'Z'}}})
    r(b'PSFeed', b'isRefreshing', {'retval': {'type': 'Z'}})
    r(b'PSFeed', b'refresh:', {'retval': {'type': 'Z'}, 'arguments': {2: {'type_modifier': b'o'}}})
    r(b'PSFeedSettings', b'downloadsEnclosures', {'retval': {'type': 'Z'}})
    r(b'PSFeedSettings', b'refreshesInBackground', {'retval': {'type': 'Z'}})
    r(b'PSFeedSettings', b'setDownloadsEnclosures:', {'arguments': {2: {'type': 'Z'}}})
    r(b'PSFeedSettings', b'setRefreshesInBackground:', {'arguments': {2: {'type': 'Z'}}})
finally:
    objc._updatingMetadata(False)
r = objc.registerMetaDataForSelector
objc._updatingMetadata(True)
try:
    r(b'NSObject', b'enclosure:downloadStateDidChange:', {'retval': {'type': b'v'}, 'arguments': {2: {'type': b'@'}, 3: {'type': b'i'}}})
    r(b'NSObject', b'feed:didAddEntries:', {'retval': {'type': b'v'}, 'arguments': {2: {'type': b'@'}, 3: {'type': b'@'}}})
    r(b'NSObject', b'feed:didChangeFlagsInEntries:', {'retval': {'type': b'v'}, 'arguments': {2: {'type': b'@'}, 3: {'type': b'@'}}})
    r(b'NSObject', b'feed:didRemoveEntriesWithIdentifiers:', {'retval': {'type': b'v'}, 'arguments': {2: {'type': b'@'}, 3: {'type': b'@'}}})
    r(b'NSObject', b'feed:didUpdateEntries:', {'retval': {'type': b'v'}, 'arguments': {2: {'type': b'@'}, 3: {'type': b'@'}}})
    r(b'NSObject', b'feedDidBeginRefresh:', {'retval': {'type': b'v'}, 'arguments': {2: {'type': b'@'}}})
    r(b'NSObject', b'feedDidEndRefresh:', {'retval': {'type': b'v'}, 'arguments': {2: {'type': b'@'}}})
finally:
    objc._updatingMetadata(False)
protocols={'PSClientDelegate': objc.informal_protocol('PSClientDelegate', [objc.selector(None, b'feed:didUpdateEntries:', b'v@:@@', isRequired=False), objc.selector(None, b'feedDidBeginRefresh:', b'v@:@', isRequired=False), objc.selector(None, b'enclosure:downloadStateDidChange:', b'v@:@i', isRequired=False), objc.selector(None, b'feed:didRemoveEntriesWithIdentifiers:', b'v@:@@', isRequired=False), objc.selector(None, b'feedDidEndRefresh:', b'v@:@', isRequired=False), objc.selector(None, b'feed:didAddEntries:', b'v@:@@', isRequired=False), objc.selector(None, b'feed:didChangeFlagsInEntries:', b'v@:@@', isRequired=False)])}
expressions = {}

# END OF FILE