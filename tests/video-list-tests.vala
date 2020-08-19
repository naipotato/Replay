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
      "/utlib/video/list/by-video-id",
      () => {
        var loop = new MainLoop ();
        var request = client.videos.list ("snippet");
        request.id = "Ks-_Mh1QhMc";

        request.execute.begin ((obj, res) => {
          try {
            var response = request.execute.end (res);
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
      "/utlib/video/list/multiple-video-ids",
      () => {
        var loop = new MainLoop ();
        var request = client.videos.list ("snippet");
        request.id = "Ks-_Mh1QhMc,c0KYU2j0TM4,eIho2S0ZahI";

        request.execute.begin ((obj, res) => {
          try {
            var response = request.execute.end (res);
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
      "/utlib/video/list/most-popular-videos",
      () => {
        var loop = new MainLoop ();
        var request = client.videos.list ("snippet");
        request.chart = ChartEnum.MOST_POPULAR;
        request.region_code = "US";

        request.execute.begin ((obj, res) => {
          try {
            var response = request.execute.end (res);
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
      "/utlib/video/list/my-liked-videos",
      () => {}
    );

    Test.run ();
  }
}
