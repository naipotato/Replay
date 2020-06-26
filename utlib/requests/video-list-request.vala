/* UTLib - A YouTube Data API client library for Vala
 * Copyright (C) 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * UTLib is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * UTLib is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with UTLib.  If not, see <https://www.gnu.org/licenses/>.
 */

public enum Utlib.ChartEnum {
    UNSPECIFIED, MOST_POPULAR;
}

public enum Utlib.MyRatingEnum {
    NONE, DISLIKE, LIKE;
}

public class Utlib.VideoListRequest : Utlib.Request<Utlib.VideoListResponse> {

    public string? part { get; private set; }
    public Utlib.ChartEnum chart { get; set; }
    public string? id { get; set; }
    public Utlib.MyRatingEnum my_rating { get; set; }
    public string? hl { get; set; }
    public int max_height { get; set; }
    public int max_results { get; set; default = 5; }
    public int max_width { get; set; }
    public string? on_behalf_of_content_owner { get; set; }
    public string? page_token { get; set; }
    public string? region_code { get; set; }
    public string? video_category_id { get; set; default = "0"; }

    public override string url {
        get {
            return "https://www.googleapis.com/youtube/v3/videos";
        }
    }


    internal VideoListRequest (Utlib.Client client, string part) {
        base (client);
        this.part = part;
        this.init_parameters ();
    }

    protected override void init_parameters () {
        base.init_parameters ();

        this.params_service["part"] = new Utlib.Parameter ("part", true);
        this.params_service["chart"] = new Utlib.Parameter ("chart");
        this.params_service["id"] = new Utlib.Parameter ("id");
        this.params_service["my-rating"] = new Utlib.Parameter ("myRating");
        this.params_service["hl"] = new Utlib.Parameter ("hl");
        this.params_service["max-height"] = new Utlib.Parameter ("maxHeight");
        this.params_service["max-results"] = new Utlib.Parameter ("maxResults");
        this.params_service["max-width"] = new Utlib.Parameter ("maxWidth");
        this.params_service["on-behalf-of-content-owner"] = new Utlib.Parameter ("onBehalfOfContentOwner");
        this.params_service["page-token"] = new Utlib.Parameter ("pageToken");
        this.params_service["region-code"] = new Utlib.Parameter ("regionCode");
        this.params_service["video-category-id"] = new Utlib.Parameter ("videoCategoryId");
    }
}
