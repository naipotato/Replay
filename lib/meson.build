libinvidious_sources = [
  'Models/Instance.vala',
  'Models/Stats.vala',
  'Models/TrendingVideo.vala',
  'Models/VideoThumbnail.vala',

  'Requests/InstancesRequest.vala',
  'Requests/Request.vala',
  'Requests/TrendingRequest.vala',

  'Utils/Functions.vala',
  'Utils/RequestError.vala',
  'Utils/UriBuilder.vala',

  'InvidiousApi.vala',
]

libinvidious_deps = [
  gee_dep,
  gio_dep,
  gjson_dep,
  soup_dep,
]

libinvidious = library(
  'invidious',
  libinvidious_sources,

  dependencies : libinvidious_deps,
  install      : true,
)

libinvidious_dep = declare_dependency(
  link_with           : libinvidious,
  dependencies        : libinvidious_deps,
  include_directories : '.',
)
