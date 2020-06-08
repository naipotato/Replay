/* UTLib - Yet another wrapper to the YouTube Data API v3.
 * Copyright (C) 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Utlib.VideoListRequest : Utlib.Request<Utlib.VideoListResponse> {

    public string part { get; private set; }
    public string chart { get; set; }
    public string id { get; set; }
    public string my_rating { get; set; }
    public string hl { get; set; }
    public uint max_height { get; set; }
    public uint max_results { get; set; }
    public uint max_width { get; set; }
    public string on_behalf_of_content_owner { get; set; }
    public string page_token { get; set; }
    public string region_code { get; set; }
    public string video_category_id { get; set; }

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

        this.params_service["part"] = new Utlib.Parameter () {
            name = "part",
            is_required = true,
            default_value = ""
        };
        this.params_service["chart"] = new Utlib.Parameter () {
            name = "chart",
            is_required = false,
            default_value = ""
        };
        this.params_service["id"] = new Utlib.Parameter () {
            name = "id",
            is_required = false,
            default_value = ""
        };
        this.params_service["my-rating"] = new Utlib.Parameter () {
            name = "myRating",
            is_required = false,
            default_value = ""
        };
        this.params_service["hl"] = new Utlib.Parameter () {
            name = "hl",
            is_required = false,
            default_value = ""
        };
        this.params_service["max-height"] = new Utlib.Parameter () {
            name = "maxHeight",
            is_required = false,
            default_value = ""
        };
        this.params_service["max-results"] = new Utlib.Parameter () {
            name = "maxResults",
            is_required = false,
            default_value = "5"
        };
        this.params_service["max-width"] = new Utlib.Parameter () {
            name = "maxWidth",
            is_required = false,
            default_value = ""
        };
        this.params_service["on-behalf-of-content-owner"] = new Utlib.Parameter () {
            name = "onBehalfOfContentOwner",
            is_required = false,
            default_value = ""
        };
        this.params_service["page-token"] = new Utlib.Parameter () {
            name = "pageToken",
            is_required = false,
            default_value = ""
        };
        this.params_service["region-code"] = new Utlib.Parameter () {
            name = "regionCode",
            is_required = false,
            default_value = ""
        };
        this.params_service["video-category-id"] = new Utlib.Parameter () {
            name = "videoCategoryId",
            is_required = false,
            default_value = "0"
        };
    }
}
