libinvidious_sources = [
  'InvidiousApi.vala',
]

libinvidious_deps = [
  gio_dep,
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
