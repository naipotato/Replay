using Utlib;

class VideoListTests {

    static Client client = new Client () {
        api_key = Environment.get_variable ("API_KEY")
    };

    static void main (string[] args) {
        Test.init (ref args);

        // A dummy instance that we need due to a bug with static classes and
        // members not being initialized
        new VideoListTests ();

        Test.add_func (
            "/utlib/video/list/sync/by-video-id",
            () => {
                var request = client.videos.list ("snippet");
                request.id = "Ks-_Mh1QhMc";

                try {
                    var response = request.execute ();
                    assert (response.items.size == 1);
                    assert (response.items[0].id == request.id);
                } catch (Error e) {
                    assert_not_reached ();
                }
            }
        );

        Test.add_func (
            "/utlib/video/list/async/by-video-id",
            () => {
                var loop = new MainLoop ();
                var request = client.videos.list ("snippet");
                request.id = "Ks-_Mh1QhMc";

                request.execute_async.begin ((obj, res) => {
                    try {
                        var response = request.execute_async.end (res);
                        assert (response.items.size == 1);
                        assert (response.items[0].id == request.id);
                        loop.quit ();
                    } catch {
                        assert_not_reached ();
                    }
                });

                loop.run ();
            }
        );

        Test.add_func (
            "/utlib/video/list/sync/multiple-video-ids",
            () => {
                var request = client.videos.list ("snippet");
                request.id = "Ks-_Mh1QhMc,c0KYU2j0TM4,eIho2S0ZahI";

                try {
                    var response = request.execute ();
                    assert (response.items.size == 3);

                    var ids = new string[response.items.size];
                    for (var i = 0; i < response.items.size; i++) {
                        ids[i] = response.items[i].id;
                    }

                    assert (string.joinv (",", ids) == request.id);
                } catch (Error e) {
                    assert_not_reached ();
                }
            }
        );

        Test.add_func (
            "/utlib/video/list/async/multiple-video-ids",
            () => {
                var loop = new MainLoop ();
                var request = client.videos.list ("snippet");
                request.id = "Ks-_Mh1QhMc,c0KYU2j0TM4,eIho2S0ZahI";

                request.execute_async.begin ((obj, res) => {
                    try {
                        var response = request.execute_async.end (res);
                        assert (response.items.size == 3);

                        var ids = new string[response.items.size];
                        for (var i = 0; i < response.items.size; i++) {
                            ids[i] = response.items[i].id;
                        }

                        assert (string.joinv (",", ids) == request.id);
                        loop.quit ();
                    } catch (Error e) {
                        assert_not_reached ();
                    }
                });

                loop.run ();
            }
        );

        Test.add_func (
            "/utlib/video/list/sync/most-popular-videos",
            () => {
                var request = client.videos.list ("snippet");
                request.chart = "mostPopular";
                request.region_code = "US";

                try {
                    var response = request.execute ();
                    assert (response.items.size == 5);

                    foreach (var item in response.items) {
                        assert (item.kind == "youtube#video");
                    }
                } catch (Error e) {
                    assert_not_reached ();
                }
            }
        );

        Test.add_func (
            "/utlib/video/list/async/most-popular-videos",
            () => {
                var loop = new MainLoop ();
                var request = client.videos.list ("snippet");
                request.chart = "mostPopular";
                request.region_code = "US";

                request.execute_async.begin ((obj, res) => {
                    try {
                        var response = request.execute_async.end (res);
                        assert (response.items.size == 5);

                        foreach (var item in response.items) {
                            assert (item.kind == "youtube#video");
                        }

                        loop.quit ();
                    } catch (Error e) {
                        assert_not_reached ();
                    }
                });

                loop.run ();
            }
        );

        Test.add_func (
            "/utlib/video/list/sync/my-liked-videos",
            () => {
            }
        );

        Test.add_func (
            "/utlib/video/list/async/my-liked-videos",
            () => {
            }
        );

        Test.run ();
    }
}
