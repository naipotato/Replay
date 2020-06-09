video_test_sources = files (
    'video-list-tests.vala',
)

video_test = executable (
    'video-test',
    video_test_sources,
    dependencies: utlib_dep,
    link_with: utlib
)

test (
    'video-test',
    video_test
)
