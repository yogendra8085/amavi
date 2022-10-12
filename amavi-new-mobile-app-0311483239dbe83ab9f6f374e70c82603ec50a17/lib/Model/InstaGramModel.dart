class InstagramModel {
  List<List>? seoCategoryInfos;
  String? loggingPageId;
  bool? showSuggestedProfiles;
  bool? showFollowDialog;
  Graphql? graphql;
  Null? toastContentOnLoad;
  bool? showViewShop;
  Null? profilePicEditSyncProps;
  bool? alwaysShowMessageButtonToProAccount;

  InstagramModel(
      {this.seoCategoryInfos,
      this.loggingPageId,
      this.showSuggestedProfiles,
      this.showFollowDialog,
      this.graphql,
      this.toastContentOnLoad,
      this.showViewShop,
      this.profilePicEditSyncProps,
      this.alwaysShowMessageButtonToProAccount});

  InstagramModel.fromJson(Map<String, dynamic> json) {
    if (json['seo_category_infos'] != null) {
      seoCategoryInfos = <List>[];
//      json['seo_category_infos'].forEach((v) { seoCategoryInfos.add(new List.fromJson(v)); });
    }
    loggingPageId = json['logging_page_id'];
    showSuggestedProfiles = json['show_suggested_profiles'];
    showFollowDialog = json['show_follow_dialog'];
    graphql =
        json['graphql'] != null ? new Graphql.fromJson(json['graphql']) : null;
    toastContentOnLoad = json['toast_content_on_load'];
    showViewShop = json['show_view_shop'];
    //profilePicEditSyncProps = json['profile_pic_edit_sync_props'];
    alwaysShowMessageButtonToProAccount =
        json['always_show_message_button_to_pro_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seoCategoryInfos != null) {
//      data['seo_category_infos'] = this.seoCategoryInfos.map((v) => v.toJson()).toList();
    }
    data['logging_page_id'] = this.loggingPageId;
    data['show_suggested_profiles'] = this.showSuggestedProfiles;
    data['show_follow_dialog'] = this.showFollowDialog;
    if (this.graphql != null) {
      data['graphql'] = this.graphql?.toJson();
    }
    data['toast_content_on_load'] = this.toastContentOnLoad;
    data['show_view_shop'] = this.showViewShop;
    data['profile_pic_edit_sync_props'] = this.profilePicEditSyncProps;
    data['always_show_message_button_to_pro_account'] =
        this.alwaysShowMessageButtonToProAccount;
    return data;
  }
}

class SeoCategoryInfos {
  // SeoCategoryInfos({});

  SeoCategoryInfos.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Graphql {
  User? user;

  Graphql({this.user});

  Graphql.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    return data;
  }
}

class User {
  String? biography;
  bool? blockedByViewer;
  Null? restrictedByViewer;
  bool? countryBlock;
  String? externalUrl;
  String? externalUrlLinkshimmed;
  EdgeFollowedBy? edgeFollowedBy;
  String? fbid;
  bool? followedByViewer;
  EdgeFollowedBy? edgeFollow;
  bool? followsViewer;
  String? fullName;
  bool? hasArEffects;
  bool? hasClips;
  bool? hasGuides;
  bool? hasChannel;
  bool? hasBlockedViewer;
  int? highlightReelCount;
  bool? hasRequestedViewer;
  bool? hideLikeAndViewCounts;
  String? id;
  bool? isBusinessAccount;
  bool? isProfessionalAccount;
  bool? isJoinedRecently;
  Null? businessAddressJson;
  String? businessContactMethod;
  Null? businessEmail;
  Null? businessPhoneNumber;
  String? businessCategoryName;
  Null? overallCategoryName;
  String? categoryEnum;
  String? categoryName;
  bool? isPrivate;
  bool? isVerified;
  EdgeMutualFollowedBy? edgeMutualFollowedBy;
  String? profilePicUrl;
  String? profilePicUrlHd;
  bool? requestedByViewer;
  bool? shouldShowCategory;
  bool? shouldShowPublicContacts;
  String? username;
  Null? connectedFbPage;
  EdgeFelixVideoTimeline? edgeFelixVideoTimeline;
  EdgeOwnerToTimelineMedia? edgeOwnerToTimelineMedia;
  EdgeFelixVideoTimeline? edgeSavedMedia;
  EdgeFelixVideoTimeline? edgeMediaCollections;
  EdgeMediaToCaption? edgeRelatedProfiles;

  User(
      {this.biography,
      this.blockedByViewer,
      this.restrictedByViewer,
      this.countryBlock,
      this.externalUrl,
      this.externalUrlLinkshimmed,
      this.edgeFollowedBy,
      this.fbid,
      this.followedByViewer,
      this.edgeFollow,
      this.followsViewer,
      this.fullName,
      this.hasArEffects,
      this.hasClips,
      this.hasGuides,
      this.hasChannel,
      this.hasBlockedViewer,
      this.highlightReelCount,
      this.hasRequestedViewer,
      this.hideLikeAndViewCounts,
      this.id,
      this.isBusinessAccount,
      this.isProfessionalAccount,
      this.isJoinedRecently,
      this.businessAddressJson,
      this.businessContactMethod,
      this.businessEmail,
      this.businessPhoneNumber,
      this.businessCategoryName,
      this.overallCategoryName,
      this.categoryEnum,
      this.categoryName,
      this.isPrivate,
      this.isVerified,
      this.edgeMutualFollowedBy,
      this.profilePicUrl,
      this.profilePicUrlHd,
      this.requestedByViewer,
      this.shouldShowCategory,
      this.shouldShowPublicContacts,
      this.username,
      this.connectedFbPage,
      this.edgeFelixVideoTimeline,
      this.edgeOwnerToTimelineMedia,
      this.edgeSavedMedia,
      this.edgeMediaCollections,
      this.edgeRelatedProfiles});

  User.fromJson(Map<String, dynamic> json) {
    biography = json['biography'];
    blockedByViewer = json['blocked_by_viewer'];
    restrictedByViewer = json['restricted_by_viewer'];
    countryBlock = json['country_block'];
    externalUrl = json['external_url'];
    externalUrlLinkshimmed = json['external_url_linkshimmed'];
    edgeFollowedBy = json['edge_followed_by'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_followed_by'])
        : null;
    fbid = json['fbid'];
    followedByViewer = json['followed_by_viewer'];
    edgeFollow = json['edge_follow'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_follow'])
        : null;
    followsViewer = json['follows_viewer'];
    fullName = json['full_name'];
    hasArEffects = json['has_ar_effects'];
    hasClips = json['has_clips'];
    hasGuides = json['has_guides'];
    hasChannel = json['has_channel'];
    hasBlockedViewer = json['has_blocked_viewer'];
    highlightReelCount = json['highlight_reel_count'];
    hasRequestedViewer = json['has_requested_viewer'];
    hideLikeAndViewCounts = json['hide_like_and_view_counts'];
    id = json['id'];
    isBusinessAccount = json['is_business_account'];
    isProfessionalAccount = json['is_professional_account'];
    isJoinedRecently = json['is_joined_recently'];
    businessAddressJson = json['business_address_json'];
    businessContactMethod = json['business_contact_method'];
    businessEmail = json['business_email'];
    businessPhoneNumber = json['business_phone_number'];
    businessCategoryName = json['business_category_name'];
    overallCategoryName = json['overall_category_name'];
    categoryEnum = json['category_enum'];
    categoryName = json['category_name'];
    isPrivate = json['is_private'];
    isVerified = json['is_verified'];
    edgeMutualFollowedBy = json['edge_mutual_followed_by'] != null
        ? new EdgeMutualFollowedBy.fromJson(json['edge_mutual_followed_by'])
        : null;
    profilePicUrl = json['profile_pic_url'];
    profilePicUrlHd = json['profile_pic_url_hd'];
    requestedByViewer = json['requested_by_viewer'];
    shouldShowCategory = json['should_show_category'];
    shouldShowPublicContacts = json['should_show_public_contacts'];
    username = json['username'];
    connectedFbPage = json['connected_fb_page'];
    edgeFelixVideoTimeline = json['edge_felix_video_timeline'] != null
        ? new EdgeFelixVideoTimeline.fromJson(json['edge_felix_video_timeline'])
        : null;
    edgeOwnerToTimelineMedia = json['edge_owner_to_timeline_media'] != null
        ? new EdgeOwnerToTimelineMedia.fromJson(
            json['edge_owner_to_timeline_media'])
        : null;
    edgeSavedMedia = json['edge_saved_media'] != null
        ? new EdgeFelixVideoTimeline.fromJson(json['edge_saved_media'])
        : null;
    edgeMediaCollections = json['edge_media_collections'] != null
        ? new EdgeFelixVideoTimeline.fromJson(json['edge_media_collections'])
        : null;
    edgeRelatedProfiles = json['edge_related_profiles'] != null
        ? new EdgeMediaToCaption.fromJson(json['edge_related_profiles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['biography'] = this.biography;
    data['blocked_by_viewer'] = this.blockedByViewer;
    data['restricted_by_viewer'] = this.restrictedByViewer;
    data['country_block'] = this.countryBlock;
    data['external_url'] = this.externalUrl;
    data['external_url_linkshimmed'] = this.externalUrlLinkshimmed;
    if (this.edgeFollowedBy != null) {
      data['edge_followed_by'] = this.edgeFollowedBy?.toJson();
    }
    data['fbid'] = this.fbid;
    data['followed_by_viewer'] = this.followedByViewer;
    if (this.edgeFollow != null) {
      data['edge_follow'] = this.edgeFollow?.toJson();
    }
    data['follows_viewer'] = this.followsViewer;
    data['full_name'] = this.fullName;
    data['has_ar_effects'] = this.hasArEffects;
    data['has_clips'] = this.hasClips;
    data['has_guides'] = this.hasGuides;
    data['has_channel'] = this.hasChannel;
    data['has_blocked_viewer'] = this.hasBlockedViewer;
    data['highlight_reel_count'] = this.highlightReelCount;
    data['has_requested_viewer'] = this.hasRequestedViewer;
    data['hide_like_and_view_counts'] = this.hideLikeAndViewCounts;
    data['id'] = this.id;
    data['is_business_account'] = this.isBusinessAccount;
    data['is_professional_account'] = this.isProfessionalAccount;
    data['is_joined_recently'] = this.isJoinedRecently;
    data['business_address_json'] = this.businessAddressJson;
    data['business_contact_method'] = this.businessContactMethod;
    data['business_email'] = this.businessEmail;
    data['business_phone_number'] = this.businessPhoneNumber;
    data['business_category_name'] = this.businessCategoryName;
    data['overall_category_name'] = this.overallCategoryName;
    data['category_enum'] = this.categoryEnum;
    data['category_name'] = this.categoryName;
    data['is_private'] = this.isPrivate;
    data['is_verified'] = this.isVerified;
    if (this.edgeMutualFollowedBy != null) {
      data['edge_mutual_followed_by'] = this.edgeMutualFollowedBy?.toJson();
    }
    data['profile_pic_url'] = this.profilePicUrl;
    data['profile_pic_url_hd'] = this.profilePicUrlHd;
    data['requested_by_viewer'] = this.requestedByViewer;
    data['should_show_category'] = this.shouldShowCategory;
    data['should_show_public_contacts'] = this.shouldShowPublicContacts;
    data['username'] = this.username;
    data['connected_fb_page'] = this.connectedFbPage;
    if (this.edgeFelixVideoTimeline != null) {
      data['edge_felix_video_timeline'] = this.edgeFelixVideoTimeline?.toJson();
    }
    if (this.edgeOwnerToTimelineMedia != null) {
      data['edge_owner_to_timeline_media'] =
          this.edgeOwnerToTimelineMedia?.toJson();
    }
    if (this.edgeSavedMedia != null) {
      data['edge_saved_media'] = this.edgeSavedMedia?.toJson();
    }
    if (this.edgeMediaCollections != null) {
      data['edge_media_collections'] = this.edgeMediaCollections?.toJson();
    }
    if (this.edgeRelatedProfiles != null) {
      data['edge_related_profiles'] = this.edgeRelatedProfiles?.toJson();
    }
    return data;
  }
}

class EdgeFollowedBy {
  int? count;

  EdgeFollowedBy({this.count});

  EdgeFollowedBy.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class EdgeMutualFollowedBy {
  int? count;
  List<Null>? edges;

  EdgeMutualFollowedBy({this.count, this.edges});

  EdgeMutualFollowedBy.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['edges'] != null) {
      edges = <Null>[];
//      json['edges'].forEach((v) { edges.add(new Null.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.edges != null) {
      // data['edges'] = this.edges.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EdgeFelixVideoTimeline {
  int? count;
  PageInfo? pageInfo;
  List<Null>? edges;

  EdgeFelixVideoTimeline({this.count, this.pageInfo, this.edges});

  EdgeFelixVideoTimeline.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
    if (json['edges'] != null) {
      edges = <Null>[];
      //     json['edges'].forEach((v) { edges.add(new Null.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo?.toJson();
    }
    if (this.edges != null) {
      //   data['edges'] = this.edges.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  bool? hasNextPage;
  Null? endCursor;

  PageInfo({this.hasNextPage, this.endCursor});

  PageInfo.fromJson(Map<String, dynamic> json) {
    hasNextPage = json['has_next_page'];
    //endCursor = json['end_cursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_next_page'] = this.hasNextPage;
    data['end_cursor'] = this.endCursor;
    return data;
  }
}

class EdgeOwnerToTimelineMedia {
  int? count;
  PageInfo? pageInfo;
  List<Edges>? edges;

  EdgeOwnerToTimelineMedia({this.count, this.pageInfo, this.edges});

  EdgeOwnerToTimelineMedia.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
    if (json['edges'] != null) {
      edges = <Edges>[];
      json['edges'].forEach((v) {
        edges?.add(new Edges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo?.toJson();
    }
    if (this.edges != null) {
      data['edges'] = this.edges?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo1 {
  bool? hasNextPage;
  String? endCursor;

  PageInfo1({this.hasNextPage, this.endCursor});

  PageInfo1.fromJson(Map<String, dynamic> json) {
    hasNextPage = json['has_next_page'];
    endCursor = json['end_cursor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_next_page'] = this.hasNextPage;
    data['end_cursor'] = this.endCursor;
    return data;
  }
}

class Edges {
  Node? node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node?.toJson();
    }
    return data;
  }
}

class Edges2Caption {
  Node1? node;

  Edges2Caption({this.node});

  Edges2Caption.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node1.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node?.toJson();
    }
    return data;
  }
}

class Node {
  String? sTypename;
  String? id;
  String? shortcode;
  Dimensions? dimensions;
  String? displayUrl;
  EdgeMediaToTaggedUser? edgeMediaToTaggedUser;
  Null? factCheckOverallRating;
  Null? factCheckInformation;
  Null? gatingInfo;
  SharingFrictionInfo? sharingFrictionInfo;
  Null? mediaOverlayInfo;
  String? mediaPreview;
  Owner? owner;
  bool? isVideo;
  bool? hasUpcomingEvent;
  String? accessibilityCaption;
  EdgeMediaToCaption? edgeMediaToCaption;
  EdgeFollowedBy? edgeMediaToComment;
  bool? commentsDisabled;
  int? takenAtTimestamp;
  EdgeFollowedBy? edgeLikedBy;
  EdgeFollowedBy? edgeMediaPreviewLike;
  Null? location;
  String? thumbnailSrc;
  List<ThumbnailResources>? thumbnailResources;

  Node(
      {this.sTypename,
      this.id,
      this.shortcode,
      this.dimensions,
      this.displayUrl,
      this.edgeMediaToTaggedUser,
      this.factCheckOverallRating,
      this.factCheckInformation,
      this.gatingInfo,
      this.sharingFrictionInfo,
      this.mediaOverlayInfo,
      this.mediaPreview,
      this.owner,
      this.isVideo,
      this.hasUpcomingEvent,
      this.accessibilityCaption,
      this.edgeMediaToCaption,
      this.edgeMediaToComment,
      this.commentsDisabled,
      this.takenAtTimestamp,
      this.edgeLikedBy,
      this.edgeMediaPreviewLike,
      this.location,
      this.thumbnailSrc,
      this.thumbnailResources});

  Node.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    shortcode = json['shortcode'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    displayUrl = json['display_url'];
    edgeMediaToTaggedUser = json['edge_media_to_tagged_user'] != null
        ? new EdgeMediaToTaggedUser.fromJson(json['edge_media_to_tagged_user'])
        : null;
    factCheckOverallRating = json['fact_check_overall_rating'];
    factCheckInformation = json['fact_check_information'];
    gatingInfo = json['gating_info'];
    sharingFrictionInfo = json['sharing_friction_info'] != null
        ? new SharingFrictionInfo.fromJson(json['sharing_friction_info'])
        : null;
    mediaOverlayInfo = json['media_overlay_info'];
    mediaPreview = json['media_preview'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    isVideo = json['is_video'];
    hasUpcomingEvent = json['has_upcoming_event'];
    accessibilityCaption = json['accessibility_caption'];
    edgeMediaToCaption = json['edge_media_to_caption'] != null
        ? new EdgeMediaToCaption.fromJson(json['edge_media_to_caption'])
        : null;
    edgeMediaToComment = json['edge_media_to_comment'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_media_to_comment'])
        : null;
    commentsDisabled = json['comments_disabled'];
    takenAtTimestamp = json['taken_at_timestamp'];
    edgeLikedBy = json['edge_liked_by'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_liked_by'])
        : null;
    edgeMediaPreviewLike = json['edge_media_preview_like'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_media_preview_like'])
        : null;
    location = json['location'];
    thumbnailSrc = json['thumbnail_src'];
    if (json['thumbnail_resources'] != null) {
      thumbnailResources = <ThumbnailResources>[];
      json['thumbnail_resources'].forEach((v) {
        thumbnailResources?.add(new ThumbnailResources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['id'] = this.id;
    data['shortcode'] = this.shortcode;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions?.toJson();
    }
    data['display_url'] = this.displayUrl;
    if (this.edgeMediaToTaggedUser != null) {
      data['edge_media_to_tagged_user'] = this.edgeMediaToTaggedUser?.toJson();
    }
    data['fact_check_overall_rating'] = this.factCheckOverallRating;
    data['fact_check_information'] = this.factCheckInformation;
    data['gating_info'] = this.gatingInfo;
    if (this.sharingFrictionInfo != null) {
      data['sharing_friction_info'] = this.sharingFrictionInfo?.toJson();
    }
    data['media_overlay_info'] = this.mediaOverlayInfo;
    data['media_preview'] = this.mediaPreview;
    if (this.owner != null) {
      data['owner'] = this.owner?.toJson();
    }
    data['is_video'] = this.isVideo;
    data['has_upcoming_event'] = this.hasUpcomingEvent;
    data['accessibility_caption'] = this.accessibilityCaption;
    if (this.edgeMediaToCaption != null) {
      data['edge_media_to_caption'] = this.edgeMediaToCaption?.toJson();
    }
    if (this.edgeMediaToComment != null) {
      data['edge_media_to_comment'] = this.edgeMediaToComment?.toJson();
    }
    data['comments_disabled'] = this.commentsDisabled;
    data['taken_at_timestamp'] = this.takenAtTimestamp;
    if (this.edgeLikedBy != null) {
      data['edge_liked_by'] = this.edgeLikedBy?.toJson();
    }
    if (this.edgeMediaPreviewLike != null) {
      data['edge_media_preview_like'] = this.edgeMediaPreviewLike?.toJson();
    }
    data['location'] = this.location;
    data['thumbnail_src'] = this.thumbnailSrc;
    if (this.thumbnailResources != null) {
      data['thumbnail_resources'] =
          this.thumbnailResources?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dimensions {
  int? height;
  int? width;

  Dimensions({this.height, this.width});

  Dimensions.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['width'] = this.width;
    return data;
  }
}

class EdgeMediaToTaggedUser {
  List<Null>? edges;

  EdgeMediaToTaggedUser({this.edges});

  EdgeMediaToTaggedUser.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <Null>[];
      // json['edges'].forEach((v) { edges.add(new Null.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      // data['edges'] = this.edges.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SharingFrictionInfo {
  bool? shouldHaveSharingFriction;
  Null? bloksAppUrl;

  SharingFrictionInfo({this.shouldHaveSharingFriction, this.bloksAppUrl});

  SharingFrictionInfo.fromJson(Map<String, dynamic> json) {
    shouldHaveSharingFriction = json['should_have_sharing_friction'];
    bloksAppUrl = json['bloks_app_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['should_have_sharing_friction'] = this.shouldHaveSharingFriction;
    data['bloks_app_url'] = this.bloksAppUrl;
    return data;
  }
}

class Owner {
  String? id;
  String? username;

  Owner({this.id, this.username});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

class EdgeMediaToCaption {
  List<Edges2Caption>? edges;

  EdgeMediaToCaption({this.edges});

  EdgeMediaToCaption.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <Edges2Caption>[];
      json['edges'].forEach((v) {
        edges?.add(new Edges2Caption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Node1 {
  String? text;

  Node1({this.text});

  Node1.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class ThumbnailResources {
  String? src;
  int? configWidth;
  int? configHeight;

  ThumbnailResources({this.src, this.configWidth, this.configHeight});

  ThumbnailResources.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    configWidth = json['config_width'];
    configHeight = json['config_height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['config_width'] = this.configWidth;
    data['config_height'] = this.configHeight;
    return data;
  }
}

class Node2 {
  String? id;
  String? fullName;
  bool? isPrivate;
  bool? isVerified;
  String? profilePicUrl;
  String? username;

  Node2(
      {this.id,
      this.fullName,
      this.isPrivate,
      this.isVerified,
      this.profilePicUrl,
      this.username});

  Node2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    isPrivate = json['is_private'];
    isVerified = json['is_verified'];
    profilePicUrl = json['profile_pic_url'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['is_private'] = this.isPrivate;
    data['is_verified'] = this.isVerified;
    data['profile_pic_url'] = this.profilePicUrl;
    data['username'] = this.username;
    return data;
  }
}

class User2 {
  String? biography;
  bool? blockedByViewer;
  Null? restrictedByViewer;
  bool? countryBlock;
  String? externalUrl;
  String? externalUrlLinkshimmed;
  EdgeFollowedBy? edgeFollowedBy;
  String? fbid;
  bool? followedByViewer;
  EdgeFollowedBy? edgeFollow;
  bool? followsViewer;
  String? fullName;
  bool? hasArEffects;
  bool? hasClips;
  bool? hasGuides;
  bool? hasChannel;
  bool? hasBlockedViewer;
  int? highlightReelCount;
  bool? hasRequestedViewer;
  bool? hideLikeAndViewCounts;
  String? id;
  bool? isBusinessAccount;
  bool? isProfessionalAccount;
  bool? isJoinedRecently;
  Null? businessAddressJson;
  String? businessContactMethod;
  Null? businessEmail;
  Null? businessPhoneNumber;
  String? businessCategoryName;
  Null? overallCategoryName;
  String? categoryEnum;
  String? categoryName;
  bool? isPrivate;
  bool? isVerified;
  EdgeMutualFollowedBy? edgeMutualFollowedBy;
  String? profilePicUrl;
  String? profilePicUrlHd;
  bool? requestedByViewer;
  bool? shouldShowCategory;
  bool? shouldShowPublicContacts;
  String? username;
  Null? connectedFbPage;
  EdgeFelixVideoTimeline? edgeFelixVideoTimeline;
  EdgeOwnerToTimelineMedia? edgeOwnerToTimelineMedia;
  EdgeFelixVideoTimeline? edgeSavedMedia;
  EdgeFelixVideoTimeline? edgeMediaCollections;
  EdgeMediaToCaption? edgeRelatedProfiles;

  User2(
      {this.biography,
      this.blockedByViewer,
      this.restrictedByViewer,
      this.countryBlock,
      this.externalUrl,
      this.externalUrlLinkshimmed,
      this.edgeFollowedBy,
      this.fbid,
      this.followedByViewer,
      this.edgeFollow,
      this.followsViewer,
      this.fullName,
      this.hasArEffects,
      this.hasClips,
      this.hasGuides,
      this.hasChannel,
      this.hasBlockedViewer,
      this.highlightReelCount,
      this.hasRequestedViewer,
      this.hideLikeAndViewCounts,
      this.id,
      this.isBusinessAccount,
      this.isProfessionalAccount,
      this.isJoinedRecently,
      this.businessAddressJson,
      this.businessContactMethod,
      this.businessEmail,
      this.businessPhoneNumber,
      this.businessCategoryName,
      this.overallCategoryName,
      this.categoryEnum,
      this.categoryName,
      this.isPrivate,
      this.isVerified,
      this.edgeMutualFollowedBy,
      this.profilePicUrl,
      this.profilePicUrlHd,
      this.requestedByViewer,
      this.shouldShowCategory,
      this.shouldShowPublicContacts,
      this.username,
      this.connectedFbPage,
      this.edgeFelixVideoTimeline,
      this.edgeOwnerToTimelineMedia,
      this.edgeSavedMedia,
      this.edgeMediaCollections,
      this.edgeRelatedProfiles});

  User2.fromJson(Map<String, dynamic> json) {
    biography = json['biography'];
    blockedByViewer = json['blocked_by_viewer'];
    restrictedByViewer = json['restricted_by_viewer'];
    countryBlock = json['country_block'];
    externalUrl = json['external_url'];
    externalUrlLinkshimmed = json['external_url_linkshimmed'];
    edgeFollowedBy = json['edge_followed_by'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_followed_by'])
        : null;
    fbid = json['fbid'];
    followedByViewer = json['followed_by_viewer'];
    edgeFollow = json['edge_follow'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_follow'])
        : null;
    followsViewer = json['follows_viewer'];
    fullName = json['full_name'];
    hasArEffects = json['has_ar_effects'];
    hasClips = json['has_clips'];
    hasGuides = json['has_guides'];
    hasChannel = json['has_channel'];
    hasBlockedViewer = json['has_blocked_viewer'];
    highlightReelCount = json['highlight_reel_count'];
    hasRequestedViewer = json['has_requested_viewer'];
    hideLikeAndViewCounts = json['hide_like_and_view_counts'];
    id = json['id'];
    isBusinessAccount = json['is_business_account'];
    isProfessionalAccount = json['is_professional_account'];
    isJoinedRecently = json['is_joined_recently'];
    businessAddressJson = json['business_address_json'];
    businessContactMethod = json['business_contact_method'];
    businessEmail = json['business_email'];
    businessPhoneNumber = json['business_phone_number'];
    businessCategoryName = json['business_category_name'];
    overallCategoryName = json['overall_category_name'];
    categoryEnum = json['category_enum'];
    categoryName = json['category_name'];
    isPrivate = json['is_private'];
    isVerified = json['is_verified'];
    edgeMutualFollowedBy = json['edge_mutual_followed_by'] != null
        ? new EdgeMutualFollowedBy.fromJson(json['edge_mutual_followed_by'])
        : null;
    profilePicUrl = json['profile_pic_url'];
    profilePicUrlHd = json['profile_pic_url_hd'];
    requestedByViewer = json['requested_by_viewer'];
    shouldShowCategory = json['should_show_category'];
    shouldShowPublicContacts = json['should_show_public_contacts'];
    username = json['username'];
    connectedFbPage = json['connected_fb_page'];
    edgeFelixVideoTimeline = json['edge_felix_video_timeline'] != null
        ? new EdgeFelixVideoTimeline.fromJson(json['edge_felix_video_timeline'])
        : null;
    edgeOwnerToTimelineMedia = json['edge_owner_to_timeline_media'] != null
        ? new EdgeOwnerToTimelineMedia.fromJson(
            json['edge_owner_to_timeline_media'])
        : null;
    edgeSavedMedia = json['edge_saved_media'] != null
        ? new EdgeFelixVideoTimeline.fromJson(json['edge_saved_media'])
        : null;
    edgeMediaCollections = json['edge_media_collections'] != null
        ? new EdgeFelixVideoTimeline.fromJson(json['edge_media_collections'])
        : null;
    edgeRelatedProfiles = json['edge_related_profiles'] != null
        ? new EdgeMediaToCaption.fromJson(json['edge_related_profiles'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['biography'] = this.biography;
    data['blocked_by_viewer'] = this.blockedByViewer;
    data['restricted_by_viewer'] = this.restrictedByViewer;
    data['country_block'] = this.countryBlock;
    data['external_url'] = this.externalUrl;
    data['external_url_linkshimmed'] = this.externalUrlLinkshimmed;
    if (this.edgeFollowedBy != null) {
      data['edge_followed_by'] = this.edgeFollowedBy?.toJson();
    }
    data['fbid'] = this.fbid;
    data['followed_by_viewer'] = this.followedByViewer;
    if (this.edgeFollow != null) {
      data['edge_follow'] = this.edgeFollow?.toJson();
    }
    data['follows_viewer'] = this.followsViewer;
    data['full_name'] = this.fullName;
    data['has_ar_effects'] = this.hasArEffects;
    data['has_clips'] = this.hasClips;
    data['has_guides'] = this.hasGuides;
    data['has_channel'] = this.hasChannel;
    data['has_blocked_viewer'] = this.hasBlockedViewer;
    data['highlight_reel_count'] = this.highlightReelCount;
    data['has_requested_viewer'] = this.hasRequestedViewer;
    data['hide_like_and_view_counts'] = this.hideLikeAndViewCounts;
    data['id'] = this.id;
    data['is_business_account'] = this.isBusinessAccount;
    data['is_professional_account'] = this.isProfessionalAccount;
    data['is_joined_recently'] = this.isJoinedRecently;
    data['business_address_json'] = this.businessAddressJson;
    data['business_contact_method'] = this.businessContactMethod;
    data['business_email'] = this.businessEmail;
    data['business_phone_number'] = this.businessPhoneNumber;
    data['business_category_name'] = this.businessCategoryName;
    data['overall_category_name'] = this.overallCategoryName;
    data['category_enum'] = this.categoryEnum;
    data['category_name'] = this.categoryName;
    data['is_private'] = this.isPrivate;
    data['is_verified'] = this.isVerified;
    if (this.edgeMutualFollowedBy != null) {
      data['edge_mutual_followed_by'] = this.edgeMutualFollowedBy?.toJson();
    }
    data['profile_pic_url'] = this.profilePicUrl;
    data['profile_pic_url_hd'] = this.profilePicUrlHd;
    data['requested_by_viewer'] = this.requestedByViewer;
    data['should_show_category'] = this.shouldShowCategory;
    data['should_show_public_contacts'] = this.shouldShowPublicContacts;
    data['username'] = this.username;
    data['connected_fb_page'] = this.connectedFbPage;
    if (this.edgeFelixVideoTimeline != null) {
      data['edge_felix_video_timeline'] = this.edgeFelixVideoTimeline?.toJson();
    }
    if (this.edgeOwnerToTimelineMedia != null) {
      data['edge_owner_to_timeline_media'] =
          this.edgeOwnerToTimelineMedia?.toJson();
    }
    if (this.edgeSavedMedia != null) {
      data['edge_saved_media'] = this.edgeSavedMedia?.toJson();
    }
    if (this.edgeMediaCollections != null) {
      data['edge_media_collections'] = this.edgeMediaCollections?.toJson();
    }
    if (this.edgeRelatedProfiles != null) {
      data['edge_related_profiles'] = this.edgeRelatedProfiles?.toJson();
    }
    return data;
  }
}

class Node3 {
  String? sTypename;
  String? id;
  String? shortcode;
  Dimensions? dimensions;
  String? displayUrl;
  EdgeMediaToTaggedUser? edgeMediaToTaggedUser;
  Null? factCheckOverallRating;
  Null? factCheckInformation;
  Null? gatingInfo;
  SharingFrictionInfo? sharingFrictionInfo;
  Null? mediaOverlayInfo;
  String? mediaPreview;
  Owner? owner;
  bool? isVideo;
  bool? hasUpcomingEvent;
  String? accessibilityCaption;
  EdgeMediaToCaption? edgeMediaToCaption;
  EdgeFollowedBy? edgeMediaToComment;
  bool? commentsDisabled;
  int? takenAtTimestamp;
  EdgeFollowedBy? edgeLikedBy;
  EdgeFollowedBy? edgeMediaPreviewLike;
  Null? location;
  String? thumbnailSrc;
  List<ThumbnailResources>? thumbnailResources;

  Node3(
      {this.sTypename,
      this.id,
      this.shortcode,
      this.dimensions,
      this.displayUrl,
      this.edgeMediaToTaggedUser,
      this.factCheckOverallRating,
      this.factCheckInformation,
      this.gatingInfo,
      this.sharingFrictionInfo,
      this.mediaOverlayInfo,
      this.mediaPreview,
      this.owner,
      this.isVideo,
      this.hasUpcomingEvent,
      this.accessibilityCaption,
      this.edgeMediaToCaption,
      this.edgeMediaToComment,
      this.commentsDisabled,
      this.takenAtTimestamp,
      this.edgeLikedBy,
      this.edgeMediaPreviewLike,
      this.location,
      this.thumbnailSrc,
      this.thumbnailResources});

  Node3.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    id = json['id'];
    shortcode = json['shortcode'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    displayUrl = json['display_url'];
    edgeMediaToTaggedUser = json['edge_media_to_tagged_user'] != null
        ? new EdgeMediaToTaggedUser.fromJson(json['edge_media_to_tagged_user'])
        : null;
    factCheckOverallRating = json['fact_check_overall_rating'];
    factCheckInformation = json['fact_check_information'];
    gatingInfo = json['gating_info'];
    sharingFrictionInfo = json['sharing_friction_info'] != null
        ? new SharingFrictionInfo.fromJson(json['sharing_friction_info'])
        : null;
    mediaOverlayInfo = json['media_overlay_info'];
    mediaPreview = json['media_preview'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    isVideo = json['is_video'];
    hasUpcomingEvent = json['has_upcoming_event'];
    accessibilityCaption = json['accessibility_caption'];
    edgeMediaToCaption = json['edge_media_to_caption'] != null
        ? new EdgeMediaToCaption.fromJson(json['edge_media_to_caption'])
        : null;
    edgeMediaToComment = json['edge_media_to_comment'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_media_to_comment'])
        : null;
    commentsDisabled = json['comments_disabled'];
    takenAtTimestamp = json['taken_at_timestamp'];
    edgeLikedBy = json['edge_liked_by'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_liked_by'])
        : null;
    edgeMediaPreviewLike = json['edge_media_preview_like'] != null
        ? new EdgeFollowedBy.fromJson(json['edge_media_preview_like'])
        : null;
    location = json['location'];
    thumbnailSrc = json['thumbnail_src'];
    if (json['thumbnail_resources'] != null) {
      thumbnailResources = <ThumbnailResources>[];
      json['thumbnail_resources'].forEach((v) {
        thumbnailResources?.add(new ThumbnailResources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['id'] = this.id;
    data['shortcode'] = this.shortcode;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions?.toJson();
    }
    data['display_url'] = this.displayUrl;
    if (this.edgeMediaToTaggedUser != null) {
      data['edge_media_to_tagged_user'] = this.edgeMediaToTaggedUser?.toJson();
    }
    data['fact_check_overall_rating'] = this.factCheckOverallRating;
    data['fact_check_information'] = this.factCheckInformation;
    data['gating_info'] = this.gatingInfo;
    if (this.sharingFrictionInfo != null) {
      data['sharing_friction_info'] = this.sharingFrictionInfo?.toJson();
    }
    data['media_overlay_info'] = this.mediaOverlayInfo;
    data['media_preview'] = this.mediaPreview;
    if (this.owner != null) {
      data['owner'] = this.owner?.toJson();
    }
    data['is_video'] = this.isVideo;
    data['has_upcoming_event'] = this.hasUpcomingEvent;
    data['accessibility_caption'] = this.accessibilityCaption;
    if (this.edgeMediaToCaption != null) {
      data['edge_media_to_caption'] = this.edgeMediaToCaption?.toJson();
    }
    if (this.edgeMediaToComment != null) {
      data['edge_media_to_comment'] = this.edgeMediaToComment?.toJson();
    }
    data['comments_disabled'] = this.commentsDisabled;
    data['taken_at_timestamp'] = this.takenAtTimestamp;
    if (this.edgeLikedBy != null) {
      data['edge_liked_by'] = this.edgeLikedBy?.toJson();
    }
    if (this.edgeMediaPreviewLike != null) {
      data['edge_media_preview_like'] = this.edgeMediaPreviewLike?.toJson();
    }
    data['location'] = this.location;
    data['thumbnail_src'] = this.thumbnailSrc;
    if (this.thumbnailResources != null) {
      data['thumbnail_resources'] =
          this.thumbnailResources?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
