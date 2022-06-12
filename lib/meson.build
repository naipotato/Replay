libinvidious_sources = [
  'Requests/Request.vala',

  'Utils/Functions.vala',
  'Utils/RequestError.vala',
  'Utils/UriBuilder.vala',
  'Utils/UriQueryBuilder.vala',

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
